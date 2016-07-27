#!/bin/bash

MIDI_DIRECTORY=~/mymagenta/magenta/magenta/testdata


# TFRecord file that will contain NoteSequence protocol buffers.
SEQUENCES_TFRECORD=/tmp/notesequences.tfrecord


bazel run //magenta/scripts:convert_midi_dir_to_note_sequences -- \
--midi_dir=$MIDI_DIRECTORY \
--output_file=$SEQUENCES_TFRECORD \
--recursive











bazel run //magenta/models/lookback_rnn:lookback_rnn_create_dataset -- \
--input=/tmp/notesequences.tfrecord \
--output_dir=/tmp/lookback_rnn/sequence_examples \
--eval_ratio=0





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



