#!/bin/bash





# By Jeremy Ellis with help from Jeremy Sawruk




echo "Assuming Magenta was installed into the ~/mymagenta folder, if not fix MAIN_PATH variable below in the CODE";

MAIN_PATH=~/mymagenta



#echo "Either comment out the read and hard code the main path or"
#echo "Command 'pwd' gives you your folder full path"
#echo "Enter the folder path that magenta was cloned into"
#read MAIN_PATH






TEMP_PATH=/tmp/melody_rnn






##########################  Extract the midi files    ############################################









# convert_dir_to_note_sequences is a python program to extract midi files into note sequences format
# --input_dir folder with subfolders with your midi files

INPUT_DIRECTORY=${MAIN_PATH}/magenta/magenta/testdata

# --output_file location to store the note_sequence file

# TFRecord file that will contain NoteSequence protocol buffers.
SEQUENCES_TFRECORD=${TEMP_PATH}/sequence_examples/notesequences.tfrecord



bazel run //magenta/scripts:convert_dir_to_note_sequences -- \
  --input_dir=$INPUT_DIRECTORY \
  --output_file=$SEQUENCES_TFRECORD \
  --recursive





######################### Create dataset #########################################################



# melody_rnn_create_dataset  used to generate the data
#--config='basic_rnn'  or several others to choose from
#--input=  input the TF record
#--output_dir= for both training and evaluation

# Output of the training dataset
TRAIN_DATA=$DATASET_DIR/training_melodies.tfrecord

# Output of the evaluation dataset (optional)
EVAL_DATA=$DATASET_DIR/eval_melodies.tfrecord

#--log=DEBUG several other options
#--eval_ratio=  Fraction of the training set that will be written to the evaluation dataset


DATASET_DIR=${TEMP_PATH}/sequence_examples



bazel run //magenta/models/melody_rnn:melody_rnn_create_dataset -- \
--config='basic_rnn' \
--input=$SEQUENCES_TFRECORD \
--output_dir=$DATASET_DIR \
--log=DEBUG \
--eval_ratio=0.10





######################### Train dataset #########################################################




# 2. Train the RNN

EXPERIMENT_DIR=${TEMP_PATH}/logdir/run1

# Hyperparameter settings (in this case, size of RNN layers)
HYPERPARAMETER_STRING="{'batch_size':64,'rnn_layer_sizes':[64,64]}"


bazel run //magenta/models/melody_rnn:melody_rnn_train -- \
--config='basic_rnn' \
--run_dir=$EXPERIMENT_DIR \
--sequence_example_file=$TRAIN_DATA \
--hparams=$HYPERPARAMETER_STRING \
--log=DEBUG \
--num_training_steps=50





############################### Generate your midi files ####################################################




#--primer_path=~mymagenta/magenta/magenta/models/shared/primer.mid

bazel run //magenta/models/melody_rnn:melody_rnn_generate -- \
--config='basic_rnn' \
--run_dir=${TEMP_PATH}/logdir/run1 \
--hparams=$HYPERPARAMETER_STRING \
--output_dir=${TEMP_PATH}/generated \
--num_outputs=2 \
--num_steps=640 \
--primer_melody="[60, -2, 60, -2, 67, -2, 67, -2]"



