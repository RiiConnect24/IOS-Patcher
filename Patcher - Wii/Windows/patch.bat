mode 120,30
@echo off
rem ### Want to create translation for your language? ###
rem ### Download this text file: https://drive.google.com/open?id=0B99PAkYFoBoLUFRERkFNbTBLU3M ###
rem ### And than send me this on discord - KcrPL#4625. It's easy! :) ###
rem But please, don't put your own translations in this file! You may not understand the code and you may broke it!
rem -KcrPL.
chcp 65001
set error4112=0
set filcheck=0
set language=NotDefined
title IOS Patcher for RiiConnect24
set patchingok=1
:begin
cls
if %language%==NotDefined goto set_language
if not exist 00000006-31.delta goto error_runtime_error
if not exist 00000006-80.delta goto error_runtime_error
if not exist libWiiSharp.dll goto error_runtime_error
if not exist Sharpii.exe goto error_runtime_error
if not exist WadInstaller.dll goto error_runtime_error
if not exist wget.exe goto error_runtime_error
if not exist xdelta3.exe goto error_runtime_error
set filcheck=1
goto 3
:error_runtime_error
cls
echo                                      IOS Patcher for RiiConnect24 - @Larsenv, @KcrPL
echo ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ
echo.
echo  %text1%
echo  %text2%
echo ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ
echo.
echo %text3%
pause>NUL
set patchingok=0
goto end
:set_language
set s=NUL
rem ### Please do not make any changes to this part of code. ###
rem # Please contact me on Discord - KcrPL#4625 ###
cls
echo.
echo                                      IOS Patcher for RiiConnect24 - @Larsenv, @KcrPL
echo ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ
echo.
echo Please select your language.
if %s%==NUL echo.
if %s%==NUL echo If you want to exit, press ENTER without typing anything
echo.
echo 1. English (Author: KcrPL) (Correction: Seriel)
echo 2. Polish (Author: KcrPL)
echo 3. Deutsch (Author: TimNook) (Correction: Brawl345)
echo 4. Portuguese (Author: Rafael)
echo 5. French (Author: iDroid)
echo 6. Italian (Author: GameCube)
echo 7. Spanish (Author: Artuto)
echo 8. Russian (Author: prosuWANTED)
echo.
set /p s=Choose: 
if %s%==1 goto set_language_en
if %s%==2 goto set_language_pl
if %s%==3 goto set_language_deu
if %s%==4 goto set_language_braz
if %s%==5 goto set_language_fr
if %s%==6 goto set_language_it
if %s%==7 goto set_language_es
if %s%==8 goto set_language_rus
if %s%==NUL exit
goto set_language

:set_language_rus
set text1=Некоторые файлы необходимые для работы программы не были найдены.
set text2=Скачайте заново архив с программой и повторите ещё раз.
set text3=Нажмите любую кнопку чтобы закрыть патчер.
set text4=Вы будете использовать этот патчер для Wii или Wii U?
set text5=К сожалению, патчер не будет работать для Wii U.
set text6=Нажмите чего-нибудь чтобы вернуться.
set text7=Если нет, закройте эту программу.
set text8=Нужно скачать IOS 31 и 80.
set text9=Нажмите любую кнопку чтобы начать скачивание.
set text10=Не получается скачать файлы, так как ваш интернет откючён.
set text11=Пожалуйста включите ваш интернет и нажмите любую клавишу, чтобы продожить.
set text12=Пожалуйста подождите, файлы скачиваются... 
set text13=Патч завершён.
set text14=IOS с патчами помещены в папку "WAD".

set language=Russian
goto begin
:set_language_es
set text1=Los archivos necesarios para ejecutar este programa no se han encontrado.
set text2=Vuelve a descargar el programa e intenta de nuevo.
set text3=Presiona cualquier tecla para cerrar el programa.
set text4=Vas a utilizar este programa para Wii o Wii U?
set text5=Desafortunadamente la Wii U no es soportada...
set text6=Si estabas bromeando, presiona una tecla para continuar.
set text7=Si no, cierra este programa.
set text8=Tenemos que descargar el IOS 31 y 80.
set text9=Presiona cualquier tecla para comenzar a descargar.
set text10=No hemos podido descargar los archivos necesarios debido a que tienes desactivada tu conexion a Internet!
set text11=Activa tu conexion y presiona una tecla para continuar.
set text12=Espera un momento... Los archivos se estan descargando...
set text13=Hemos terminado! Parcheo completado.
set text14=Puedes encontrar los archivos parcheados en la carpeta "WAD".

