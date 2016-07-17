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

# TFRecord file that TensorFlow's SequenceExample protos will be written to. This is the training dataset.
TRAIN_DATA=/tmp/training_melodies.tfrecord

# Optional evaluation dataset. Also, a TFRecord file containing SequenceExample protos.
EVAL_DATA=/tmp/evaluation_melodies.tfrecord

# Fraction of input data that will be written to the eval dataset (if eval_output flag is set).
EVAL_RATIO=0.10

# Name of the encoder to use. See magenta/lib/encoders.py.
#ENCODER=basic_one_hot_encoder





bazel run //magenta/models/basic_rnn:basic_rnn_create_dataset -- \
--input=$SEQUENCES_TFRECORD \
--train_output=$TRAIN_DATA \
--eval_output=$EVAL_DATA \
--eval_ratio=$EVAL_RATIO








TRAIN_DATA=/tmp/training_melodies.tfrecord



./bazel-bin/magenta/models/basic_rnn/basic_rnn_train --run_dir=/tmp/basic_rnn/logdir/run1 --sequence_example_file=$TRAIN_DATA --hparams='{"rnn_layer_sizes":[50]}' --num_training_steps=200






# Provide a MIDI file to use as a primer for the generation.
# The MIDI should just contain a short monophonic melody.
# primer.mid is provided as an example.
PRIMER_PATH=~/mymagenta/magenta/magenta/models/basic_rnn/primer.mid

bazel run //magenta/models:basic_rnn_generate -- \
--experiment_run_dir=/tmp/basic_rnn/run1 \
--hparams='{"rnn_layer_sizes":[50]}' \
--primer_midi=$PRIMER_PATH \
--output_dir=/tmp/basic_rnn_generated \
--num_steps=640 \
--num_outputs=1


echo ""
echo "Hopefully everything worked"
echo "Look in the folder /tmp/basic_rnn_generated to see yout output"
echo "I copy the files to Google Drive and use iCloud to play them, but try whatever works for you."

