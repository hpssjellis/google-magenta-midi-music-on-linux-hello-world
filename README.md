# google-magenta-midi-music-on-linux-hello-world
Bash install scripts to get Google Magenta working easily on a linux ubuntu computer. Move from a folder with several midi files to a tensorflow generated set of output files. 


June 14, 2016 (evening) Darn. Murphy's Law. The day I tweet that this site is up and running https://github.com/tensorflow/magenta changed something that broke my script! For some reason this code does not work. I know **lib/encoders.py** has been renamed to **lib/basic_one_hot_encoder_test.py** but that should not be relevant. The script can't seem to find **convert_sequences_to_melodies**


~~~

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



~~~





June 14, 2016 (morning)

This works, still testing it. No idea if it will work on your computer but it does work on my ubuntu version 15.10 laptop


1. basically open a terminal (right click-->open Terminal) and git clone this repo

```
git clone https://github.com/hpssjellis/google-magenta-midi-music-on-linux-hello-world.git
```

1. Then go into the repository and run setup.sh (use auto fill so you don't have to type the long name)

```
cd google-magenta-midi-music-on-linux-hello-world

bash setup.sh
```

1. Theoretically that should be it. **setup.sh** installs into a home folder called mymagenta a folder called Google Magenta. It also installs bazel and tensorflow. Sets up some symlinks in the magenta workspace, builds a few extra folders. If all goes well it runs the bash file **a01-helloworld.sh** which runs a combined set of the example programs with only 200 interactions instead of 20000. Then it finally activates tensorboard

Your final 5 midi examples end up in the **/tmp/basic_rnn_generated** folder and then copy the midi files to however you want to play them. I installed timidity to play the midi files but have now started using https://onlinesequencer.net/


Then start using your own midi files and your own primer.mid file and change variables and iterations. I would like to make another helloWorld that tidies up where all these temporary files go, presently it is a mess for beginners







Use at your own risk

By Jeremy Ellis

Maker of http://rocksetta.com

Twitter @rocksetta


