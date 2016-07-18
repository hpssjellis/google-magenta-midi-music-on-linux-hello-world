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



bazel run //magenta/models/lookback_rnn:lookback_rnn_create_dataset -- \
--input=/tmp/notesequences.tfrecord \
--train_output=/tmp/lookback_rnn/sequence_examples/training_melodies.tfrecord \
--eval_output=/tmp/lookback_rnn/sequence_examples/eval_melodies.tfrecord \
--eval_ratio=0.10






TRAIN_DATA=/tmp/training_melodies.tfrecord


./bazel-bin/magenta/models/lookback_rnn/lookback_rnn_train \
--run_dir=/tmp/lookback_rnn/logdir/run1 \
--sequence_example_file=/tmp/lookback_rnn/sequence_examples/training_melodies.tfrecord \
--hparams="{'batch_size':64,'rnn_layer_sizes':[64,64]}" \
--num_training_steps=200





# Provide a MIDI file to use as a primer for the generation.
# The MIDI should just contain a short monophonic melody.
# primer.mid is provided as an example.

# --primer_melody="[60, -2, 60, -2, 67, -2, 67, -2]" would prime the model with the first four notes of Twinkle Twinkle Little Star. 
#Instead of using --primer_melody, 
# we can use --primer_midi to prime our model with a melody stored in a MIDI file.

#--primer_midi=~/mymagenta/magenta/magenta/models/shared/primer.mid




bazel run //magenta/models/lookback_rnn:lookback_rnn_generate -- \
--run_dir=/tmp/lookback_rnn/logdir/run1 \
--hparams="{'batch_size':64,'rnn_layer_sizes':[64,64]}" \
--output_dir=/tmp/lookback_rnn/generated \
--num_outputs=1 \
--num_steps=640 \
--primer_melody="[60]"



