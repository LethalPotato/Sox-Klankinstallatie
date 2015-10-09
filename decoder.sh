#! /bin/bash

#open folder met mp3s

cd sox_fragments 

#maak een mapje in de hoofdfolder voor de wave files

mkdir wav_files

#vind alle mp3s, converteer ze naar .wav file in wav_files

find . -name "*.mp3" -exec sh -c '
mp3="$0"
basename=`basename $0 .mp3`
sox --norm $mp3 -r 44100 ../wav_files/${basename}.wav
' {} \;


