#!/bin/bash

#inicialitza el countador
var=0 
#for loop per  comprobar  els arguments si son correctes i si no surt del programa
for  vars in $*
do
case $vars in
[abcdef])
;;
[0-9])
     var=0
       echo "ARGUMENTS INCRECTES"
      exit
;;
[A-Z])
       var=0
          echo "ARGUMENTS INCRECTES"
         exit
;;
??*)
   
           echo "ARGUMENTS INCRECTES"
     exit
 ;;

*)
     echo "ARGUMENTS INCORRECTES"
         exit
esac
done
#crea un nou directory per guardar el archius  copiats
rm -rf ~/hola && mkdir ~/hola
#comproba si  han passat arguments 
if [ "$#" -eq 0 ]
 then
#for loop per  copiar tots els fitxer  per que no han passat cap arguments
       echo "copying  files without arguments"
       for  items in  * 
         do
                  if [ -d  $items ]
                  then
          (cd "$items" && (find . -type f -name '*.out'| xargs -I{} cp --backup=numbered {} ~/hola/{}.$items))        
                  fi
         done
else
   # for loop per  copiar  els fitxer  segon els arguments passats
  echo "copying files with arguments"
for  items in  *
  do
       if [ -d  $items ]
       then
             #for loop  per  iterar en tots  els arguments
              for ar in $*
               do
                    (cd "$items" && ( ls -1 | grep $ar.??? | xargs -I{} cp  {} ~/hola/{}.$items ))
               done
       fi
done
fi
#obra els fitxer on hem guardat els fitxers copiats
cd ~ && ~/hola
echo  "renaming files..."
#for loop per cambiar el nom de cada fitxer copiat
for f in `ls -1`; do
    a=$(echo $f | sed "s/.out./_/g")
    mv "$f" "$a"
done
#tambe cambia  el nom de cada fitxer guardat dintre del  directory ~/hola
cd  ~ && cd ~/hola
echo "renaming files..."
find .| xargs  -i mv {} {}.out
var=$(ls -l | wc -l)
 var=`expr $var - 1`
echo "hem copiat $var"
echo "working on it"
#mostra per pantalla tots  els guardat dintre de ~/hola
ls -l
