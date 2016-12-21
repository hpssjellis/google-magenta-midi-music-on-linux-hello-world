#!/bin/bash





# By Jeremy Ellis and Jeremy Sawruk

# Only use variables for information in more than one Bazel run!

echo "Either comment out the read and hard code the main path or"
echo "Command 'pwd' gives you your folder full path"
echo "Enter the folder path that magenta was cloned to"


read MAIN_PATH

#MAIN_PATH=~/mymagenta




TEMP_PATH=/tmp/melody_rnn






##########################  Extract the midi files    ############################################






INPUT_DIRECTORY=${MAIN_PATH}/magenta/magenta/testdata

# TFRecord file that will contain NoteSequence protocol buffers.
SEQUENCES_TFRECORD=${TEMP_PATH}/sequence_examples/notesequences.tfrecord


# convert_dir_to_note_sequences is a python program to extract midi files into note sequences format
# --input_dir folder with subfolders with your midi files
# --output_file location to store the note_sequence file
# 


bazel run //magenta/scripts:convert_dir_to_note_sequences -- \
  --input_dir=$INPUT_DIRECTORY \
  --output_file=$SEQUENCES_TFRECORD \
  --recursive





######################### Create dataset #########################################################




#/tmp/melody_rnn/sequence_examples

# Where training and evaluation datasets will be written
# DATASET_DIR=/tmp/basic_rnn/sequence_examples
#DATASET_DIR=/home/ubuntu/workspace/magenta/magenta/testdata
DATASET_DIR=${TEMP_PATH}/sequence_examples

# Output of the training dataset
TRAIN_DATA=$DATASET_DIR/training_melodies.tfrecord

# Output of the evaluation dataset (optional)
EVAL_DATA=$DATASET_DIR/eval_melodies.tfrecord

# Fraction of the training set that will be written to the evaluation dataset
EVAL_RATIO=0.10

# Generate the data
#./bazel-bin/magenta/models/melody_rnn/melody_rnn_create_dataset \

#--config='basic_rnn' \

bazel run //magenta/models/melody_rnn:melody_rnn_create_dataset -- \
--config='basic_rnn' \
--input=$SEQUENCES_TFRECORD \
--output_dir=$DATASET_DIR \
--log=DEBUG \
--eval_ratio=$EVAL_RATIO





######################### Train dataset #########################################################




# 2. Train the RNN

# Experiment directory
#EXPERIMENT_DIR=/tmp/melody_rnn/logdir
#EXPERIMENT_DIR=/home/ubuntu/workspace/magenta/tmp/melody_rnn/logdir/run1
EXPERIMENT_DIR=${TEMP_PATH}/logdir/run1

# Hyperparameter settings (in this case, size of RNN layers)
HYPERPARAMETER_STRING="{'batch_size':64,'rnn_layer_sizes':[64,64]}"

# Number of training iterations
NUM_TRAINING_STEPS=50

bazel run //magenta/models/melody_rnn:melody_rnn_train -- \
--config='basic_rnn' \
--run_dir=$EXPERIMENT_DIR \
--sequence_example_file=$TRAIN_DATA \
--hparams="{'batch_size':64,'rnn_layer_sizes':[64,64]}" \
--log=DEBUG \
--num_training_steps=$NUM_TRAINING_STEPS





############################### Generate your midi files ####################################################




#PRIMER_PATH=/Users/jsawruk/magenta/magenta/models/shared/primer.mid

bazel run //magenta/models/melody_rnn:melody_rnn_generate -- \
--config='basic_rnn' \
--run_dir=${TEMP_PATH}/logdir/run1 \
--hparams="{'batch_size':64,'rnn_layer_sizes':[64,64]}" \
--output_dir=${TEMP_PATH}/generated \
--num_outputs=2 \
--num_steps=640 \
--primer_melody="[60, -2, 60, -2, 67, -2, 67, -2]"




