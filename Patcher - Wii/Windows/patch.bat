set language=NotDefined
title IOS Patcher for RiiConnect24
set patchingok=1
:begin
@echo off
cls
if %language%==NotDefined goto set_language
if not exist 00000006-31.delta goto error_runtime_error
if not exist 00000006-80.delta goto error_runtime_error
if not exist libWiiSharp.dll goto error_runtime_error
if not exist Sharpii.exe goto error_runtime_error
if not exist WadInstaller.dll goto error_runtime_error
if not exist wget.exe goto error_runtime_error
if not exist xdelta3.exe goto error_runtime_error
goto 1
:error_runtime_error
cls
echo IOS Patcher for RiiConnect24
echo ------------------------------
echo @Larsenv, @KcrPL
echo.
echo :--------------------------------------------:
echo  %text1%
echo  %text2%
echo :--------------------------------------------:
echo.
echo %text3%
pause>NUL
set patchingok=0
goto end
:set_language
cls
echo IOS Patcher for RiiConnect24
echo ------------------------------
echo @Larsenv, @KcrPL
echo.
echo Please select your language.
echo.
echo 1. English (Author: KcrPL) (Correction: Seriel)
echo 2. Polish (Author: KcrPL)
echo 3. Deutsch (Author: TimNook, Brawl345)
echo 4. Portuguese (Author: Rafael)
echo 5. French (Author: iDroid)
echo 6. Italian (Author: GameCube)
set /p s=Choose: 
if %s%==1 goto set_language_en
if %s%==2 goto set_language_pl
if %s%==3 goto set_language_deu
if %s%==4 goto set_language_braz
if %s%==5 goto set_language_fr
if %s%==6 goto set_language_it
goto set_language
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
set text10=Non e possibile scaricare i file perché la connessione a Internet e disabilitata!
set text11=Abilita la connessione e fai clic su qualsiasi pulsante per riprovare.
set text12=Attendere ... i file vengono procedere ad essere scaricati ...
set text13=La patchatura e fatta.
set text14=I file IOS installati saranno nella cartella chiamata "WAD".

set language=Italian
goto begin
:set_language_fr
set text1=Un des fichiers necessaires pour executer ce programme n'a pas ete trouve.
set text2=Telechargez l'archive a nouveau puis reessayez
set text3=Appuyez sur n'importe quelle touche pour fermer le programme
set text4=Allez-vous utiliser ce patcher pour la Wii ou la Wii U ?
set text5=Malheureusement, ce patcher est incompatible avec la Wii U...
set text6=Si vous blaguiais, appuyez sur une touche pour continuer.
set text7=Si non, fermez le programme.
set text8=Nous devons telecharger les IOS 31 et 80.
set text9=Appuyez sur n'importe quelle touche pour proceder au telechargement.
set text10=Nous ne pouvons pas telecharger les IOS car votre connexion Internet est inaccessible.
set text11=Retablissez votre connexion Internet puis appuyez sur n'importe quelle touche.
set text12=Patientez... les fichiers sont en train d'etre telecharges...
set text13=Le patchage est terminé
set text14=Les IOS patches se trouvent dans le dossier "WAD".

