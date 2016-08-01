#!/bin/bash


#This file may be run in parrallel with the training run.

# Where training and evaluation datasets will be written.
DATASET_DIR=/tmp/basic_rnn/sequence_examples


#bazel build //magenta/models/basic_rnn:basic_rnn_train



#Can also build and run using a different terminal so it runs in parallel
./bazel-bin/magenta/models/basic_rnn/basic_rnn_train --run_dir=/tmp/basic_rnn/logdir/run1 --sequence_example_file=$DATASET_DIR/eval_melodies.tfrecord --hparams='{"rnn_layer_sizes":[50]}' --num_training_steps=20000 --eval

