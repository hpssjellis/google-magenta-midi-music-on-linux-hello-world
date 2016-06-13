#!/bin/bash  

#  only need to run this script with the command (do not type the #)
#  bash setup.sh
#  best in cloud 9 to just right click this file and select run


#commented out batch files aer from another github site at https://github.com/hpssjellis/TensorFlow-Android-Camera-Demo-on-Cloud9
echo "Installs Magenta to a folder in your home directory called mymagenta"




mkdir ~/mymagenta

cd ~/mymagenta

#bash a02-rocksetta-gcc-java8.sh

#bash a03-rocksetta-bazel.sh



echo "Now trying Bazel"
#read -p "Press [Enter] key to start "


#https://github.com/bazelbuild/bazel/releases/download/0.1.2/bazel-0.1.2-jdk7-installer-linux-x86_64.sh



#wget --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u20-b26/jdk-8u20-linux-x64.tar.gz



#git clone https://github.com/bazelbuild/bazel.git


#cd bazel
#bash compile.sh

#cd ..




#https://github.com/bazelbuild/bazel/releases/download/0.1.2/bazel-0.1.2-jdk7-installer-linux-x86_64.sh

#mkdir /home/ubuntu/workspace/bazel

#wget https://github.com/bazelbuild/bazel/releases/download/0.1.2/bazel-0.1.2-jdk7-installer-linux-x86_64.sh -O /home/ubuntu/workspace/bazel/bazel-0.1.2-jdk7-installer-linux-x86_64.sh

#cd /home/ubuntu/workspace/bazel

#chmod a+x bazel-0.1.2-jdk7-installer-linux-x86_64.sh
#bash bazel-0.1.2-jdk7-installer-linux-x86_64.sh --bin=/home/ubuntu/workspace/bazel/bin --base=/home/ubuntu/workspace/bazel/.bazel --bazelrc=/home/ubuntu/workspace/bazel/.bazelrc

#rm bazel-0.1.2-jdk7-installer-linux-x86_64.sh

#cd /home/ubuntu/workspace/bazel/.bazel/bin
#chmod a+x bazel


sudo apt-get  -y install software-properties-common
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get -y install oracle-java8-installer pkg-config zip g++ zlib1g-dev unzip

mkdir ~/mymagenta/bazel
cd ~/mymagenta/bazel

#wget https://github.com/bazelbuild/bazel/releases/download/0.2.3/bazel-0.2.3-installer-linux-x86_64.sh 

wget https://github.com/bazelbuild/bazel/releases/download/0.2.3/bazel-0.2.3-installer-linux-x86_64.sh -O ~/mymagenta/bazel/bazel-0.2.3-installer-linux-x86_64.sh
#chmod +x bazel-0.2.3-installer-linux-x86_64.sh

#bash bazel-0.2.3-installer-linux-x86_64.sh --user --bin=bin --base=.
sudo bash bazel-0.2.3-installer-linux-x86_64.sh --user

#bash bazel-0.2.3-installer-linux-x86_64.sh --user --bin=${IDEDIR}/bin
export PATH="$PATH:~/bin"
rm bazel-0.2.3-installer-linux-x86_64.sh

#./bazel-0.1.5-jdk7-installer-linux-x86_64.sh --user --bin=${IDEDIR}/bin --base=${IDEDIR}/bazelbase


#ln -s /home/ubuntu/.bazel/bin /home/ubuntu/workspace/hidden-bazel



bazel -h



printf "\n\nexport PATH=\$PATH:~/bin"  >> ~/.bashrc

#printf "\n\nsource ./bin/bazel-complete.bash"  >> ~/.profile








#echo "exporting the Path to my .profile file so other terminals have the path"

#printf "\n\nexport BAZEL_HOME=/home/ubuntu/workspace/bazel/.bazel\nexport PATH=\$PATH:\$BAZEL_HOME/bin"  >> ~/.profile


#echo "exporting the path so that the next command works"


#export BAZEL_HOME=/home/ubuntu/workspace/bazel/.bazel
#export PATH=$PATH:$BAZEL_HOME/bin


#Lets try to update bazel

#sudo apt-get upgrade bazel


cd ~/mymagenta


echo "----------------Bazel Done----------------------------------------------"
echo ". "





#bash a04-rocksetta-android-sdk.sh


#bash a06-rocksetta-setup-android.sh


#bash a07-rocksetta-gradle.sh


#bash a08-rocksetta-paths.sh

#bash a09-rocksetta-tensorflow.sh



sudo apt-get -y install python-pip python-dev python-virtualenv libblas-dev liblapack-dev libatlas-base-dev gfortran


echo "make the tensorflow environment"

virtualenv --system-site-packages ~/virtual-tf

echo "--------------------------------------------------------------"
echo ". "







echo "Activate the environemtn use deactivate to get your cursor back"
source ~/virtual-tf/bin/activate 

printf "\n\nsource ~/virtual-tf/bin/activate "  >> ~/.bashrc
printf "\necho 'enter   deactivate    to get out of the virtual enviroment'"  >> ~/.bashrc

echo "Now get TensorFlow"

cd ~/mymagenta

#sudo pip install --upgrade http://ci.tensorflow.org/view/Nightly/job/nightly-matrix-cpu/TF_BUILD_CONTAINER_TYPE=CPU,TF_BUILD_IS_OPT=OPT,TF_BUILD_IS_PIP=PIP,TF_BUILD_PYTHON_VERSION=PYTHON2,label=cpu-slave/lastSuccessfulBuild/artifact/pip_test/whl/tensorflow-0.8.0-cp27-none-linux_x86_64.whl

