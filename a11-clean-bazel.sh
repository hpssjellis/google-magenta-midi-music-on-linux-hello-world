#!/bin/bash

echo "get Bazel working well"
bazel clean
bazel shutdown
bazel fetch //magenta/...
bazel build //magenta/...
bazel test //magenta/...
