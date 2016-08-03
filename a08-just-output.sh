#!/bin/bash







# Provide a MIDI file to use as a primer for the generation.
# The MIDI should just contain a short monophonic melody.

# --primer_melody="[60, -2, 60, -2, 67, -2, 67, -2]" would prime the model with the first four notes of Twinkle Twinkle Little Star. 
#Instead of using --primer_melody, 
# we can use --primer_midi to prime our model with a melody stored in a MIDI file.

#--primer_midi=~/mymagenta/magenta/magenta/models/shared/primer.mid
# --primer_melody="[60, -2, 60, -2, 67, -2, 67, -2]"

# or leave it blank and a random first note will be chosen.

#Optionals
# --temperature=1 randomness of the generated output
# --bpm=beats per minute
# --log=INFO Valid values: DEBUG, INFO (default), WARN, ERROR, or FATAL.



bazel run //magenta/models/basic_rnn:basic_rnn_generate -- \
--run_dir=/tmp/basic_rnn/logdir/run1 \
--hparams='{"rnn_layer_sizes":[50]}' \
--output_dir=/tmp/basic_rnn_generated \
--num_steps=640 \
--num_outputs=1 \
--temperature=1 \
--bpm=120 \
--log=DEBUG


#--primer_midi=~/mymagenta/magenta/magenta/models/shared/primer.mid
#--primer_melody="[60, -2, 60, -2, 67, -2, 67, -2]"