#git clone --recurse-submodules https://github.com/tensorflow/tensorflow /home/ubuntu/workspace/tensorflow/tensorflow

#sudo pip install --upgrade https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.8.0-cp27-none-linux_x86_64.whl


#new version

sudo pip install https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.9.0rc0-cp27-none-linux_x86_64.whl




#echo "Now download the image sets"


#wget https://storage.googleapis.com/download.tensorflow.org/models/inception5h.zip -O /tmp/inception5h.zip

#unzip /tmp/inception5h.zip -d /home/ubuntu/workspace/tensorflow/tensorflow/examples/android/assets/


#rm /tmp/inception5h.zip



echo "exporting the Path to my .profile file so other terminals have the path"

printf "\n\nexport TENSORFLOW_HOME=~/mymagenta/tensorflow/tensorflow\nexport PATH=\$PATH:\$TENSORFLOW_HOME/bin"  >> ~/.profile


echo "exporting the path so that the next command works"


export TENSORFLOW_HOME=~/mymagenta/tensorflow/tensorflow
export PATH=$PATH:$TENSORFLOW_HOME/bin





echo "-------------DONE TENSORFLOW-------------------------------------------------"
echo ". "




#broken link to tensorflow???

#ln -s ~/virtual-tf/lib/python2.7/site-packages/tensorflow ~/mymagenta/pip-tensorflow-link



echo "Grab my github site to load a few batch files, they may will need to be copied into the magenta workspace"
cd ~/mymagenta

git clone https://github.com/hpssjellis/my-google-magenta-installation.git


#copy bash files to the magenta workspace folder
cd ~/mymagenta/my-google-magenta-installation

cp a* ~/mymagenta/magenta


#bash a01-rocksetta-checks.sh







echo "First checking the Python version"
python --version

echo "--------------------------------------------------------------"
echo ". "


echo "Now checking where python is installed"
readlink -f $(which python)
echo ""
echo "--------------------------------------------------------------"


echo "Now checking if pip is installed"

pip list

echo "--------------------------------------------------------------"
echo ". "



echo "echo "Now checking where pip is installed"
readlink -f $(which pip)
echo ""
echo "--------------------------------------------------------------"
echo ". "
echo "Now checking if java is installed"
java -h
echo ""
javac
echo "--------------------------------------------------------------"
echo ". "
echo "Now checking where the jdk is installed"
readlink -f $(which java)
echo ""
readlink -f $(which javac)
echo "--------------------------------------------------------------"
echo ". "
echo "Now checking if Android SDK is installed"
android -h
echo ""
echo "--------------------------------------------------------------"
echo ". "
echo "Now checking where android sdk is installed"
readlink -f $(which android)
echo "--------------------------------------------------------------"
echo ". "
echo "Now checking if Bazel is installed"
bazel -h
echo ""
echo "--------------------------------------------------------------"
echo ". "
echo "echo "Now checking where bazel is installed"
readlink -f $(which bazel)
echo ""
echo "--------------------------------------------------------------"
echo ". "




echo "Now checking if Gradle is installed"

#gradle -v
echo ""

echo "--------------------------------------------------------------"
echo ". "





#echo "echo "Now checking where Gradle is installed"
#readlink -f $(which gradle)
echo ""
echo "--------------------------------------------------------------"
echo ". "
echo ""
echo "Now checking where gcc is installed"
readlink -f $(which gcc)
echo ""

echo "--------------------------------------------------------------"
echo ". "



echo "next list this directory"
pwd
echo ""
ls -lah  

echo "--------------------------------------------------------------"
echo "Some other useful commands are cd     cd ..      dir    ls     pwd     "
echo "."

echo " To check paths for new terminals, I suggested to run:"
echo "nano ~/.profile"



cd ~/mymagenta

# Now installl magenta

git clone https://github.com/tensorflow/magenta.git



# now test bazel, where is the directory???

cd ~/mymagenta/magenta

bazel test //magenta:all


echo "If it all worked try these scripts"

echo "build //magenta:midi_io_test"


#bazel build //magenta:midi_io_test
echo "bazel build //magenta:midi_io"
echo "bazel build //magenta:note_sequence_io"

# build your script (lots of midi files in a folder)
echo "bazel build //magenta:convert_midi_dir_to_note_sequences"




#The run it

#./bazel-bin/magenta/convert_midi_dir_to_note_sequences \
#--midi_dir=/path/to/midi/dir \
#--output_file=/path/to/tfrecord/file \
#--recursive







#echo "Now lets make an App. Checkout a10.rocksetta-create.sh to see the steps"

#bash a10.rocksetta-create.sh

#echo "Look in the wow3/bin folder to see your myNameWow3-debug.apk file"
#echo "run the index.html file and then Preview preview running App to view the .apk on a webpage to test on your Android 4.4.0 phone"





# some forum stuff at
#https://groups.google.com/a/tensorflow.org/forum/#!searchin/magenta-discuss/magenta/magenta-discuss/R0YiSbM3v5c/dW2qtKM3BQAJ
#https://groups.google.com/a/tensorflow.org/forum/#!searchin/magenta-discuss/magenta/magenta-discuss/HC_squh5TbA/Gx7MCp4cBAAJ
#https://groups.google.com/a/tensorflow.org/forum/#!searchin/magenta-discuss/magenta/magenta-discuss/dtQUq6IVaXk/7Cg32SdPBAAJ





cd ~/mymagenta/magenta