set language=French
goto begin
:set_language_braz
set text1=Alguns dos arquivos necessarios para rodar o programa, nao foram encontrados.
set text2=Baixe o arquivo novamente e tente de novo
set text3=Clique em qualquer botao para fechar o patcher.
set text4=Voce vai usar esse patcher para Wii ou WiiU?
set text5=Infelizmente, voce nao pode utilizar esse patch no Wii U :(
set text6=Se voce estava brincando, clique no botão para voltar.
set text7=Se nao estava, feche o programa.
set text8=Nos precisamos baixar as IOS 31 e 80.
set text9=Clique em qualquer botao para comecar o download.
set text10=Nos nao podemos baixar os arquivos pois a sua internet esta desligada!
set text11=Ligue a sua internet e tente novamente.
set text12=Por favor espere... Os arquivos estao sendo baixados... 
set text13=O Patching acabou.
set text14=Arquivos de Patched IOS sao chamadas de ''WAD''.

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
set text9=Druecke irgendeinen Knopf, um mit dem Download zu beginnen.
set text10=Wir koennen keine Dateien herunterladen, da du nicht mit dem Internet verbunden bist!
set text11=Verbinde dich mit dem Internet und druecke einen Knopf, um es nochmal zu probieren.
set text12=Bitte warte... die Dateien werden heruntergeladen... 
set text13=Das Patchen ist abgeschlossen.
set text14=Die gepatchten Dateien befinden sich im "WAD"-Ordner.

set language=Deutsch
goto begin
:set_language_pl
set text1=Pliki ktore sa potrzebne do uruchomienia programu nie zostaly znalezione.
set text2=Pobierz ta paczke ponownie oraz sprobuj ponownie.
set text3=Nacisnij dowolny przycisk aby zamknac ten program
set text4=Czy bedziesz uzywal tego patchera dla Wii czy dla WiiU?
set text5=Niestety nie mozesz uzywac tego programu dla Wii U :(
set text6=Jezeli zartowales, nacisnij dowolny przycisk aby powrocic do poprzedniego menu.
set text7=Jesli nie, zamknij program.
set text8=Musimy pobrac IOS 31 oraz IOS 80.
set text9=Nacisnij dowolny przycisk aby przystapic do pobierania.
set text10=Nie mozemy pobrac plikow poniewaz twoje polaczenie internetowe jest niedostepne!
set text11=Wlacz twoj internet i nacisnij dowolny przycisk aby sprobowac ponownie
set text12=Prosze czekac... pliki sa pobierane
set text13=Patchowanie przebieglo pomyslnie.
set text14=Spatchowane pliki IOS beda w folderze nazwanym "WAD".

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
:1
cls
echo \
ping localhost -n 4 >NUL
echo H\
ping localhost -n 1 >NUL
cls
echo Hi\
ping localhost -n 1 >NUL
cls
echo Hi\
ping localhost -n 3 >NUL
cls
echo Hi.
echo Th\
ping localhost -n 1 >NUL
cls
echo Hi.
echo Than\
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks f\
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for\
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for ch\
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for chec\
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checki\
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking\
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out\
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out Ri\
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiC\
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiCon\
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConne\
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect\
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect2\
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo Th\
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This\
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This pa\
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patc\
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patche\
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patcher\
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patcher is\
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patcher is fo\
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patcher is for p\
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patcher is for patc\
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patcher is for patchi\
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patcher is for patching\
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patcher is for patching I\
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patcher is for patching IOS\
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patcher is for patching IOS t\
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patcher is for patching IOS to m\
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patcher is for patching IOS to mak\
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patcher is for patching IOS to make\
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patcher is for patching IOS to make Ri\
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patcher is for patching IOS to make RiiC\
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patcher is for patching IOS to make RiiCon\
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patcher is for patching IOS to make RiiConnec\
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patcher is for patching IOS to make RiiConnect2\
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patcher is for patching IOS to make RiiConnect24\
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patcher is for patching IOS to make RiiConnect24 wo\
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patcher is for patching IOS to make RiiConnect24 work\
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patcher is for patching IOS to make RiiConnect24 work on\
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patcher is for patching IOS to make RiiConnect24 work on yo\
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patcher is for patching IOS to make RiiConnect24 work on your\
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patcher is for patching IOS to make RiiConnect24 work on your Wi\
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patcher is for patching IOS to make RiiConnect24 work on your Wii.
ping localhost -n 5 >NUL
goto 2
:2
cls
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patcher is for patching IOS to make RiiConnect24 work on your Wii.
echo :
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patcher is for patching IOS to make RiiConnect24 work on your Wii.
echo :-
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patcher is for patching IOS to make RiiConnect24 work on your Wii.
echo :---
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patcher is for patching IOS to make RiiConnect24 work on your Wii.
echo :----
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patcher is for patching IOS to make RiiConnect24 work on your Wii.
echo :---------
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patcher is for patching IOS to make RiiConnect24 work on your Wii.
echo :-------------
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patcher is for patching IOS to make RiiConnect24 work on your Wii.
echo :-------------------
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patcher is for patching IOS to make RiiConnect24 work on your Wii.
echo :------------------------
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patcher is for patching IOS to make RiiConnect24 work on your Wii.
echo :-------------------------------
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patcher is for patching IOS to make RiiConnect24 work on your Wii.
echo :--------------------------------------
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patcher is for patching IOS to make RiiConnect24 work on your Wii.
echo :------------------------------------------
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patcher is for patching IOS to make RiiConnect24 work on your Wii.
echo :-----------------------------------------------
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patcher is for patching IOS to make RiiConnect24 work on your Wii.
echo :---------------------------------------------------
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patcher is for patching IOS to make RiiConnect24 work on your Wii.
echo :----------------------------------------------------------
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patcher is for patching IOS to make RiiConnect24 work on your Wii.
echo :------------------------------------------------------------
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patcher is for patching IOS to make RiiConnect24 work on your Wii.
echo :--------------------------------------------------------------
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patcher is for patching IOS to make RiiConnect24 work on your Wii.
echo :----------------------------------------------------------------
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patcher is for patching IOS to make RiiConnect24 work on your Wii.
echo :-----------------------------------------------------------------
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patcher is for patching IOS to make RiiConnect24 work on your Wii.
echo :------------------------------------------------------------------
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patcher is for patching IOS to make RiiConnect24 work on your Wii.
echo :-------------------------------------------------------------------
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patcher is for patching IOS to make RiiConnect24 work on your Wii.
echo :--------------------------------------------------------------------
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patcher is for patching IOS to make RiiConnect24 work on your Wii.
echo :---------------------------------------------------------------------
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo This patcher is for patching IOS to make RiiConnect24 work on your Wii.
echo :---------------------------------------------------------------------:
ping localhost -n 2 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo. 
echo :---------------------------------------------------------------------:
ping localhost -n 1 >NUL
cls
echo Hi.
echo Thanks for checking out RiiConnect24
echo :---------------------------------------------------------------------:
ping localhost -n 1 >NUL
cls
echo Hi.
echo :---------------------------------------------------------------------:
echo @Larsenv, @KcrPL
ping localhost -n 1 >NUL
cls
echo :---------------------------------------------------------------------:
echo ------------------------------
echo @Larsenv, @KcrPL
ping localhost -n 1 >NUL
cls
echo IOS Patcher for RiiConnect24
echo ------------------------------
echo @Larsenv, @KcrPL
goto 3
:3
cls
echo IOS Patcher for RiiConnect24
echo ------------------------------
echo @Larsenv, @KcrPL
echo.
echo Language: %language%
echo In order to change language - restart this program.
echo :---------------------------------------------------:
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
echo IOS Patcher for RiiConnect24
echo ------------------------------
echo @Larsenv, @KcrPL
echo.
echo %text5%
echo.
echo %text6%
echo %text7%
pause>NUL
goto 3
:4
set internet=1
ping www.google.com -n 1 >NUL || set internet=0
cls
echo IOS Patcher for RiiConnect24
echo ------------------------------
echo @Larsenv, @KcrPL
echo.
echo %text8%
echo %text9%
echo.
if %internet%==0 echo %text10%
if %internet%==0 echo %text11%
pause>NUL
if %internet%==0 goto 4
goto 5
:5
if exist WAD rmdir WAD /s /q
cls
echo IOS Patcher for RiiConnect24
echo ------------------------------
echo @Larsenv, @KcrPL
echo.
echo %text12%
echo 6%%
Sharpii.exe NUSD -ios 31 -v latest -o IOS31-old.wad -wad >NUL
cls
echo IOS Patcher for RiiConnect24
echo ------------------------------
echo @Larsenv, @KcrPL
echo.
echo %text12%
echo 12%%
Sharpii.exe NUSD -ios 80 -v latest -o IOS80-old.wad -wad >NUL
cls
echo IOS Patcher for RiiConnect24
echo ------------------------------
echo @Larsenv, @KcrPL
echo.
echo %text12%
echo 18%%
Sharpii.exe WAD -u IOS31-old.wad IOS31/ >NUL
cls
echo IOS Patcher for RiiConnect24
echo ------------------------------
echo @Larsenv, @KcrPL
echo.
echo %text12%
echo 25%%
Sharpii.exe WAD -u IOS80-old.wad IOS80/ >NUL
cls
echo IOS Patcher for RiiConnect24
echo ------------------------------
echo @Larsenv, @KcrPL
echo.
echo %text12%
echo 31%%
move IOS31\00000006.app 00000006.app >NUL
xdelta3.exe -f -d -s 00000006.app 00000006-31.delta IOS31\00000006.app >NUL
cls
echo IOS Patcher for RiiConnect24
echo ------------------------------
echo @Larsenv, @KcrPL
echo.
echo %text12%
echo 37%%
move IOS80\00000006.app 00000006.app >NUL
cls
echo IOS Patcher for RiiConnect24
echo ------------------------------
echo @Larsenv, @KcrPL
echo.
echo %text12%
echo 43%%
xdelta3.exe -f -d -s 00000006.app 00000006-80.delta IOS80\00000006.app >NUL
cls
echo IOS Patcher for RiiConnect24
echo ------------------------------
echo @Larsenv, @KcrPL
echo.
echo %text12%
echo 50%%
mkdir WAD
cls
echo IOS Patcher for RiiConnect24
echo ------------------------------
echo @Larsenv, @KcrPL
echo.
echo %text12%
echo 56%%
Sharpii.exe WAD -p IOS31\ WAD\IOS31.wad -fs >NUL
cls
echo IOS Patcher for RiiConnect24
echo ------------------------------
echo @Larsenv, @KcrPL
echo.
echo %text12%
echo 62%%
Sharpii.exe WAD -p IOS80\ WAD\IOS80.wad -fs >NUL
cls
echo IOS Patcher for RiiConnect24
echo ------------------------------
echo @Larsenv, @KcrPL
echo.
echo %text12%
echo 68%%
del 00000006.app /q >NUL
cls
echo IOS Patcher for RiiConnect24
echo ------------------------------
echo @Larsenv, @KcrPL
echo.
echo %text12%
echo 75%%
del IOS31-old.wad /q >NUL
cls
echo IOS Patcher for RiiConnect24
echo ------------------------------
echo @Larsenv, @KcrPL
echo.
echo %text12%
echo 81%%
del IOS80-old.wad /q >NUL
cls
echo IOS Patcher for RiiConnect24
echo ------------------------------
echo @Larsenv, @KcrPL
echo.
echo %text12%
echo 87%%
rmdir /s /q IOS31 >NUL
cls
echo IOS Patcher for RiiConnect24
echo ------------------------------
echo @Larsenv, @KcrPL
echo.
echo %text12%
echo 93%%
rmdir /s /q IOS80 >NUL
cls
echo IOS Patcher for RiiConnect24
echo ------------------------------
echo @Larsenv, @KcrPL
echo.
echo 100%%
timeout 3 /nobreak >NUL
goto end
:end
set /a exiting=10
set /a timeouterror=1
timeout 1 /nobreak >NUL && set /a timeouterror=0
goto end1
:end1
cls
echo IOS Patcher for RiiConnect24
echo ------------------------------
echo @Larsenv, @KcrPL
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
