#!/bin/bash

MIDI_DIRECTORY=~/mymagenta/magenta/magenta/testdata






# TFRecord file containing NoteSequence protocol buffers from convert_midi_dir_to_note_sequences.py.
SEQUENCES_TFRECORD=/tmp/notesequences.tfrecord

# TFRecord file that TensorFlow's SequenceExample protos will be written to. This is the training dataset.
TRAIN_DATA=/tmp/basic_rnn/sequence_examples/training_melodies.tfrecord

# Optional evaluation dataset. Also, a TFRecord file containing SequenceExample protos.
EVAL_DATA=/tmp/basic_rnn/sequence_examples/eval_melodies.tfrecord

# Fraction of input data that will be written to the eval dataset (if eval_output flag is set).
# normally set at 0.10
EVAL_RATIO=0

# Name of the encoder to use. See magenta/lib/encoders.py.
#ENCODER=basic_one_hot_encoder








# note this training goes from 200 to 500 loops

./bazel-bin/magenta/models/basic_rnn/basic_rnn_train --run_dir=/tmp/basic_rnn/logdir/run1 --sequence_example_file=$TRAIN_DATA --hparams='{"rnn_layer_sizes":[50]}' --num_training_steps=500






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
--num_outputs=1 \
--primer_midi=~/mymagenta/magenta/magenta/models/shared/primer.mid



