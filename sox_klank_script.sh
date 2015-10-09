#! /bin/bash

#open folder met mp3s

cd sox_fragments 

#vind alle mp3s, converteer ze naar .wav file in wav_files

find . -name "*.mp3" -exec '
mp3="$0"
basename=`basename $0 .mp3`
sox --norm $mp3 -r 44100 ../wav_files/${basename}.wav
' {} \;

#nu komt het leuke werk, we gaan met de files kloten, maar eerst openen we het mapje met de wave files

cd ../wav_files

find . -name "*.wav" -exec '
origineel=$0
basename=`basename $0 .wav"
sox $origineel ../puurgeluid/${basename}_puur.wav trim 0.0 5.0 fade 0.1 0.1
' {} \;




