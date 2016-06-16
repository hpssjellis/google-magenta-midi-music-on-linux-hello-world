#!/bin/bash




# Provide a MIDI file to use as a primer for the generation.
# The MIDI should just contain a short monophonic melody.
# primer.mid is provided as an example.
PRIMER_PATH=~/mymagenta/magenta/magenta/models/basic_rnn/primer.mid

bazel run //magenta/models:basic_rnn_generate -- \
--experiment_run_dir=/tmp/basic_rnn/run1 \
--hparams='{"rnn_layer_sizes":[50]}' \
--primer_midi=$PRIMER_PATH \
--output_dir=/tmp/basic_rnn_generated \
--num_steps=650 \
--num_outputs=1


echo "install a midi player like timidity"
echo ""
echo "play it using the command line"
echo "timidity basic_run_sample_0.mid"
echo "or copy it to an online midi site such as https://onlinesequencer.net/"

