#!/bin/bash

MIDI_DIRECTORY=~/mymagenta/magenta/magenta/testdata


# TFRecord file that will contain NoteSequence protocol buffers.
SEQUENCES_TFRECORD=/tmp/notesequences.tfrecord

bazel run //magenta:convert_midi_dir_to_note_sequences -- \
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
ENCODER=basic_one_hot_encoder

bazel run //magenta:convert_sequences_to_melodies -- \
--input=$SEQUENCES_TFRECORD \
--train_output=$TRAIN_DATA \
--eval_output=$EVAL_DATA \
--eval_ratio=$EVAL_RATIO \
--encoder=$ENCODER











TRAIN_DATA=/tmp/training_melodies.tfrecord



./bazel-bin/magenta/models/basic_rnn_train --experiment_run_dir=/tmp/basic_rnn/run1 --sequence_example_file=$TRAIN_DATA --eval=false --hparams='{"rnn_layer_sizes":[50]}' --num_training_steps=200








# Provide a MIDI file to use as a primer for the generation.
# The MIDI should just contain a short monophonic melody.
# primer.mid is provided as an example.
PRIMER_PATH=~/mymagenta/magenta/magenta/models/basic_rnn/primer.mid

bazel run //magenta/models:basic_rnn_generate -- \
--experiment_run_dir=/tmp/basic_rnn/run1 \
--hparams='{"rnn_layer_sizes":[50]}' \
--primer_midi=$PRIMER_PATH \
--output_dir=/tmp/basic_rnn_generated \
--num_steps=64 \
--num_outputs=2


echo "install a midi player like timidity"
echo ""
echo "play it using the command line"
echo "timidity basic_run_sample_0.mid"
echo "or copy it to an online midi site such as https://onlinesequencer.net/"

cd /tmp/basic_rnn_generated

ls


