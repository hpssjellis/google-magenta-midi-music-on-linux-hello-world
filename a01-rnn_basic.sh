#!/bin/bash

#when this file is saved as a01-rnn_basic.sh it can be run by typing (without the #) in the command line 
#bash a01-rnn_basic.sh

#First all the variables and what they do

#location of all your midi files to be included in this run
MIDI_DIRECTORY=~/mymagenta/magenta/magenta/testdata

# TFRecord file that will contain NoteSequence protocol buffers.
SEQUENCES_TFRECORD=/tmp/notesequences.tfrecord

# Where training and evaluation datasets will be written.
DATASET_DIR=/tmp/basic_rnn/sequence_examples

# TFRecord file that TensorFlow's SequenceExample protos will be written to. This is the training dataset.
TRAIN_DATA=$DATASET_DIR/training_melodies.tfrecord

# Optional evaluation dataset. Also, a TFRecord file containing SequenceExample protos.
EVAL_DATA=$DATASET_DIR/eval_melodies.tfrecord

# Fraction of input data that will be written to the eval dataset (if eval_output flag is set).
# normal is 0.10
EVAL_RATIO=0

# location of the latest run and checkpoints
RUN_DIR=/tmp/basic_rnn/logdir/run1

# Special parameters sent to train and generate your midi files
HPARAMS='{"rnn_layer_sizes":[50]}'

# The directory where the final generated set of midi files will be saved 
OUTPUT_MIDI_DIR=/tmp/basic_rnn_generated


# --primer_melody="[60, -2, 60, -2, 67, -2, 67, -2]" would prime the model with the first four notes of Twinkle Twinkle Little Star. 
#Instead of using --primer_melody, 
# we can use --primer_midi to prime our model with a melody stored in a MIDI file.

#--primer_midi=~/mymagenta/magenta/magenta/models/shared/primer.mid
# --primer_melody="[60, -2, 60, -2, 67, -2, 67, -2]"

# or leave it blank and a random first note will be chosen.


# 
$PRIMER_MIDI=~/mymagenta/magenta/magenta/models/shared/primer.mid


#-----------------------------------------now the actual Bazel runs---------------------------------


bazel run //magenta/scripts:convert_midi_dir_to_note_sequences -- \
--midi_dir=$MIDI_DIRECTORY \
--output_file=$SEQUENCES_TFRECORD \
--recursive





bazel run //magenta/models/basic_rnn:basic_rnn_create_dataset -- \
--input=$SEQUENCES_TFRECORD \
--output_dir=$DATASET_DIR \
--eval_ratio=$EVAL_RATIO










./bazel-bin/magenta/models/basic_rnn/basic_rnn_train -- \
--run_dir=$RUN_DIR \
--sequence_example_file=$TRAIN_DATA \
--hparams=$HPARAMS \
--num_training_steps=40





# Provide a MIDI file to use as a primer for the generation.
# The MIDI should just contain a short monophonic melody.

# --primer_melody="[60, -2, 60, -2, 67, -2, 67, -2]" would prime the model with the first four notes of Twinkle Twinkle Little Star. 
#Instead of using --primer_melody, 
# we can use --primer_midi to prime our model with a melody stored in a MIDI file.

#--primer_midi=~/mymagenta/magenta/magenta/models/shared/primer.mid
# --primer_melody="[60, -2, 60, -2, 67, -2, 67, -2]"

# or leave it blank and a random first note will be chosen.





bazel run //magenta/models/basic_rnn:basic_rnn_generate -- \
--run_dir=$RUN_DIR \
--hparams=$HPARAMS \
--output_dir=$OUTPUT_MIDI_DIR \
--num_steps=640 \
--num_outputs=1 \
--temperature=1 \
--bpm=120



#\
#--primer_midi=$PRIMER_MIDI
#or 
# --primer_melody="[60, -2, 60, -2, 67, -2, 67, -2]"
# or leave it blank to randomly generate a starting note.
