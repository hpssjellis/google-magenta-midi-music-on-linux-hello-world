#!/bin/bash

#when this file is saved as a01-rnn_basic.sh it can be run by typing (without the #) in the command line 
#bash a01-rnn_basic.sh

#Variables are only used when they show up in multiple locations


# TFRecord file that will contain NoteSequence protocol buffers.
SEQUENCES_TFRECORD=/tmp/notesequences.tfrecord

# Where training and evaluation datasets will be written.
DATASET_DIR=/tmp/basic_rnn/sequence_examples

# location of the latest run and checkpoints
RUN_DIR=/tmp/basic_rnn/logdir/run1

# Special parameters sent to train and generate your midi files
HPARAMS='{"rnn_layer_sizes":[50]}'

# The directory where the final generated set of midi files will be saved 
OUTPUT_MIDI_DIR=/tmp/basic_rnn_generated




#-----------------------------------------now the actual Bazel runs---------------------------------



# convert_midi_dir_to_note_sequences  Converts all midi files in the folder into note sequences
#--midi_dir=The directory that contains your midi files to run
#--output_file=The file that the notesequences are stored in as a .tfrecord
#--recursive so that it loops through all folders and all files in the midi-dir


bazel run //magenta/scripts:convert_midi_dir_to_note_sequences -- \
--midi_dir=~/mymagenta/magenta/magenta/testdata \
--output_file=$SEQUENCES_TFRECORD \
--recursive



# basic_rnn_create_dataset Creates the dataset for the rnn
#--input=The file that the notesequences are stored in as a .tfrecord
#--output_dir=Where training and evaluation datasets will be written.
#--eval_ratio=Ratio of Training to evaluation datasets



bazel run //magenta/models/basic_rnn:basic_rnn_create_dataset -- \
--input=$SEQUENCES_TFRECORD \
--output_dir=$DATASET_DIR \
--eval_ratio=$EVAL_RATIO









# basic_rnn_train 
#--run_dir=location of the latest run and checkpoints
#--sequence_example_file=location of the training melodies
#--hparams=comma seperated list of hparameters
#--num_training_steps=number of training loops


./bazel-bin/magenta/models/basic_rnn/basic_rnn_train -- \
--run_dir=$RUN_DIR \
--sequence_example_file=$DATASET_DIR/training_melodies.tfrecord \
--hparams=$HPARAMS \
--num_training_steps=2000




#bazel run //magenta/models/basic_rnn:basic_rnn_generate -- \
#--run_dir=$RUN_DIR \
#--hparams=$HPARAMS \
#--output_dir=/tmp/basic_rnn_generated \
#--num_steps=640 \
#--num_outputs=1 \
#--temperature=1 \
#--bpm=120


bazel run //magenta/models/basic_rnn:basic_rnn_generate -- \
--run_dir=$RUN_DIR \
--hparams=$HPARAMS \
--output_dir=/tmp/basic_rnn_generated \
--num_steps=640 \
--num_outputs=1 \
--temperature=1 \
--bpm=120



#\
#--primer_midi=~/mymagenta/magenta/magenta/models/shared/primer.mid
#or 
# --primer_melody="[60, -2, 60, -2, 67, -2, 67, -2]"
# or leave it blank to randomly generate a starting note.
