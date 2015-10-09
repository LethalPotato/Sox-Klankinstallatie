#1 /bin/bash

#dit opent eerst de map met fragmenten

cd ~/SO2_folder/klankinstallatie/wav_files/

#dit pakt de eerste 5 seconden van het fragment, en voegt 0.1 s fade in en -out toe

find . -type f -name "*.wav" -exec sh -c '
origineel="$0"
basename=`basename $0 .wav`
echo sox $origineel ${basename}_pure.wav trim 0.0 5.0 fade 0.1 0.1
' {} \;

#maakt submap aan en verplaatst de file naar submapje met de geprocesste files

mkdir pure_sound
mv ${basename}_pure.wav ../pure_sound/${basename}_pure.wav


