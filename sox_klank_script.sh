#open folder met mp3s

cd sox_fragments 

#vind alle mp3s, converteer ze naar .wav

find . -name "*.mp3" -exec sh -c '
mp3="$0"
basename=`basename $0 .mp3`
sox $mp3 -r 44100 ${basename}.wav norm
' {} \;

#Zet ze in mapje wav_files op hetzelfde niveau als sox_fragments

mkdir ../wav_files

find . -name "*.wav" -exec sh -c '
file="$0"
mv $file ../wav_files/${file}
' {} \;

#nu komt het leuke werk, we gaan met de files kloten, maar eerst openen we het mapje met de wave files en maken we een mapje voor het pure geluid

cd ../wav_files

find . -name "*.wav" -exec sh -c '
origineel="$0"
basename=`basename $0 .wav`
sox --norm $origineel ${basename}_puur.wav trim 0 5 fade 0.1 4.8 0.1
' {} \;


#Zet ze in mapje puurgeluid

mkdir ../puurgeluid

find . -name "*_puur.wav" -exec sh -c '
file="$0"
mv $file ../puurgeluid/${file}
' {} \;


#En nu gaan we filteren! ('alsof het ergens anders in het gebouw klinkt')

find . -name "*.wav" -exec sh -c '
origineel="$0"
basename=`basename $0 .wav`
sox --norm $origineel ${basename}_lowpass.wav vol 0.5 lowpass 1000.0 trim 0 4 fade 0.1 3.8 0.1
' {} \;

#ook deze krijgen hun eigen mapje:

mkdir ../lowpass

find . -name "*_lowpass.wav" -exec sh -c '
file="$0"
mv $file ../lowpass/${file}
' {} \;

#Tijd voor distortion/clipping! :)

find . -name "*.wav" -exec sh -c '
origineel="$0"
basename=`basename $0 .wav`
sox --norm $origineel ${basename}_distorted.wav overdrive 20 vol 0.5 trim 0 2 fade 0.1 1.8 0.1
' {} \;

#wederom een eigen mapje

mkdir ../distorted

find . -name "*_distorted.wav" -exec sh -c '
file="$0"
mv $file ../distorted/${file}
' {} \;

#Tenslotte ga ik nog lekker los. Ik wil de file achterstevoren en 50% naar beneden gepitched. Leek me gaaf.

find . -name "*.wav" -exec sh -c '
origineel="$0"
basename=`basename $0 .wav`
sox --norm $origineel ${basename}_revpitch.wav reverse speed 0.5 trim 0 6 fade 0.1 5.8 0.1
' {} \;

#En het laatste mapje dat we maken:

mkdir ../revpitch

find . -name "*_revpitch.wav" -exec sh -c '
file="$0"
mv $file ../revpitch/${file}
' {} \;