set language=Spanish
goto begin
:set_language_it
set text1=Alcuni dei file necessari per eseguire questo programma non sono stati trovati.
set text2=Scarica nuovamente il pacchetto e riprova
set text3=Fare clic su qualsiasi pulsante per chiudere il patcher.
set text4=Stai usando questo patcher per Wii o WiiU?
set text5=Purtroppo, non puoi utilizzare questo patcher per Wii U :(
set text6=Se stavi scherzando, fai clic su qualcosa per tornare indietro.
set text7=In caso contrario, chiudere questo programma.
set text8=Dobbiamo scaricare IOS 31 e 80.
set text9=Fare clic su qualsiasi pulsante per procedere al download.
set text10=Non è possibile scaricare i file perché la connessione a Internet è disabilitata!
set text11=Abilita la connessione e fai clic su qualsiasi pulsante per riprovare.
set text12=Attendere ... i file vengono procedere ad essere scaricati ...
set text13=La patchatura è fatta.
set text14=I file IOS installati saranno nella cartella chiamata "WAD".

set language=Italian
goto begin
:set_language_fr
set text1=Un des fichiers nécessaires pour exécuter ce programme n'a pas ete trouvé.
set text2=Téléchargez l'archive a nouveau puis réessayez
set text3=Appuyez sur n'importe quelle touche pour fermer le programme
set text4=Allez-vous utiliser ce patcher pour la Wii ou la Wii U ?
set text5=Malheureusement, ce patcher est incompatible avec la Wii U...
set text6=Si vous blaguiais, appuyez sur une touche pour continuer.
set text7=Si non, fermez le programme.
set text8=Nous devons télécharger les IOS 31 et 80.
set text9=Appuyez sur n'importe quelle touche pour procéder au téléchargement.
set text10=Nous ne pouvons pas télécharger les IOS car votre connexion Internet est inaccessible.
set text11=Rétablissez votre connexion Internet puis appuyez sur n'importe quelle touche.
set text12=Patientez... les fichiers sont en train d'être télécharges...
set text13=Le patchage est terminé
set text14=Les IOS patchés se trouvent dans le dossier "WAD".

set language=French
goto begin
:set_language_braz
set text1=Alguns dos arquivos necessários para rodar o programa, não foram encontrados.
set text2=Baixe o arquivo novamente e tente de novo
set text3=Clique em qualquer botão para fechar o patcher.
set text4=Você vai usar esse patcher para Wii ou WiiU?
set text5=Infelizmente, você não pode utilizar esse patch no Wii U :(
set text6=Se você estava brincando, clique no botão para voltar.
set text7=Se não estava, feche o programa.
set text8=Nós precisamos baixar as IOS 31 e 80.
set text9=Clique em qualquer botão para começar o download.
set text10=Nós não podemos baixar os arquivos pois a sua internet está desligada!
set text11=Ligue a sua internet e tente novamente.
set text12=Por favor espere... Os arquivos estão sendo baixados... 
set text13=O Patching acabou.
set text14=Arquivos de Patched IOS são chamadas de ''WAD''.

set language=Portuguese
goto begin
:set_language_deu
set text1=Einige der Dateien, die dieses Programm braucht, um zu funktionieren, wurden nicht gefunden!
set text2=Downloade dieses Paket noch einmal und probiere es erneut!
set text3=Druecke auf irgendeinen Knopf um das Programm zu beenden.
set text4=Benutzt du diesen Patcher fuer die Wii U oder die Wii?
set text5=Leider kannst du diesen Patcher nicht fuer die Wii U benutzen :(
set text6=Wenn du einen Witz gemacht hast, druecke einen Knopf um zurueck zu gehen.
set text7=Wenn nicht, schliesse dieses Programm.
set text8=Wir muessen IOS 31 und 80 herunterladen.
set text9=Drucke irgendeinen Knopf um mit dem download fortzufahren.
set text10=Wir koennen keine Dateien herunterladen, da du nicht mit dem Internet verbunden bist!
set text11=Verbinde dich mit dem Internet und druecke einen Knopf, um es nochmal zu probieren.
set text12=Bitte warte... die Dateien werden heruntergeladen...
set text13=Das Patchen ist abgeschlossen.
set text14=Die gepatchten Dateien befinden sich im "WAD"-Ordner.

set language=Deutsch
goto begin
:set_language_pl
set text1=Pliki które są potrzebne do uruchomienia programu nie zostały znalezione.
set text2=Pobierz tą paczke ponownie oraz spróbuj ponownie.
set text3=Naciśnij dowolny przycisk aby zamknąć ten program
set text4=Czy będziesz używal tego patchera dla Wii czy dla WiiU?
set text5=Niestety nie mozesz używac tego programu dla Wii U :(
set text6=Jezeli żartowales, naciśnij dowolny przycisk aby powrocic do poprzedniego menu.
set text7=Jesli nie, zamknij program.
set text8=Musimy pobrać IOS 31 oraz IOS 80.
set text9=Naciśnij dowolny przycisk aby rozpocząć do pobieranie.
set text10=Nie możemy pobrać plikow ponieważ twoje połaczenie internetowe jest niedostępne!
set text11=Włacz twój internet i nacisnij dowolny przycisk aby spróbować ponownie
set text12=Proszę czekać... pliki są pobierane
set text13=Patchowanie przebiegło pomyślnie.
set text14=Spatchowane pliki IOS bedą w folderze nazwanym "WAD".

set language=Polish
goto begin
:set_language_en
cls
set text1=Some of the files needed to run this program were not found.
set text2=Redownload the package and try again.
set text3=Click any button to close the patcher.
set text4=Are you gonna be using this patcher for Wii or WiiU?
set text5=Unfortunately, you cannot use this patcher for Wii U :(
set text6=If you were joking, click something to go back.
set text7=If not, close this program.
set text8=We need to download IOS 31 and 80.
set text9=Click any button to proceed to download.
set text10=We cannot download the files because your Internet connection is disabled!
set text11=Enable your connection and click any button to try again.
set text12=Please wait... files are being downloaded... 
set text13=Patching is done.
set text14=Patched IOS files will be in folder called "WAD".

set language=English
goto begin

:DoNotTouchThisSection
set error4112=1
goto error4112
:error_code_error
cls
echo IOS Patcher for RiiConnect24
echo ------------------------------
echo @Larsenv, @KcrPL
echo.
echo ERROR.
echo It seems that error has occurred.
echo.
echo It's because this translation is broken. Or file check has failed.
pause>NUL
goto error_code_error


:3
cls
echo                                      IOS Patcher for RiiConnect24 - @Larsenv, @KcrPL
echo ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ
echo.
echo %text4%
echo.
echo 1. Wii
echo 2. WiiU
set /p s=Choose: 
if %s%==1 goto 4
if %s%==2 goto error_3
goto 3
:error_3
cls
echo                                      IOS Patcher for RiiConnect24 - @Larsenv, @KcrPL
echo ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ

echo.
echo %text5%
echo.
echo %text6%
echo %text7%
pause>NUL
goto 3
:4
set instalorder=1
set intrepeat=0
cls
echo                                      IOS Patcher for RiiConnect24 - @Larsenv, @KcrPL
echo ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ
echo.
echo %text8%
echo %text9%
echo.
pause>NUL	
goto 5

:5
if exist WAD rmdir WAD /s /q
cls
echo                                      IOS Patcher for RiiConnect24 - @Larsenv, @KcrPL
echo ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ
echo %text12%
rem ### Patching ###
Sharpii.exe NUSD -ios 31 -v latest -o IOS31-old.wad -wad >NUL
if not %errorlevel%==0 goto error_patching
Sharpii.exe NUSD -ios 80 -v latest -o IOS80-old.wad -wad >NUL
if not %errorlevel%==0 goto error_patching
Sharpii.exe WAD -u IOS31-old.wad IOS31/ >NUL
if not %errorlevel%==0 goto error_patching
Sharpii.exe WAD -u IOS80-old.wad IOS80/ >NUL
move IOS31\00000006.app 00000006.app >NUL
if not %errorlevel%==0 goto error_patching
xdelta3.exe -f -d -s 00000006.app 00000006-31.delta IOS31\00000006.app >NUL
if not %errorlevel%==0 goto error_patching
move IOS80\00000006.app 00000006.app >NUL
if not %errorlevel%==0 goto error_patching
xdelta3.exe -f -d -s 00000006.app 00000006-80.delta IOS80\00000006.app >NUL
if not %errorlevel%==0 goto error_patching
mkdir WAD
if not %errorlevel%==0 goto error_patching
Sharpii.exe WAD -p IOS31\ WAD\IOS31.wad -fs >NUL
if not %errorlevel%==0 goto error_patching
Sharpii.exe WAD -p IOS80\ WAD\IOS80.wad -fs >NUL
if not %errorlevel%==0 goto error_patching
del 00000006.app /q >NUL
if not %errorlevel%==0 goto error_patching
del IOS31-old.wad /q >NUL
if not %errorlevel%==0 goto error_patching
del IOS80-old.wad /q >NUL
if not %errorlevel%==0 goto error_patching
rmdir /s /q IOS31 >NUL
if not %errorlevel%==0 goto error_patching
rmdir /s /q IOS80 >NUL
rem ### Patching Done ###
goto end
:error_patching
cls
echo                                      IOS Patcher for RiiConnect24 - @Larsenv, @KcrPL
echo ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ
echo.
echo There was an error while patching.
echo Press any button to try again.
pause>NUL
goto 4
:end
set /a exiting=10
set /a timeouterror=1
timeout 1 /nobreak >NUL && set /a timeouterror=0
goto end1
:end1
cls
echo                                      IOS Patcher for RiiConnect24 - @Larsenv, @KcrPL
echo ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ

echo.
if %patchingok%==1 echo %text13%
if %patchingok%==1 echo %text14%
echo.
echo Exiting the patcher in...
if %exiting%==10 echo :----------: 10
if %exiting%==9 echo :--------- : 9
if %exiting%==8 echo :--------  : 8
if %exiting%==7 echo :-------   : 7
if %exiting%==6 echo :------    : 6
if %exiting%==5 echo :-----     : 5
if %exiting%==4 echo :----      : 4
if %exiting%==3 echo :---       : 3
if %exiting%==2 echo :--        : 2
if %exiting%==1 echo :-         : 1
if %exiting%==0 echo :          :
if %exiting%==0 exit
if %timeouterror%==0 timeout 1 /nobreak >NUL
if %timeouterror%==1 ping localhost -n 2 >NUL
set /a exiting=%exiting%-1
goto end1
