#!/bin/bash 

#Ejercicio 1:
echo "Ejercicio 1:"
cat /proc/cpuinfo | grep 'model name'


echo "---------------------------------------------------------------"

#Ejercicio 2:
echo "Ejercicio 2:"
cat /proc/cpuinfo | grep 'model name' | wc -l 

echo "---------------------------------------------------------------"

#Ejercicio 3:
echo "Ejercicio 3:"
#Primero descargo el archivo con wget -O
wget -O heroes.csv "https://raw.githubusercontent.com/dariomalchiodi/superhero-datascience/master/content/data/heroes.csv" ; cut -d ';' -f 2 heroes.csv | grep -v '^$'|tr '[:upper:]' '[:lower:]'
#Ahora voy a sacar la segunda columna con cut 
#Ahora usando -v con grep saco los espacios en blanco donde ^$ es un espacio en blanco 

echo "---------------------------------------------------------------"

#Ejercicio 4:
echo "Ejercicio 4:"
sort -n -r -k 5 weather_cordoba.in | awk 'NR == 1 {print $1, $2, $3}' & sort -n -r -k 5 weather_cordoba.in | awk 'END {print $1, $2, $3}'

echo "---------------------------------------------------------------"

#Ejercicio 5:
echo "Ejercicio 5:"
sort -n -k 3 atpplayers.in

echo "---------------------------------------------------------------"

#Ejercicio 6:
echo "Ejercicio 6:"
awk '{diff=$7-$8; print $0, diff}' superliga.in | sort -k2,2nr -k9,9nr | awk '{$NF="";print $0}'| sed 's/ *$//'
#Aquí lo que hago es calcular la diferencia de goles con awk y luego ordenar los datos
#De está forma por ejemplo se desempatan bien los casos.

echo "---------------------------------------------------------------"

#Ejercicio 7:
echo "Ejercicio 7:"
ip addr | grep -o "ether ..:..:..:..:..:.."

echo "---------------------------------------------------------------"
#Ejercicio 8:
#Parte a):
mkdir SERIE_NO_PIRATEADA; touch SERIE_NO_PIRATEADA/GOW_S01E{1..10}_es.srt
#Parte b):
for file in SERIE_NO_PIRATEADA/*.srt; do mv $file "${file%_es.srt}.srt"; done

echo "---------------------------------------------------------------"
#Ejercicio 9:
#Parte a): 
ffmpeg -ss 00:00:07 -i hola.mkv -t 00:00:09 prueba.mkv -loglevel quiet -stats 

#Parte b):
ffmpeg -i relato.mp3 -i frozy.mp3 -filter_complex "[1:a]volume=0.1[a2];[a2]amerge=inputs=2" -ac 2 prueba.mp3 
#Aquí por cuestiones de que la segunda pista frozy.mp3 tenia un volumen más alto que la grabación uso "[1:a]volume=0.1[a2];[a2]amerge=inputs=2"
#Que le bajaría en una bonita proporción el volumen a la pista de fondo respecto a la grabación. 