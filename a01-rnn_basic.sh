#!/bin/bash

MIDI_DIRECTORY=~/mymagenta/magenta/magenta/testdata


# TFRecord file that will contain NoteSequence protocol buffers.
SEQUENCES_TFRECORD=/tmp/notesequences.tfrecord


bazel run //magenta/scripts:convert_midi_dir_to_note_sequences -- \
--midi_dir=$MIDI_DIRECTORY \
--output_file=$SEQUENCES_TFRECORD \
--recursive




# TFRecord file containing NoteSequence protocol buffers from convert_midi_dir_to_note_sequences.py.
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

bazel run //magenta/models/basic_rnn:basic_rnn_create_dataset -- \
--input=$SEQUENCES_TFRECORD \
--output_dir=$DATASET_DIR \
--eval_ratio=$EVAL_RATIO










./bazel-bin/magenta/models/basic_rnn/basic_rnn_train --run_dir=/tmp/basic_rnn/logdir/run1 --sequence_example_file=$TRAIN_DATA --hparams='{"rnn_layer_sizes":[50]}' --num_training_steps=40





# Provide a MIDI file to use as a primer for the generation.
# The MIDI should just contain a short monophonic melody.

# --primer_melody="[60, -2, 60, -2, 67, -2, 67, -2]" would prime the model with the first four notes of Twinkle Twinkle Little Star. 
#Instead of using --primer_melody, 
# we can use --primer_midi to prime our model with a melody stored in a MIDI file.

#--primer_midi=~/mymagenta/magenta/magenta/models/shared/primer.mid
# --primer_melody="[60, -2, 60, -2, 67, -2, 67, -2]"

# or leave it blank and a random first note will be chosen.





bazel run //magenta/models/basic_rnn:basic_rnn_generate -- \
--run_dir=/tmp/basic_rnn/logdir/run1 \
--hparams='{"rnn_layer_sizes":[50]}' \
--output_dir=/tmp/basic_rnn_generated \
--num_steps=640 \
--num_outputs=1 

#\
#--primer_midi=~/mymagenta/magenta/magenta/models/shared/primer.mid

