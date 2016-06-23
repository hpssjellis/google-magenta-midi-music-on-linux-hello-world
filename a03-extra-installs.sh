#!/bin/bash

# installs git and timidity if you don't already have it


# if you don't have git try

echo "Installing Git"
sudo apt-get install git




# if you don't have a midi player try 

echo "Installing timidity"
sudo apt-get install timidity
sudo apt-get install lame

# may need to use 
#sudo apt-get install freepats timidity timidity-interfaces-extra

echo "run timidity in the /tmp/basic_rnn_generated with the command"
cd /tmp/basic_rnn_generated
echo "timidity basic_rnn_sample_0.mid"
echo "I prefer copying the files to google drive and using iCloud to play them"
echo "Have not yet found a good midi editor to create and clip midi files"
echo "To convert mid to mps run"
echo "timidity basic_rnn_sample_0.mid -Ow -o - | lame - -b 64 a01out.mp3"


