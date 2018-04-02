echo %~d0%~p0
cd "%~d0%~p0"
@echo off
:: ===========================================================================
:: IOS Patcher for Windows
set version=1.9.0
:: AUTHORS: KcrPL, Larsenv
:: ***************************************************************************
:: Copyright (c) 2018 RiiConnect24, KcrPL and it's (Lead) Developers
:: ===========================================================================
if exist temp.bat del /q temp.bat
:1
set /a copyingsdcard=0
set /a translationsserror=0
:: Window size (Lines, columns)
set mode=126,36
mode %mode%
set error4112=0
set filcheck=0
set patchingok=1
set s=NUL

:: Window Title
title IOS Patcher for RiiConnect24 v.%version%  Created by @Larsenv, @KcrPL
set last_build=2018/04/02
set at=21:45
if exist "C:\Users\%username%\Desktop\IOSPatcherDebug.txt" goto debug_load
:: ### Auto Update ###
:: 1=Enable 0=Disable
:: IOSPatcher_Update_Activate - If disabled, patcher will not even check for updates, default=1
:: offlinestorage - Only used while testing of Update function, default=0
:: FilesHostedOn - The website and path to where the files are hosted. WARNING! DON'T END WITH "/"
:: MainFolder/TempStorage - folder that is used to keep version.txt and whatsnew.txt. These two files are deleted every startup but if offlinestorage will be set 1, they won't be deleted.
set /a IOSPatcher_Update_Activate=1
set /a offlinestorage=0
set FilesHostedOn=https://raw.githubusercontent.com/KcrPL/KcrPL.github.io/master/Patchers_Auto_Update/IOS_Patcher
set MainFolder=%appdata%\IOSPatcher
set TempStorage=%appdata%\IOSPatcher\internet\temp

set header=RiiConnect24 IOS Patcher - (C) Larsenv, (C) KcrPL. v%version% (Compiled on %last_build% at %at%)

if not exist "%MainFolder%" md "%MainFolder%"
if not exist "%TempStorage%" md "%TempStorage%"

:: Checking if I have access to files on your computer
if exist %TempStorage%\checkforaccess.txt del /q %TempStorage%\checkforaccess.txt

echo test >>"%TempStorage%\checkforaccess.txt"
set /a file_access=1
if not exist "%TempStorage%\checkforaccess.txt" set /a file_access=0

if exist "%TempStorage%\checkforaccess.txt" del /q "%TempStorage%\checkforaccess.txt"

:: Cleanup after update
if exist 00000006-31.delta` del /q 00000006-31.delta`
if exist 00000006-80.delta` del /q 00000006-80.delta`
if exist libWiiSharp.dll` del /q libWiiSharp.dll`
if exist Sharpii.exe` del /q Sharpii.exe`
if exist WadInstaller.dll` del /q WadInstaller.dll`
if exist wget.exe` del /q wget.exe`
if exist xdelta3.exe` del /q xdelta3.exe`


:: Trying to prevent running from OS that is not Windows.
if %os%=="" goto not_windows_nt
if not %os%==Windows_NT goto not_windows_nt

set /a versioncheck=0
:: If program is opened as an admin the path will messed up
set /a patherror=0
if "%cd%"=="%windir%\system32" set /a patherror=1
if %patherror%==0 if not exist patch.bat set /a patherror=2

:: Debugging text start
echo :--------------------:
echo.>>"%MainFolder%/IOSPatcherLogs.txt"
echo %header%>>"%MainFolder%/IOSPatcherLogs.txt"
echo Time %time% - Date %date%>>"%MainFolder%/IOSPatcherLogs.txt"
echo.>>"%MainFolder%/IOSPatcherLogs.txt"
echo Program startup>>"%MainFolder%/IOSPatcherLogs.txt"

::Load languages
FOR /F "tokens=2 delims==" %%a IN ('wmic os get OSLanguage /Value') DO set OSLanguage=%%a

if %OSLanguage%==1046 set language=Brazilian&goto set_language_brazilian
if %OSLanguage%==1036 set language=French& goto set_language_french
if %OSLanguage%==1045 set language=Polish& goto set_language_polish
if %OSLanguage%==0413 set language=Dutch& goto set_language_dutch
if %OSLanguage%==1031 set language=German& goto set_language_german
if %OSLanguage%==1055 set language=Turkish& goto set_language_unicode_ask
if %OSLanguage%==1049 set language=Russian& goto set_language_unicode_ask
goto set_language_english

:set_language_unicode_ask
cls
echo %header%
echo -----------------------------------------------------------------------------------------------------------------------------
echo.
echo We're sorry but we cannot load your language [%language%] without changing the code page.
echo.
echo If you are on Windows 7, you need to load English language, if you are on Windows 8.1/10, proceed with loading your language
echo.
echo 1. Proceed with loading %language% language.
echo 2. Load English language.
set /p s=Type the number that you can see above and hit ENTER: 
if %s%==1 goto set_language_%language%
if %s%==2 goto set_language_english
goto set_language_unicode_ask
:set_language_french
mode 140,36
set string1=Attention: Lancez cette application sans les privileges administrateur.
set string2=Attention: patch.bat introuvable. Vous lancez peut-etre cette application depuis une source inconnue. 
set string3=Commencer
set string4=Envoyer un retour/Signaler un bug
set string5=Veuillez nous contacter a support@riiconnect24.net si vous rencontrez un probleme
set string6=Entrez le numero que vous voyez au dessus et appuyez sur Entree:
set string7=Welcome to the feedback sending/Reporting bugs screen.
set string8=Appuyez sur n'importe quelle touche pour enregistrer les logs sur votre bureau.
set string9=Le fichier a ete copie, il se trouve sur votre bureau.
set string10=Maintenant veuillez l'envoyer a support@riiconnect24.net. Et decrivez votre probleme, vous pouvez aussi nous envoyer votre retour.
set string11=Appuyez sur n'importe quelle touche pour continuer.
set string12=Mode sans echec
set string13=Le dernier demarrage a echoue. Lancement en mode sans echec.
set string14=La mise a jour a ete ignoree. 
set string15=Lancement de PowerShell
set string16=Verification des mises a jour...
set string17=Veuillez patienter
set string18=Une mise a jour est disponible
set string19=Une mise a jour pour ce programme est disponible. Nous vous recommandons d'utiliser la derniere version de IOS Patcher.
set string20=Version actuelle
set string21=Nouvelle version
set string22=Mettre a jour
set string23=Ignorer
set string24=Quoi de neuf dans cette version ?
set string25=Mise a jour...
set string26=IOS Patcher va redemarrer prochainement
set string27=Quoi de neuf dans cette mise a jour
set string28=Erreur. Le changelog n'est pas encore disponible.
set string29=Erreur
set string30=Certains fichiers necessaires a l'execution du programme sont indisponibles.
set string31=Appuyez sur n'importe quelle touche pour redemarrer le telechargement.
set string32=Systeme de mise a jour de l'IOS Patcher.
set string33=La derniere version est installee.
set string34=Une mise a jour est disponible.
set string35=Le mode sans echec est active.
set string36=Je n'ai pas acces aux fichiers de votre ordinateur
set string37=Le serveur de mises a jour est indisponible.
set string38=Appuyez sur C pour en savoir plus.
set string39=Configuration
set string40=Allez-vous utiliser ce patcher sur Wii ou Wii U ?
set string41=La derniere version d'IOS Patcher est maintenant installee.
set string42=Le mode sans echec a ete active. Les mises a jour seront ignorees. Redemarrez le patcher pour desactiver le mode sans echec.
set string43=Je n'ai pas acces aux fichiers de votre ordinateur. Cela ne veut pas dire que je suis inutilisable.
set string44=Je vais essayer de patcher les IOS. Cependant les mises a jour ont ete ignorees.
set string45=Impossible de se connecter au serveur de mises a jour. Veuillez verifier votre connexion Internet.
set string46=Cela peut egalement signifier que le serveur de mises a jour est en maintenance.
set string47=Malheureusement, vous ne pouvez pas utiliser ce patcher sur Wii U.
set string48=Nous devons telecharger les IOS 31 et 80.
set string49=Appuyez sur n'importe quelle touche pour commencer la mise a jour.
set string50=Telechargement
set string51=Une erreur est survenue lors du patch.
set string52=Code erreur
set string53=Erreur du module
set string54=Envoyez-nous un mail a support@riiconnect24.net et decrivez-nous votre probleme.
set string55=Verifiez votre connexion Internet.
set string56=Veuillez installer .NET Framework 3.5 et reessayez.
set string57=Erreur de Sharpii.
set string58=Appuyez sur n'importe quelle touche pour retourner au menu principal.
set string59=Le patch est termine.
set string60=Voulez-vous copier les fichiers patches sur la carte SD ?
set string61=Oui
set string62=Non
set string63=Copier les fichiers sur le bureau et sortir
set string64=Copie
set string65=Carte SD
set string66=Aucune carte SD trouvee sur votre ordinateur.
set string67=Veuillez inserer une carte SD et reessayez.
set string68=Lettre du lecteur actuel
set string69=Voulez-vous changer la lettre du lecteur ?
set string70=Continuer et copier les fichiers sur un peripherique externe
set string71=Changer la lettre du lecteur
set string72=Sortie
set string73=Une erreur est survenue lors de la copie des fichiers.
set string74=Merci d'utiliser notre patcher !
set string75=Le patch est termine
set string76=Les fichiers seront copies dans le dossier nomme "WAD".
set string77=Les fichiers ont ete copies sur votre peripherique dans le dossier "WAD"
set string78=Le patcher se fermera dans...
set string79=Tentative de chargement de catacteres diacritiques [Windows 8.1/10]

set language=French
set /a diacritic_show=1
goto begin_main
:set_language_french_diacritic
mode 140,36
chcp 65001
set string1=Attention: Lancez cette application sans les privilèges administrateur.
set string2=Attention: patch.bat introuvable. Vous lancez peut-être cette application depuis une source inconnue. 
set string3=Commencer
set string4=Envoyer un retour/Signaler un bug
set string5=Veuillez nous contacter à support@riiconnect24.net si vous rencontrez un problème
set string6=Entrez le numéro que vous voyez au dessus et appuyez sur Entrée:
set string7=Welcome to the feedback sending/Reporting bugs screen.
set string8=Appuyez sur n'importe quelle touche pour enregistrer les logs sur votre bureau.
set string9=Le fichier a été copié, il se trouve sur votre bureau.
set string10=Maintenant veuillez l'envoyer à support@riiconnect24.net. Et décrivez votre problème, vous pouvez aussi nous envoyer votre retour.
set string11=Appuyez sur n'importe quelle touche pour continuer.
set string12=Mode sans échec
set string13=Le dernier démarrage a échoué. Lancement en mode sans échec.
set string14=La mise à jour a été ignorée. 
set string15=Lancement de PowerShell
set string16=Vérification des mises à jour...
set string17=Veuillez patienter
set string18=Une mise à jour est disponible
set string19=Une mise à jour pour ce programme est disponible. Nous vous recommandons d'utiliser la dernière version de IOS Patcher.
set string20=Version actuelle
set string21=Nouvelle version
set string22=Mettre à jour
set string23=Ignorer
set string24=Quoi de neuf dans cette version ?
set string25=Mise à jour...
set string26=IOS Patcher va redémarrer prochainement
set string27=Quoi de neuf dans cette mise à jour
set string28=Erreur. Le changelog n'est pas encore disponible.
set string29=Erreur
set string30=Certains fichiers nécessaires à l'exécution du programme sont indisponibles.
set string31=Appuyez sur n'importe quelle touche pour redémarrer le téléchargement.
set string32=Système de mise à jour de l'IOS Patcher.
set string33=La dernière version est installée.
set string34=Une mise à jour est disponible.
set string35=Le mode sans échec est activé.
set string36=Je n'ai pas accès aux fichiers de votre ordinateur
set string37=Le serveur de mises à jour est indisponible.
set string38=Appuyez sur C pour en savoir plus.
set string39=Configuration
set string40=Allez-vous utiliser ce patcher sur Wii ou Wii U ?
set string41=La dernière version d'IOS Patcher est maintenant installée.
set string42=Le mode sans échec a été activé. Les mises à jour seront ignorées. Redémarrez le patcher pour désactiver le mode sans échec.
set string43=Je n'ai pas accès aux fichiers de votre ordinateur. Cela ne veut pas dire que je suis inutilisable.
set string44=Je vais essayer de patcher les IOS. Cependant les mises à jour ont été ignorées.
set string45=Impossible de se connecter au serveur de mises à jour. Veuillez vérifier votre connexion Internet.
set string46=Cela peut également signifier que le serveur de mises à jour est en maintenance.
set string47=Malheureusement, vous ne pouvez pas utiliser ce patcher sur Wii U.
set string48=Nous devons télécharger les IOS 31 et 80.
set string49=Appuyez sur n'importe quelle touche pour commencer la mise à jour.
set string50=Téléchargement
set string51=Une erreur est survenue lors du patch.
set string52=Code erreur
set string53=Erreur du module
set string54=Envoyez-nous un mail à support@riiconnect24.net et décrivez-nous votre problème.
set string55=Vérifiez votre connexion Internet.
set string56=Veuillez installer .NET Framework 3.5 et réessayez.
set string57=Erreur de Sharpii.
set string58=Appuyez sur n'importe quelle touche pour retourner au menu principal.
set string59=Le patch est terminé.
set string60=Voulez-vous copier les fichiers patchés sur la carte SD ?
set string61=Oui
set string62=Non
set string63=Copier les fichiers sur le bureau et sortir
set string64=Copie
set string65=Carte SD
set string66=Aucune carte SD trouvée sur votre ordinateur.
set string67=Veuillez insérer une carte SD et réessayez.
set string68=Lettre du lecteur actuel
set string69=Voulez-vous changer la lettre du lecteur ?
set string70=Continuer et copier les fichiers sur un périphérique externe
set string71=Changer la lettre du lecteur
set string72=Sortie
set string73=Une erreur est survenue lors de la copie des fichiers.
set string74=Merci d'utiliser notre patcher !
set string75=Le patch est terminé
set string76=Les fichiers seront copiés dans le dossier nommé "WAD".
set string77=Les fichiers ont été copiés sur votre périphérique dans le dossier "WAD"
set string78=Le patcher se fermera dans...
set string79=Tentative de chargement de catactères diacritiques [Windows 8.1/10]

set language=French
set /a diacritic_show=0
goto begin_main

:set_language_russian
mode 139,36
chcp 65001
set string1=Внимание: Пожалуйста запустите эту программу без административных привилегий.
set string2=Вниминие: patch.bat не найден. Возможно, вы запускаете эту программу из неизвестного и ненадёжного источника.
set string3=Запуск
set string4=Написать разработчикам/Сообщить о баге
set string5=Пожалуйста посылайте письма на support@riiconnect24.net если у вас есть проблемы
set string6=Введите одно из чисел, которые вы видите выше и нажмите ENTER
set string7=Добро пожаловать в экран обратной связи.
set string8=Нажмите любую клавишу чтобы копировать файл журнала на рабочий стол.
set string9=Файл был копирован, он находится на вашем рабочем столе.
set string10=Пожалуйста отправьте его на support@riiconnect24.net, и обязательно опишите вашу проблему или что вы думайте о программе! :)
set string11=Нажмите любую клавишу чтобы продолжить.
set string12=Безопасный режим.
set string13=Последний запуск был неудачным. Программа запускается в безопасном режиме.
set string14=Обновление пропущено. 
set string15=Launching powershell
set string16=Проверка обновлений
set string17=Пожалуйста подождите
set string18=Доступно обновление
set string19=Доступно обновление для программы. Мы рекоммендуем вам обновить IOS Patcher до последней версии.
set string20=Текущая версия
set string21=Новая версия
set string22=Обновить
set string23=Отклонить
set string24=Что нового в этом обновлении?
set string25=Идёт обновление
set string26=IOS Patcher скоро перезапустится
set string27=Что нового в этом обновлении
set string28=Ошибка. Что нового сейчас не доступно.
set string29=Ошибка
set string30=Некоторые файлы, нужные для работы программы не были найдены.
set string31=Нажмите любую клавишу чтобы заного скачать эти файлы.
set string32=Система обновления IOS Patcher.
set string33=Установлена последняя версия.
set string34=Доступно обновление.
set string35=Включён безопасный режим.
set string36=Нет доступа к файлам на компьютере.
set string37=Сервер обновлений не доступен
set string38=Нажмите C чтобы прочитать больше.
set string39=Идёт конфигурация
set string40=Вы будите использовать этот патчер для Wii или WiiU?
set string41=Установлена последняя версия IOS Patcher'а.
set string42=Включён безопасный режим. Обновления пропущены. Пожалуйста перезапустите патчер чтобы отключить безопасный режим.
set string43=Нет доступа к файлам на компьютере. Это не значит, что программа не сможет работать.
set string44=Будет попытка пропатчить IOS, но обновления были пропущены.
set string45=Не получилось подключиться к серверу обновлений. Пожалуйста проверьте ваше интернет соединение.
set string46=Это также может озночать, что сервер находится под техобслуживанием.
set string47=К сожалению, этот патчер не работает с WiiU.
set string48=Будут скачаны IOS 31 и 80.
set string49=Нажмите любую клавишу чтобы начать скачивать.
set string50=Идёт скачивание
set string51=Произошла ошибка во время патчинга.
set string52=Код Ошибки
set string53=Провальный модуль
set string54=Пожалуйста напишите нам на support@riiconnect24.net и опишите вашу проблему нам.
set string55=Пожалуйтса проверьте ваше интернет соединение.
set string56=Пожалуйста установите .NET Framework 3.5, и попытайтесь пропатчить опять.
set string57=Ошибка Sharpii.
set string58=Нажмите любую клавишу чтобы вернуться в главное меню.
set string59=Патчинг завершён.
set string60=Хотите ли вы скопировать пропатченные файлы на SD карту?
set string61=Да
set string62=Нет
set string63=Скопировать файлы на рабочий стол и выйти.
set string64=Идёт копирование
set string65=SD карта
set string66=В системе не была найдена SD карта.
set string67=Пожалуйста подключите SD карту и нажмите любую клавишу чтобы попытаться опять.
set string68=Текущая буква SD карты
set string69=Хотите ли вы поменять букву SD карты?
set string70=Продолжить и скопировать файлы на SD карту.
set string71=Изменить букву тома.
set string72=Выйти
set string73=Произошла ошибка во время копирования файлов.
set string74=Спасибо за использование патчера!
set string75=Патчинг завершён
set string76=Пропатчанные IOS файлы будут в папке "WAD".
set string77=Файлы были копированы на SD карту в папку "WAD"
set string78=Выход из патчера через...

set language=Russian
set /a diacritic_show=0
goto begin_main

:set_language_turkish
chcp 65001
set mode=132,36
mode %mode%

set string1=Uyarı: Yönetici izini olmadan uygulamayı başlatınız.
set string2=Uyarı: patch.bat bulunamadı büyük olasılıkla bilinmeyen yada güvenilmeyen bir kaynaktan uygulamayı çalıştırıyorsunuz.
set string3=Başlat
set string4=Hata bildir.
set string5=Lütfen sorun yaşıyorsanız bize support@riiconnect24.net üzerinden ulaşın.
set string6=Yukarıda gördüğünüz numarayı tuşlayınız ve ENTER'a basınız.
set string7=Hata bildirme ekranına hoş geldiniz.
set string8=Kayıtların kopyasını masaüstünüze aktarmak için bir tuşa basınız.
set string9=Dosya kopyalandı. Şuan masaüstünde.
set string10=Şimdi support@riiconnect24.net adresine gönder ve bize sorununu anlat. :)
set string11=Devam etmek için herhangi bir tuşu tuşlayınız.
set string12=Güvenli Mod
set string13=En son programı açışınızda önyükleme başarısız oldu, güvenli mod başlatılıyor.
set string14=Güncelleme atlandı.
set string15=Powershell başlatılıyor
set string16=Güncellemeler denetleniyor
set string17=Lütfen bekleyin
set string18=Yeni bir güncelleme mevcut
set string19=Güncellemeyi yapmanızı öneriyoruz.
set string20=Şuanki sürüm
set string21=Yeni sürüm
set string22=Güncelle
set string23=Yoksay
set string24=Bu güncellemedeki yenilikler
set string25=Güncelleniyor
set string26=IOS Patcher yeniden başlatılacak.
set string27=Güncellemedeki yenilikler
set string28=Hata: güncellemedeki yeniliklere şuan ulaşılamıyor
set string29=Hata
set string30=Bazı dosyalar bulunamadı.
set string31=Bu dosyaları indirmek için bir tuşa basınız.
set string32=IOS Patcher Güncelleme Sistemi
set string33=Son sürüm indirildi.
set string34=Bir güncelleme mevcut.
set string35=Güvenli mod aktif edildi.
set string36=Bilgisayardaki dosyalara yazma yetkim yok.
set string37=Güncelleme servisine ulaşılamıyor.
set string38=Daha fazla okumak için C tuşuna basınız
set string39=Ayarlanıyor
set string40=Bu yama aracını Wii için mi yoksa Wii U için mi kullanacaksınız?
set string41=IOS Patcher'ın son sürümü indirildi.
set string42=Güvenli mod açık, güncelleme yapamazsınız. Güvenli moddan çıkmak için yama yapıcıyı yeniden başlatın.
set string43=Bilgisayarındaki dosyalara erişim iznim yok yani işimi yapamam.
set string44=IOS'a yama yapmaya çalışıcam ama güncelleme yapamıyacam
set string45=Güncelleme servisine bağlanamadık. Lütfen interneti kontrol edin.
set string46=Ayrıca sunucu da bakımda olabilir.
set string47=Üzgünüz ama bu yama yapıcıyı Wii U için kullanamazsınız
set string48=IOS 31 ve 80'i yüklememiz lazım.
set string49=İndirmeyi başlatmak için her hangi bir tuşa basınız.
set string50=Yİndiriliyor
set string51=Yama yaparken hata oluştu
set string52=Hata Kodu
set string53=Başarısız olan modül
set string54=support@riiconnect24.net adresine sorununuzu anlatın.
set string55=İnternet bağlantınızı kontrol edin
set string56=Lütfen .NET Framework 3.5'i indirin ve yama yapıcıyı yeniden deneyin.
set string57=Genel hata: Sharpii
set string58=Ana menüye dönmek için bir tuşa basınız.
set string59=Yama yapma tamamlandı
set string60=Yama yapılan dosyaları SD Karta aktarmamızı ister misiniz?
set string61=Evet
set string62=Hayır
set string63=Dosyaları masaüstüne kopyala ve çık
set string64=Kopyalanıyor
set string65=SD Kart
set string66=Sistem SD Kart bulunamadı.
set string67=SD Kartı takınız ve yeniden denemek için bir tuşa basınız.
set string68=Şuanki Letterbomb
set string69=SD Kartaki Letterbomb'u değiştirmek ister misiniz?
set string70=Dosyaları SD Karta taşı ve devam et
set string71=Sürücü mesajını değiştir
set string72=Çık
set string73=Dosyalar aktarılırken hata oluştu.
set string74=IOS Patcherı kullandığınız için teşekür ederiz!
set string75=Yama yapımı tamamlandı
set string76=Yama yapılan IOSları "WAD" adlı klasöre koyunuz.
set string77=Dosyalar "WAD" adlı klasöre kopyalandı.
set string78=IOS Patcherdan çıkılmasına...
set string79=Ayrıcı karakterler yüklenmeye çalışıldı. [Windows 8.1/10]

set language=Turkish
set /a diacritic_show=0
goto begin_main

:set_language_english
set mode=126,36
mode %mode%

set string1=Warning: Please run this application without admin privilages.
set string2=Warning: patch.bat not found. You may be running this application from unknown and untrusted source. 
set string3=Start
set string4=Send feedback/Report a bug
set string5=Please mail us at support@riiconnect24.net if you have problems
set string6=Type the number that you can see above and hit ENTER
set string7=Welcome to the feedback sending/Reporting bugs screen.
set string8=Press any key to copy the logs file to the Desktop.
set string9=The file has been copied, it's now on your desktop.
set string10=Now please send it to support@riiconnect24.net. And please describe your problem or tell us your feedback! :)
set string11=Press any key to continue.
set string12=Safe mode
set string13=Last BootUp was unsuccessfull. Launching in safe mode.
set string14=Updating has been skipped. 
set string15=Launching powershell
set string16=Checking for updates
set string17=Please wait
set string18=An Update is available
set string19=An Update for this program is available. We suggest updating the IOS Patcher to the latest version.
set string20=Current version
set string21=New version
set string22=Update	
set string23=Dismiss
set string24=What's new in this update?
set string25=Updating
set string26=IOS Patcher will restart shortly
set string27=What's new in update
set string28=Error. What's new is not available at the moment.
set string29=Error
set string30=Some files needed to run this program weren't found.
set string31=Press any key to redownload these files.
set string32=IOS Patcher Update System.
set string33=The latest version is installed.
set string34=An Update is available.
set string35=Safe mode activated.
set string36=I don't have access to files on your computer
set string37=Update Server is not available.
set string38=Press C to read more.
set string39=Configuring
set string40=Are you gonna be using this patcher for Wii or WiiU?
set string41=The latest version of IOS Patcher is now installed.
set string42=Safe mode is turned on. Updating has been skipped. Please restart the patcher to disable safe mode.
set string43=I don't have access to files on your computer. That doesn't mean that I can't work.
set string44=I will try to patch IOS's. But updating has been skipped.
set string45=We could not connect to the update server. Please check your internet connection.
set string46=It can also mean that the server is under maintance now.
set string47=Unfortunately, you cannot use this patcher for Wii U.
set string48=We need to download IOS 31 and 80.
set string49=Press any button to proceed to download.
set string50=Downloading
set string51=There was an error while patching.
set string52=Error Code
set string53=Failing module
set string54=Please mail us at support@riiconnect24.net and describe your problem to us.
set string55=Please check your internet connection.
set string56=Please install .NET Framework 3.5, then try to patch again.
set string57=Sharpii general failure.
set string58=Press any key to return to main menu.
set string59=Patching is done.
set string60=Do you want to copy patched files to an SD Card?
set string61=Yes
set string62=No
set string63=Copy files to Desktop and exit
set string64=Copying
set string65=SD Card
set string66=An SD card was not found in the system.
set string67=Please connect SD Card and press any key to try again.
set string68=Current SD Card Letter
set string69=Do you want to change SD Card drive letter?
set string70=Continue and copy files to SD Card
set string71=Change drive letter
set string72=Exit
set string73=There was an error while copying files.
set string74=Thanks for using the Patcher!
set string75=Patching is done
set string76=Patched IOS files will be in folder called "WAD".
set string77=Files has been copied to SD Card to folder called "WAD"
set string78=Exiting the patcher in...
set string79=Attempt to load diacritic characters [Windows 8.1/10]

set language=English
set /a diacritic_show=0
goto begin_main
:set_language_german
mode 156,36

set string1=Warnung: Bitte fuhre dieses Programm ohne Administrator-Rechte aus.
set string2=Warnung: Die Datei patch.bat wurde nicht gefunden.
set string3=Start
set string4=Feedback senden/Einen Bug melden
set string5=Bitte sende uns eine E-Mail an support@riiconnect24.net wenn du Probleme mit diesem Programm hast
set string6=Tippe die Nummer die du uber diesem Text siehst ein und benutze die ENTER-Taste
set string7=Willkommen in der Sektion, wo du Feedback abgeben oder einen Bug melden kannst
set string8=Drucke irgendeine Taste um den Log auf dem Desktop abzuspeichern.
set string9=Die Datei wurde auf deinen Desktop kopiert.
set string10=Bitte sende die Datei an support@riiconnect24.net. Und bitte, beschreibe dein Problem oder gebe dein Feedback ab! :)
set string11=Drucke irgendeine Taste um fortzufahren
set string12=Abgesicherter Modus
set string13=Das letzte mal, als du das Programm gestartet hast, hat irgendwas nicht funktioniert. Das Programm startet num im abgesicherten Modus.
set string14=Das Updaten des Programmes wurde ubersprungen.
set string15=Die "PowerShell" wird gestartet.
set string16=Suche nach Updates
set string17=Bitte warten
set string18=Ein Update ist verfugbar
set string19=Es ist ein Update fur dieses Programm verfugbar. Wir empfehlen dir, den IOS Patcher zu updaten.
set string20=Aktuelle Version
set string21=Neue Version
set string22=Update
set string23=Dismib
set string24=Was gibt es neues in diesem Update?
set string25=Updating
set string26=Der IOS Patcher wird bald neustarten
set string27=Was gibt es neues in diesem Update?
set string28=Fehler. Der Changelog ist momentan nicht verfugbar.
set string29=Error
set string30=Einige Dateien die gebraucht werden, damit du dieses Programm benutzen kannst, wurden nicht gefunden. 
set string31=Drucke irgendeine Taste um die Dateien neu herunterzuladen.
set string32=IOS Patcher Update System.
set string33=Die neueste Version ist installiert.
set string34=Ein Update ist verfugbar.
set string35=Der abgesicherte Modus wurde aktiviert.
set string36=Ich kann nicht auf die Dateien von deinem Computer zugreifen.
set string37=Ich kann keine Verbindung zum Update-Server herstellen
set string38=Drucke "C" um weiterzulesen.
set string39=Konfigurieren
set string40=Wirst du diesen Patcher fur die Wii oder fur die Wii U benutzen?
set string41=Die neueste Version vom IOS Patcher ist nun installiert.
set string42=Der abgesicherte Modus ist aktiviert. Das Updaten wurde ubersprungen. Bitte starte den Patcher neu, um den abgesicherten Modus zu deaktivieren.
set string43=Ich habe keinen zugriff auf die Dateien auf deinem Computer. Ich funktioniere trotzdem
set string44=Ich werde versuchen die IOS' zu patchen. Aber das updaten wurde ubersprungen.
set string45=Ich konnte mich nicht mit dem Update Server verbinden. Bitte schau' nach, ob deine Internetverbindung funktioniert.
set string46=Es konnte aber auch sein, das der Server momentan im Wartungsmodus ist.
set string47=Leider kannst du diesen Patcher nicht fur die Wii U benutzen.
set string48=Ich mub IOS 31 & 30 runterladen.
set string49=Drucke irgendeine Taste um den download zu starten.
set string50=Download...
set string51=Es gab einen Fehler wahrend dem patchen
set string52=Fehlercode
set string53=Nicht funktionierendes Modul
set string54=Bitte schreibe eine Mail an support@riiconnect24.net und beschreibe dein Problem.
set string55=Bitte uberprufe, ob deine Internetverbindung funktioniert.
set string56=Bitte installiere .NET Framework 3.5 und versuche das Patchen danach nochmal
set string57=Sharpii hat nicht funktioniere
set string58=Drucke irgendeine Taste um zum Hauptmenu zuruckzukehren.
set string59=Ich bin Fertig mit dem patchen.
set string60=Mochtest du die gepatchten Dateien auf eine SD-Karte kopieren?
set string61=Ja
set string62=Nein
set string63=Kopiere die Dateien auf den Desktop und schliebe
set string64=Kopiere
set string65=SD Karte
set string66=Ich konnte keine SD Karte, die mit deinem Computer verbunden ist, finden.
set string67=Bitte schliebe eine SD Karte an deinen Computer an und drucke danach irgendeine Taste um fortzufahren
set string68=Deine aktuell gewahlte SD Karte hat den Laufwerksbuchstaben 
set string69=Mochtest du eine andere SD Karte wahlen
set string70=Kopiere die Dateien auf die SD Karte und fahre fort
set string71=andere den Laufwerksbuchstaben
set string72=Schlieben
set string73=Es gab einen Fehler, wahrend die Dateien gepatcht wurden.
set string74=Danke das du diesen Patcher benutzt hast.
set string75=Ich bin fertig mit dem patchen.
set string76=Die gepatchten Dateien werden sich in dem Ordner "WAD" befinden.
set string77=Die Dateien wurden auf die SD Karte in den Ordner "WAD" kopiert.
set string78=Der Patcher wird geschloben in...
set string79=Ich versuche gerade diakritische Zeichen zu laden... [Das funktioniert auf Windows 7 nicht]

set language=German
set /a diacritic_show=1
goto begin_main
:set_language_german_diacritic
mode 156,36
chcp 65001
set string1=Warnung: Bitte führe dieses Programm ohne Administrator-Rechte aus.
set string2=Warnung: Die Datei patch.bat wurde nicht gefunden.
set string3=Start
set string4=Feedback senden/Einen Bug melden
set string5=Bitte sende uns eine E-Mail an support@riiconnect24.net wenn du Probleme mit diesem Programm hast
set string6=Tippe die Nummer die du über diesem Text siehst ein und benutze die ENTER-Taste
set string7=Willkommen in der Sektion, wo du Feedback abgeben oder einen Bug melden kannst
set string8=Drücke irgendeine Taste um den Log auf dem Desktop abzuspeichern.
set string9=Die Datei wurde auf deinen Desktop kopiert.
set string10=Bitte sende die Datei an support@riiconnect24.net. Und bitte, beschreibe dein Problem oder gebe dein Feedback ab! :)
set string11=Drücke irgendeine Taste um fortzufahren
set string12=Abgesicherter Modus
set string13=Das letzte mal, als du das Programm gestartet hast, hat irgendwas nicht funktioniert. Das Programm startet num im abgesicherten Modus.
set string14=Das Updaten des Programmes wurde übersprungen.
set string15=Die "PowerShell" wird gestartet.
set string16=Suche nach Updates
set string17=Bitte warten
set string18=Ein Update ist verfügbar
set string19=Es ist ein Update für dieses Programm verfügbar. Wir empfehlen dir, den IOS Patcher zu updaten.
set string20=Aktuelle Version
set string21=Neue Version
set string22=Update
set string23=Dismiss
set string24=Was gibt es neues in diesem Update?
set string25=Updating
set string26=Der IOS Patcher wird bald neustarten
set string27=Was gibt es neues in diesem Update?
set string28=Fehler. Der Changelog ist momentan nicht verfügbar.
set string29=Error
set string30=Einige Dateien die gebraucht werden, damit du dieses Programm benutzen kannst, wurden nicht gefunden. 
set string31=Drücke irgendeine Taste um die Dateien neu herunterzuladen.
set string32=IOS Patcher Update System.
set string33=Die neueste Version ist installiert.
set string34=Ein Update ist verfügbar.
set string35=Der abgesicherte Modus wurde aktiviert.
set string36=Ich kann nicht auf die Dateien von deinem Computer zugreifen.
set string37=Ich kann keine Verbindung zum Update-Server herstellen
set string38=Drücke "C" um weiterzulesen.
set string39=Konfigurieren
set string40=Wirst du diesen Patcher für die Wii oder für die Wii U benutzen?
set string41=Die neueste Version vom IOS Patcher ist nun installiert.
set string42=Der abgesicherte Modus ist aktiviert. Das Updaten wurde übersprungen. Bitte starte den Patcher neu, um den abgesicherten Modus zu deaktivieren.
set string43=Ich habe keinen zugriff auf die Dateien auf deinem Computer. Ich funktioniere trotzdem
set string44=Ich werde versuchen die IOS' zu patchen. Aber das updaten wurde übersprungen.
set string45=Ich konnte mich nicht mit dem Update Server verbinden. Bitte schau' nach, ob deine Internetverbindung funktioniert.
set string46=Es könnte aber auch sein, das der Server momentan im Wartungsmodus ist.
set string47=Leider kannst du diesen Patcher nicht für die Wii U benutzen.
set string48=Ich muss IOS 31 & 30 runterladen.
set string49=Drücke irgendeine Taste um den download zu starten.
set string50=Download...
set string51=Es gab einen Fehler während dem patchen
set string52=Fehlercode
set string53=Nicht funktionierendes Modul
set string54=Bitte schreibe eine Mail an support@riiconnect24.net und beschreibe dein Problem.
set string55=Bitte überprüfe, ob deine Internetverbindung funktioniert.
set string56=Bitte installiere .NET Framework 3.5 und versuche das Patchen danach nochmal
set string57=Sharpii hat nicht funktioniere
set string58=Drücke irgendeine Taste um zum Hauptmenü zurückzukehren.
set string59=Ich bin Fertig mit dem patchen.
set string60=Möchtest du die gepatchten Dateien auf eine SD-Karte kopieren?
set string61=Ja
set string62=Nein
set string63=Kopiere die Dateien auf den Desktop und schließe
set string64=Kopiere
set string65=SD Karte
set string66=Ich konnte keine SD Karte, die mit deinem Computer verbunden ist, finden.
set string67=Bitte schließe eine SD Karte an deinen Computer an und drücke danach irgendeine Taste um fortzufahren
set string68=Deine aktuell gewählte SD Karte hat den Laufwerksbuchstaben 
set string69=Möchtest du eine andere SD Karte wählen
set string70=Kopiere die Dateien auf die SD Karte und fahre fort
set string71=Ändere den Laufwerksbuchstaben
set string72=Schließen
set string73=Es gab einen Fehler, während die Dateien gepatcht wurden.
set string74=Danke das du diesen Patcher benutzt hast.
set string75=Ich bin fertig mit dem patchen.
set string76=Die gepatchten Dateien werden sich in dem Ordner "WAD" befinden.
set string77=Die Dateien wurden auf die SD Karte in den Ordner "WAD" kopiert.
set string78=Der Patcher wird geschlossen in...
set string79=Ich versuche gerade diakritische Zeichen zu laden... [Das funktioniert auf Windows 7 nicht

set language=German
set /a diacritic_show=0
goto begin_main


:set_language_polish_diacritic
mode 143,36
chcp 65001
set string1=Uwaga: Proszę uruchomić tą aplikacje bez uprawnień administratora.
set string2=Uwaga: patch.bat nie zostało znalezione. Ta aplikacja została prawdopobodnie uruchomiona z nieznanego lub niebezpiecznego źródła.
set string3=Start
set string4=Wyślij opinie/Zgłoś błąd.
set string5=Napisz do support@riiconnect24.net jeśli masz problemy [Obsługa dostępna po polsku]
set string6=Wpisz numer który widzisz powyżej i wciśnij ENTER
set string7=Witaj na ekranie zgłaszania opinii/Zgłaszania błędów.
set string8=Naciśnij dowolny przycisk aby skopiować plik z logami na twój pulpit.
set string9=Plik został skopiowany, znajduje się on na twoim pulpicie.
set string10=Teraz wyślij go do support@riiconnect24.net i opisz nam twój problem lub przekaż opinię.
set string11=Naciśnij dowolny przycisk aby kontynuować.
set string12=Tryb awaryjny
set string13=Ostatnie uruchomienie zakończyło się niepowodzeniem. Uruchamianie w trybie awaryjnym.
set string14=Aktualizowanie zostało pominięte. 
set string15=Uruchamianie powershell
set string16=Sprawdzanie aktualizacji
set string17=Proszę czekać
set string18=Dostępna jest aktualizacja
set string19=Aktualizacja dla tego programu jest dostępne. Sugerujemy aktualizowanie IOS Patcher do najnowszej wersji.
set string20=Obecna wersja
set string21=Nowa wersja
set string22=Aktualizuj
set string23=Opuść
set string24=Co nowego w tej aktualizacji?
set string25=Aktualizowanie
set string26=IOS Patcher zostanie wkrótce ponownie uruchomiony
set string27=Co nowego w tej aktualizacji
set string28=Błąd. Co nowego nie jest chwilowo nie dostepne.
set string29=Błąd
set string30=Kilka plików wymaganych do uruchomienia tego programu nie zostało znalezionych.
set string31=Naciśnij dowolny przycisk aby pobrać te pliki.
set string32=System aktualizacji IOS Patcher
set string33=Najnowsza wersja została zainstalowana.
set string34=Dostępna jest aktualizacja
set string35=Tryb awaryjny aktywowany.
set string36=Nie mam dostępu do plików na twoim komputerze
set string37=Serwer aktualizacji nie jest dostępny
set string38=Naciśnij C aby przeczytać więcej.
set string39=Konfigurowanie
set string40=Będziesz używał tego patchera dla Wii czy Wii U?
set string41=Najnowsza wersja IOS Patcher jest już zainstalowana.
set string42=Tryb awaryjny został włączony. Aktualizowanie zostało pominięte. Proszę uruchom ponownie tą aplikacje aby wyłączyć tryb awaryjny.
set string43=Nie mam dostępu do plików na twoim komputerze. To nie znaczy że nie będę działać.
set string44=Spróbuje zastosować poprawkę na plikach IOS ale aktualizacja została pominięta.
set string45=Nie mogliśmy połączyć się z serwerem aktualizacji. Sprawdź połączenie internetowe.
set string46=Może to też oznaczać że odbywa się teraz konserwacja serwera.
set string47=Niestety, nie możesz używać tego patchera na Wii U.
set string48=Musimy pobrać IOS 31 oraz IOS 80.
set string49=Naciśnij dowolny przycisk aby rozpocząć pobieranie
set string50=Pobierania
set string51=Wystąpił błąd podczas stosowania poprawki
set string52=Kod błędu
set string53=Niepowodzenie modułu
set string54=Napisz do support@riiconnect24.net i opisz nam twój problem. Obsługa dostępna po polsku.
set string55=Proszę sprawdź twoje połącznie internetowe.
set string56=Proszę zainstalować .NET Framework 3.5 i spróbuj ponownie.
set string57=Ogólny błąd Sharpii.
set string58=Naciśnij dowolny przycisk aby powrócić do głównego menu.
set string59=Stosowanie poprawki zostało zakończone sukcesem.
set string60=Czy chcesz skopiować spatchowany plik na kartę SD?
set string61=Tak
set string62=Nie
set string63=Skopiuj pliki na pulpit i wyjdź.
set string64=Kopiowanie
set string65=Karta SD
set string66=Karta SD nie została znaleziona.
set string67=Proszę podłączyć kartę SD i naciśnij dowolny przycisk aby spróować ponownie.
set string68=Zmień literę karty SD
set string69=Czy chcesz zmienić obecną litere karty SD?
set string70=Kontynuuj i skopiuj pliki na karte SD
set string71=Zmień literę karty SD
set string72=Wyjdź
set string73=Wystąpił błąd podczas kopiowania plików.
set string74=Dziekuję za korzystanie z patchera!
set string75=Stosowanie poprawki jest gotowe
set string76=Pliki z poprawką są w folderze "WAD".
set string77=Pliki zostały skopiowane na kartę SD do folderu "WAD"
set string78=Wychodzenie z patchera za...
set string79=Sprobuj zaladowac znaki diakrytyczne [Windows 8.1/10]


set language=Polish
set /a diacritic_show=0
goto begin_main
:set_language_polish
mode 143,36
set string1=Uwaga: Prosze uruchomic ta aplikacje bez uprawnien administratora.
set string2=Uwaga: patch.bat nie zostalo znalezione. Ta aplikacja zostala prawdopobodnie uruchomiona z nieznanego lub niebezpiecznego zrodla.
set string3=Start
set string4=Wyslij opinie/Zglos blad.
set string5=Napisz do support@riiconnect24.net jesli masz problemy [Obsluga dostepna po polsku]
set string6=Wpisz numer ktory widzisz powyzej i wcisnij ENTER
set string7=Witaj na ekranie zglaszania opinii/Zglaszania bledow.
set string8=Nacisnij dowolny przycisk aby skopiowac plik z logami na twoj pulpit.
set string9=Plik zostal skopiowany, znajduje sie on na twoim pulpicie.
set string10=Teraz wyslij go do support@riiconnect24.net i opisz nam twoj problem lub przekaz opinie.
set string11=Nacisnij dowolny przycisk aby kontynuowac.
set string12=Tryb awaryjny
set string13=Ostatnie uruchomienie zakonczylo sie niepowodzeniem. Uruchamianie w trybie awaryjnym.
set string14=Aktualizowanie zostalo pominiete. 
set string15=Uruchamianie powershell
set string16=Sprawdzanie aktualizacji
set string17=Prosze czekac
set string18=Dostepna jest aktualizacja
set string19=Aktualizacja dla tego programu jest dostepne. Sugerujemy aktualizowanie IOS Patcher do najnowszej wersji.
set string20=Obecna wersja
set string21=Nowa wersja
set string22=Aktualizuj
set string23=Opusc
set string24=Co nowego w tej aktualizacji?
set string25=Aktualizowanie
set string26=IOS Patcher zostanie wkrotce ponownie uruchomiony
set string27=Co nowego w tej aktualizacji
set string28=Blad. Co nowego nie jest chwilowo nie dostepne.
set string29=Blad
set string30=Kilka plikow wymaganych do uruchomienia tego programu nie zostalo znalezionych.
set string31=Nacisnij dowolny przycisk aby pobrac te pliki.
set string32=System aktualizacji IOS Patcher
set string33=Najnowsza wersja zostala zainstalowana.
set string34=Dostepna jest aktualizacja
set string35=Tryb awaryjny aktywowany.
set string36=Nie mam dostepu do plikow na twoim komputerze
set string37=Serwer aktualizacji nie jest dostepny
set string38=Nacisnij C aby przeczytac wiecej.
set string39=Konfigurowanie
set string40=Bedziesz uzywal tego patchera dla Wii czy Wii U?
set string41=Najnowsza wersja IOS Patcher jest juz zainstalowana.
set string42=Tryb awaryjny zostal wlaczony. Aktualizowanie zostalo pominiete. Prosze uruchom ponownie ta aplikacje aby wylaczyc tryb awaryjny.
set string43=Nie mam dostepu do plikow na twoim komputerze. To nie znaczy ze nie bede dzialac.
set string44=Sprobuje zastosowac poprawke na plikach IOS ale aktualizacja zostala pominieta.
set string45=Nie moglismy polaczyc sie z serwerem aktualizacji. Sprawdz polaczenie internetowe.
set string46=Moze to tez oznaczac ze odbywa sie teraz konserwacja serwera.
set string47=Niestety, nie mozesz uzywac tego patchera na Wii U.
set string48=Musimy pobrac IOS 31 oraz IOS 80.
set string49=Nacisnij dowolny przycisk aby rozpoczac pobieranie
set string50=Pobierania
set string51=Wystapil blad podczas stosowania poprawki
set string52=Kod bledu
set string53=Niepowodzenie modulu
set string54=Napisz do support@riiconnect24.net i opisz nam twoj problem. Obsluga dostepna po polsku.
set string55=Prosze sprawdz twoje polacznie internetowe.
set string56=Prosze zainstalowac .NET Framework 3.5 i sprobuj ponownie.
set string57=Ogolny blad Sharpii.
set string58=Nacisnij dowolny przycisk aby powrocic do glownego menu.
set string59=Stosowanie poprawki zostalo zakonczone sukcesem.
set string60=Czy chcesz skopiowac spatchowany plik na karte SD?
set string61=Tak
set string62=Nie
set string63=Skopiuj pliki na pulpit i wyjdz.
set string64=Kopiowanie
set string65=Karta SD
set string66=Karta SD nie zostala znaleziona.
set string67=Prosze podlaczyc karte SD i nacisnij dowolny przycisk aby sproowac ponownie.
set string68=Zmien litere karty SD
set string69=Czy chcesz zmienic obecna litere karty SD?
set string70=Kontynuuj i skopiuj pliki na karte SD
set string71=Zmien litere karty SD
set string72=Wyjdz
set string73=Wystapil blad podczas kopiowania plikow.
set string74=Dziekuje za korzystanie z patchera!
set string75=Stosowanie poprawki jest gotowe
set string76=Pliki z poprawka sa w folderze "WAD".
set string77=Pliki zostaly skopiowane na karte SD do folderu "WAD"
set string78=Wychodzenie z patchera za...
set string79=Sprobuj zaladowac znaki diakrytyczne [Windows 8.1/10]

set language=Polish
set /a diacritic_show=1
goto begin_main

:set_language_dutch_diacritic
mode 137,36
chcp 65001
set string1=Waarschuwing: Gebruik alstublieft deze applicatie zonder administratierechten.
set string2=Waarschuwing: patch.bat niet gevonden. Het kan zijn dat je deze applicatie van een onbekende en onbetrouwbare bron an het uitvoeren bent.
set string3=Start
set string4=Stuur feedback/Rapporteer een fout
set string5=Mail alstublieft naar support@riiconnect24.net mocht je problemen ondervinden
set string6=Typ het nummer dat je hierboven ziet en druk op ENTER.
set string7=Welkom bij het feedback- en foutrapportagescherm
set string8=Druk op een toets om het logbestand naar het Bureaublad te kopiëren.
set string9=Het bestand is naar je bureaublad gekopieerd.
set string10=Verstuur het nu alstublieft naar support@riiconnect24.net. Omschrijf het probleem en geef je feedback. :)
set string11=Druk op een toets om door te gaan.
set string12=Veilige modus
set string13=pstarten was de vorige keer mislukt. Opstarten in veilige modus.
set string14=Het updaten is overgeslagen.
set string15=Powershell opstarten
set string16=Op updates nakijken
set string17=Een ogenblik geduld a.u.b.
set string18=Er is een update beschikbaar
set string19=r is een update voor dit programma beschikbaar. We raden je aan IOS Patcher te updaten naar de nieuwste versie.
set string20=Huidige versie
set string21=Nieuwe versie
set string22=Update
set string23=Negeren
set string24=Wat is nieuw in deze update?
set string25=Updaten
set string26=IOS Patcher zal zometeen herstarten
set string27=Wat is nieuw in deze update
set string28=Fout: "Wat is nieuw" is op dit moment niet beschikbaar.
set string29=Fout
set string30=Sommige bestanden die dit programma vereist om uitgevoerd te worden zijn niet gevonden.
set string31=Druk op een toets om deze bestanden opnieuw te downloaden.
set string32=IOS Patcher Update Systeem.
set string33=De nieuwste versie is geïnstalleerd.
set string34=Een update is beschikbaar.
set string35=Veilige modus geactiveerd.
set string36=Ik heb geen toegang tot de bestanden op je computer.
set string37=De update-server is niet beschikbaar.
set string38=Druk op C om hier meer over te lezen
set string39=Configureren
set string40=Ga je deze patcher voor de Wii of Wii U gebruiken?
set string41=De nieuwste versie van IOS Patcher is nu geïnstalleerd.
set string42=Veilige modus is ingeschakeld. Updaten is overgeslagen. Restart de patcher alsjeblieft om de veilige modus uit te schakelen.
set string43=Ik heb geen toegang tot bestanden op je computer. Dat betekent echter niet dat ik niet kan werken.
set string44=Ik zal proberen om de IOSes te downloaden. Het updaten is echter overgeslagen.
set string45=We konden geen verbinding met de server maken. Check a.u.b. je internetverbinding.
set string46=Dit kan ook betekenen dat de server aan het onderhouden wordt op het moment.
set string47=Jammer genoeg is deze patcher niet beschikbaar voor Wii U.
set string48=We zullen IOS 31 en IOS 80 moeten downloaden.
set string49=Druk op een toets om door te gaan en de download te starten.
set string50=Downloaden
set string51=Er is een error opgetreden tijdens het patchen.
set string52=Foutcode
set string53=Falende module
set string54=Mail alsjeblieft naar support@riiconnect24.net en leg het probleem aan ons uit.
set string55=Please check your internet connstring56=Installeer a.u.b. .NET Framework 3.5 en probeer het opnieuw.
set string57=Algemene Sharpii fout.
set string58=Druk op een toets om terug te keren naar het menu.
set string59=Patchen is klaar.
set string60=Wil je de gepatchte bestanden naar een SD kaart kopiëren?
set string61=Ja
set string62=Nee
set string63=Kopiëer bestanden naar bureaublad en sluit af
set string64=Kopiëren
set string65=SD Kaart
set string66=An SD card was not found in the system.
set string67=Verbind a.u.b. een SD kaart en probeer het opnieuw.
set string68=Huidige SD kaart letter
set string69=Wil je de SD kaart letter veranderen?
set string70=Doorgaan en bestanden naar SD kaart kopiëren
set string71=Schijfletter veranderen
set string72=Aflsuiten
set string73=Er is een error opgetreden rijdens het kopiëren van de bestanden.
set string74=Bedankt voor het gebruiken van de patcher!
set string75=Patchen is klaar.
set string76=Gepatchte IOS bestanden zijn geplaatst in de folder genaamd "WAD".
set string77=Bestanden zijn gekopiëerd naar de SD kaart in een folder genaamd "WAD".
set string78=Patcher aflsuiten in...
set string79=Probeer diakritische tekens te laden [Werkt niet met Windows 7]

set language=Dutch
set /a diacritic_show=0
goto begin_main

:set_language_dutch
mode 137,36
set string1=Waarschuwing: Gebruik alstublieft deze applicatie zonder administratierechten.
set string2=Waarschuwing: patch.bat niet gevonden. Het kan zijn dat je deze applicatie van een onbekende en onbetrouwbare bron an het uitvoeren bent.
set string3=Start
set string4=Stuur feedback/Rapporteer een fout
set string5=Mail alstublieft naar support@riiconnect24.net mocht je problemen ondervinden
set string6=Typ het nummer dat je hierboven ziet en druk op ENTER.
set string7=Welkom bij het feedback- en foutrapportagescherm
set string8=Druk op een toets om het logbestand naar het Bureaublad te kopieren.
set string9=Het bestand is naar je bureaublad gekopieerd.
set string10=Verstuur het nu alstublieft naar support@riiconnect24.net. Omschrijf het probleem en geef je feedback. :)
set string11=Druk op een toets om door te gaan.
set string12=Veilige modus
set string13=pstarten was de vorige keer mislukt. Opstarten in veilige modus.
set string14=Het updaten is overgeslagen.
set string15=Powershell opstarten
set string16=Op updates nakijken
set string17=Een ogenblik geduld a.u.b.
set string18=Er is een update beschikbaar
set string19=r is een update voor dit programma beschikbaar. We raden je aan IOS Patcher te updaten naar de nieuwste versie.
set string20=Huidige versie
set string21=Nieuwe versie
set string22=Update
set string23=Negeren
set string24=Wat is nieuw in deze update?
set string25=Updaten
set string26=IOS Patcher zal zometeen herstarten
set string27=Wat is nieuw in deze update
set string28=Fout: "Wat is nieuw" is op dit moment niet beschikbaar.
set string29=Fout
set string30=Sommige bestanden die dit programma vereist om uitgevoerd te worden zijn niet gevonden.
set string31=Druk op een toets om deze bestanden opnieuw te downloaden.
set string32=IOS Patcher Update Systeem.
set string33=De nieuwste versie is geinstalleerd.
set string34=Een update is beschikbaar.
set string35=Veilige modus geactiveerd.
set string36=Ik heb geen toegang tot de bestanden op je computer.
set string37=De update-server is niet beschikbaar.
set string38=Druk op C om hier meer over te lezen
set string39=Configureren
set string40=Ga je deze patcher voor de Wii of Wii U gebruiken?
set string41=De nieuwste versie van IOS Patcher is nu geinstalleerd.
set string42=Veilige modus is ingeschakeld. Updaten is overgeslagen. Restart de patcher alsjeblieft om de veilige modus uit te schakelen.
set string43=Ik heb geen toegang tot bestanden op je computer. Dat betekent echter niet dat ik niet kan werken.
set string44=Ik zal proberen om de IOSes te downloaden. Het updaten is echter overgeslagen.
set string45=We konden geen verbinding met de server maken. Check a.u.b. je internetverbinding.
set string46=Dit kan ook betekenen dat de server aan het onderhouden wordt op het moment.
set string47=Jammer genoeg is deze patcher niet beschikbaar voor Wii U.
set string48=We zullen IOS 31 en IOS 80 moeten downloaden.
set string49=Druk op een toets om door te gaan en de download te starten.
set string50=Downloaden
set string51=Er is een error opgetreden tijdens het patchen.
set string52=Foutcode
set string53=Falende module
set string54=Mail alsjeblieft naar support@riiconnect24.net en leg het probleem aan ons uit.
set string55=Please check your internet conn
set string56=Installeer a.u.b. .NET Framework 3.5 en probeer het opnieuw.
set string57=Algemene Sharpii fout.
set string58=Druk op een toets om terug te keren naar het menu.
set string59=Patchen is klaar.
set string60=Wil je de gepatchte bestanden naar een SD kaart kopieren?
set string61=Ja
set string62=Nee
set string63=Kopieer bestanden naar bureaublad en sluit af
set string64=Kopieren
set string65=SD Kaart
set string66=An SD card was not found in the system.
set string67=Verbind a.u.b. een SD kaart en probeer het opnieuw.
set string68=Huidige SD kaart letter
set string69=Wil je de SD kaart letter veranderen?
set string70=Doorgaan en bestanden naar SD kaart kopieren
set string71=Schijfletter veranderen
set string72=Aflsuiten
set string73=Er is een error opgetreden rijdens het kopieren van de bestanden.
set string74=Bedankt voor het gebruiken van de patcher!
set string75=Patchen is klaar.
set string76=Gepatchte IOS bestanden zijn geplaatst in de folder genaamd "WAD".
set string77=Bestanden zijn gekopieerd naar de SD kaart in een folder genaamd "WAD".
set string78=Patcher aflsuiten in...
set string79=Probeer diakritische tekens te laden [Werkt niet met Windows 7]

set language=Dutch
set /a diacritic_show=1
goto begin_main

:not_windows_nt
cls
echo %header%
echo.
echo Please don't run our IOS Patcher in MS-DOS :P.
echo Run it only on Windows Vista+ computer. :)
pause>NUL
exit
:admin_error
cls
echo %header%
echo.
echo ERROR.
echo An error has been occurred. Please try to run this program without ADMIN privileges (or change this batch file name to patch.bat)
pause>NUL
goto admin_error
:begin_main
cls
echo %header%
if %patherror%==0 echo              `..````
if %patherror%==0 echo              yNNNNNNNNMNNmmmmdddhhhyyyysssooo+++/:--.`
if %patherror%==0 echo              ddmNNd:dNMMMMNMMMMMMMMMMMMMMMMMMMMMMMMMMs
if %patherror%==0 echo              hNNNNNNNNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMd

if %patherror%==1 echo :----------------------------------------------------------------:
if %patherror%==1 echo  %string1%
if %patherror%==1 echo :----------------------------------------------------------------:

if %patherror%==2 echo :------------------------------------------------------------------------------------------------------:
if %patherror%==2 echo  %string2%
if %patherror%==2 echo  %string3%
if %patherror%==2 echo :------------------------------------------------------------------------------------------------------:

if not %patherror%==2 echo             `mdmNNy dNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM+    RiiConnect your Wii.
echo             .mmmmNs mNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM:
echo             :mdmmN+`mNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM.
echo             /mmmmN:-mNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMN   1. %string3%  2. %string4%
echo             ommmmN.:mMMMMMMMMMMMMmNMMMMMMMMMMMMMMMMMd   (%string5%)
echo             smmmmm`+mMMMMMMMMMNhMNNMNNMMMMMMMMMMMMMMy   3. Change language [%language%]
if %diacritic_show%==1 echo             hmmmmh omMMMMMMMMMmhNMMMmNNNNMMMMMMMMMMM+   4. %string79%
if %diacritic_show%==0 echo             hmmmmh omMMMMMMMMMmhNMMMmNNNNMMMMMMMMMMM+
echo             mmmmms smMMMMMMMMMmddMMmmNmNMMMMMMMMMMMM:
echo            `mmmmmo hNMMMMMMMMMmddNMMMNNMMMMMMMMMMMMM.
echo            -mmmmm/ dNMMMMMMMMMNmddMMMNdhdMMMMMMMMMMN
echo            :mmmmm-`mNMMMMMMMMNNmmmNMMNmmmMMMMMMMMMMd
echo            +mmmmN.-mNMMMMMMMMMNmmmmMMMMMMMMMMMMMMMMy
echo            smmmmm`/mMMMMMMMMMNNmmmmNMMMMNMMNMMMMMNmy.
echo            hmmmmd`omMMMMMMMMMNNmmmNmMNNMmNNNNMNdhyhh.
echo            mmmmmh ymMMMMMMMMMNNmmmNmNNNMNNMMMMNyyhhh`
echo           `mmmmmy hmMMNMNNMMMNNmmmmmdNMMNmmMMMMhyhhy
echo           -mddmmo`mNMNNNNMMMNNNmdyoo+mMMMNmNMMMNyyys
echo           :mdmmmo-mNNNNNNNNNNdyo++sssyNMMMMMMMMMhs+-
echo          .+mmdhhmmmNNNNNNmdysooooosssomMMMNNNMMMm
echo          o/ossyhdmmNNmdyo+++oooooosssoyNMMNNNMMMM+
echo          o/::::::://++//+++ooooooo+oo++mNMMmNNMMMm
echo         `o//::::::::+////+++++++///:/+shNMMNmNNmMM+
echo         .o////////::+++++++oo++///+syyyymMmNmmmNMMm
echo         -+//////////o+ooooooosydmdddhhsosNMMmNNNmho            `:/
echo         .+++++++++++ssss+//oyyysso/:/shmshhs+:.          `-/oydNNNy
echo           `..-:/+ooss+-`          +mmhdy`           -/shmNNNNNdy+:`
echo                   `.              yddyo++:    `-/oymNNNNNdy+:`
echo                                   -odhhhhyddmmmmmNNmhs/:`
echo                                     :syhdyyyyso+/-`
set /p s=%string6%: 
if %s%==1 goto begin_main1
if %s%==2 goto send_feedback
if %s%==debug goto debug_1
if %s%==3 goto change_language
if %s%==4 goto load_diacritic
if %patherror%==1 goto begin_main
goto begin_main
:load_diacritic
if %diacritic_show%==1 goto set_language_%language%_diacritic
goto begin_main

:change_language
cls
echo %header%
echo -----------------------------------------------------------------------------------------------------------------------------
echo Change your language
echo.
echo 1. English (Author: KcrPL)
echo 2. Polish (Author: KcrPL)
echo 3. French (Author: iDroid)
echo 4. German (Author: TimNook)
echo 5. Dutch (Author: Jelle/DismissedGuy)
echo 6. Turkish (Author: Can Bora Ciner)
echo 7. Russian (Author: prosuWANTED)
set /p s=Choose: 
if %s%==1 goto set_language_english
if %s%==2 goto set_language_polish
if %s%==3 goto set_language_french
if %s%==4 goto set_language_german
if %s%==5 goto set_language_dutch
if %s%==6 set language=Turkish& goto set_language_unicode_ask
if %s%==7 set language=Russian& goto set_language_unicode_ask
goto change_language
:send_feedback
cls
echo %header%
echo -----------------------------------------------------------------------------------------------------------------------------
echo.
echo %string7%
echo.
echo %string8%
pause>NUL
goto send_feedback2
:send_feedback2
if not exist "%MainFolder%/IOSPatcherLogs.txt" goto send_feedback_error
copy "%MainFolder%\IOSPatcherLogs.txt" "%userprofile%\Desktop"
cls
echo %header%
echo -----------------------------------------------------------------------------------------------------------------------------
echo.
echo %string9% 
echo %string10%
echo.
echo %string11%
pause>NUL
goto begin_main


:begin_main1

if exist "%MainFolder%/failsafe.txt" echo INFO: Failsafe detected. Skipping update.>>"%MainFolder%/IOSPatcherLogs.txt"
if exist "%MainFolder%/failsafe.txt" goto failsafe_trigger

set /a errorwinxp=0
timeout -0 /nobreak >NUL || set /a errorwinxp=1
if %errorwinxp%==1 echo INFO: Windows XP detected. Showing warning>>"%MainFolder%/IOSPatcherLogs.txt"
if %errorwinxp%==1 goto winxp_notice

echo BootUp>>%MainFolder%/failsafe.txt
goto startup_script
:failsafe_trigger
cls
echo %header%
echo -----------------------------------------------------------------------------------------------------------------------------
echo.
echo %string12%
echo %string13%
echo.
echo %string14% %string11%
pause>NUL
del /q "%MainFolder%\failsafe.txt"
set /a updateserver=3
goto startup_script_files_check
:startup_script
mode %mode%
cls
echo.
echo              `..````                                     :-------------------------:
echo              yNNNNNNNNMNNmmmmdddhhhyyyysssooo+++/:--.`    %string15%...
echo              hNNNNNNNNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMd   :-------------------------:
echo              ddmNNd:dNMMMMNMMMMMMMMMMMMMMMMMMMMMMMMMMs
echo             `mdmNNy dNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM+
echo             .mmmmNs mNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM:
echo             :mdmmN+`mNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM.
echo             /mmmmN:-mNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMN
echo             ommmmN.:mMMMMMMMMMMMMmNMMMMMMMMMMMMMMMMMd
echo             smmmmm`+mMMMMMMMMMNhMNNMNNMMMMMMMMMMMMMMy
echo             hmmmmh omMMMMMMMMMmhNMMMmNNNNMMMMMMMMMMM+
echo             mmmmms smMMMMMMMMMmddMMmmNmNMMMMMMMMMMMM:
echo            `mmmmmo hNMMMMMMMMMmddNMMMNNMMMMMMMMMMMMM.
echo            -mmmmm/ dNMMMMMMMMMNmddMMMNdhdMMMMMMMMMMN
echo            :mmmmm-`mNMMMMMMMMNNmmmNMMNmmmMMMMMMMMMMd
echo            +mmmmN.-mNMMMMMMMMMNmmmmMMMMMMMMMMMMMMMMy
echo            smmmmm`/mMMMMMMMMMNNmmmmNMMMMNMMNMMMMMNmy.
echo            hmmmmd`omMMMMMMMMMNNmmmNmMNNMmNNNNMNdhyhh.
echo            mmmmmh ymMMMMMMMMMNNmmmNmNNNMNNMMMMNyyhhh`
echo           `mmmmmy hmMMNMNNMMMNNmmmmmdNMMNmmMMMMhyhhy
echo           -mddmmo`mNMNNNNMMMNNNmdyoo+mMMMNmNMMMNyyys
echo           :mdmmmo-mNNNNNNNNNNdyo++sssyNMMMMMMMMMhs+-
echo          .+mmdhhmmmNNNNNNmdysooooosssomMMMNNNMMMm
echo          o/ossyhdmmNNmdyo+++oooooosssoyNMMNNNMMMM+
echo          o/::::::://++//+++ooooooo+oo++mNMMmNNMMMm
echo         `o//::::::::+////+++++++///:/+shNMMNmNNmMM+
echo         .o////////::+++++++oo++///+syyyymMmNmmmNMMm
echo         -+//////////o+ooooooosydmdddhhsosNMMmNNNmho            `:/
echo         .+++++++++++ssss+//oyyysso/:/shmshhs+:.          `-/oydNNNy
echo           `..-:/+ooss+-`          +mmhdy`           -/shmNNNNNdy+:`
echo                   `.              yddyo++:    `-/oymNNNNNdy+:`
echo                                   -odhhhhyddmmmmmNNmhs/:`
echo                                     :syhdyyyyso+/-`

if %file_access%==0 goto startup_script_files_check

echo INFO: Launching Powershell>>"%MainFolder%/IOSPatcherLogs.txt"
powershell -c >NUL
goto check_for_update
:check_for_update
cls
echo.
echo              `..````                                     :-------------------------:
echo              yNNNNNNNNMNNmmmmdddhhhyyyysssooo+++/:--.`    %string16%...
echo              hNNNNNNNNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMd   :-------------------------:
echo              ddmNNd:dNMMMMNMMMMMMMMMMMMMMMMMMMMMMMMMMs
echo             `mdmNNy dNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM+
echo             .mmmmNs mNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM:
echo             :mdmmN+`mNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM.
echo             /mmmmN:-mNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMN
echo             ommmmN.:mMMMMMMMMMMMMmNMMMMMMMMMMMMMMMMMd
echo             smmmmm`+mMMMMMMMMMNhMNNMNNMMMMMMMMMMMMMMy
echo             hmmmmh omMMMMMMMMMmhNMMMmNNNNMMMMMMMMMMM+
echo             mmmmms smMMMMMMMMMmddMMmmNmNMMMMMMMMMMMM:
echo            `mmmmmo hNMMMMMMMMMmddNMMMNNMMMMMMMMMMMMM.
echo            -mmmmm/ dNMMMMMMMMMNmddMMMNdhdMMMMMMMMMMN
echo            :mmmmm-`mNMMMMMMMMNNmmmNMMNmmmMMMMMMMMMMd
echo            +mmmmN.-mNMMMMMMMMMNmmmmMMMMMMMMMMMMMMMMy
echo            smmmmm`/mMMMMMMMMMNNmmmmNMMMMNMMNMMMMMNmy.
echo            hmmmmd`omMMMMMMMMMNNmmmNmMNNMmNNNNMNdhyhh.
echo            mmmmmh ymMMMMMMMMMNNmmmNmNNNMNNMMMMNyyhhh`
echo           `mmmmmy hmMMNMNNMMMNNmmmmmdNMMNmmMMMMhyhhy
echo           -mddmmo`mNMNNNNMMMNNNmdyoo+mMMMNmNMMMNyyys
echo           :mdmmmo-mNNNNNNNNNNdyo++sssyNMMMMMMMMMhs+-
echo          .+mmdhhmmmNNNNNNmdysooooosssomMMMNNNMMMm
echo          o/ossyhdmmNNmdyo+++oooooosssoyNMMNNNMMMM+
echo          o/::::::://++//+++ooooooo+oo++mNMMmNNMMMm
echo         `o//::::::::+////+++++++///:/+shNMMNmNNmMM+
echo         .o////////::+++++++oo++///+syyyymMmNmmmNMMm
echo         -+//////////o+ooooooosydmdddhhsosNMMmNNNmho            `:/
echo         .+++++++++++ssss+//oyyysso/:/shmshhs+:.          `-/oydNNNy
echo           `..-:/+ooss+-`          +mmhdy`           -/shmNNNNNdy+:`
echo                   `.              yddyo++:    `-/oymNNNNNdy+:`
echo                                   -odhhhhyddmmmmmNNmhs/:`
echo                                     :syhdyyyyso+/-`

:: We don't support Windows XP anymore. Windows XP don't have timeout command, it means that if that command will be runned on Windows XP it will return exit code 1.

:: Update script.
set updateversion=0.0.0
:: Delete version.txt and whatsnew.txt
if %offlinestorage%==0 if exist "%TempStorage%\version.txt" del "%TempStorage%\version.txt" /q
if %offlinestorage%==0 if exist "%TempStorage%\version.txt`" del "%TempStorage%\version.txt`" /q
if %offlinestorage%==0 if exist "%TempStorage%\whatsnew.txt" del "%TempStorage%\whatsnew.txt" /q
if %offlinestorage%==0 if exist "%TempStorage%\whatsnew.txt`" del "%TempStorage%\whatsnew.txt`" /q

if not exist "%TempStorage%" md "%TempStorage%"
:: Commands to download files from server.
echo INFO: Checking for updates. Connecting to (%FilesHostedOn%)>>"%MainFolder%/IOSPatcherLogs.txt"

if %IOSPatcher_Update_Activate%==1 if %offlinestorage%==0 call powershell -command (new-object System.Net.WebClient).DownloadFile('"%FilesHostedOn%/whatsnew.txt"', '"%TempStorage%\whatsnew.txt"')
if %IOSPatcher_Update_Activate%==1 if %offlinestorage%==0 call powershell -command (new-object System.Net.WebClient).DownloadFile('"%FilesHostedOn%/version.txt"', '"%TempStorage%\version.txt"')
	set /a temperrorlev=%errorlevel%

set /a updateserver=1
	::Bind error codes to errors here
	if not %temperrorlev%==0 set /a updateserver=0
	if not %temperrorlev%==0 echo ERROR: Error while checking for update. (version.txt - exit code "%temperrorlev%")>>""%MainFolder%/IOSPatcherLogs.txt""

if exist "%TempStorage%\version.txt`" ren "%TempStorage%\version.txt`" "version.txt"
if exist "%TempStorage%\whatsnew.txt`" ren "%TempStorage%\whatsnew.txt`" "whatsnew.txt"
:: Copy the content of version.txt to variable.
if exist "%TempStorage%\version.txt" set /p updateversion=<"%TempStorage%\version.txt"
if not exist "%TempStorage%\version.txt" set /a updateavailable=0
if %IOSPatcher_Update_Activate%==1 if exist "%TempStorage%\version.txt" set /a updateavailable=1
:: If version.txt doesn't match the version variable stored in this batch file, it means that update is available.
if %updateversion%==%version% set /a updateavailable=0
echo INFO: Update status: Current:%version% Update:%updateversion%>>"%MainFolder%/IOSPatcherLogs.txt"
if %IOSPatcher_Update_Activate%==1 if %updateavailable%==1 set /a updateserver=2
if %IOSPatcher_Update_Activate%==1 if %updateavailable%==1 goto update_notice

:startup_script_files_check
cls
echo.
echo              `..````
echo              yNNNNNNNNMNNmmmmdddhhhyyyysssooo+++/:--.`
echo              hNNNNNNNNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMd
echo              ddmNNd:dNMMMMNMMMMMMMMMMMMMMMMMMMMMMMMMMs
echo             `mdmNNy dNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM+
echo             .mmmmNs mNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM:
echo             :mdmmN+`mNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM.
echo             /mmmmN:-mNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMN
echo             ommmmN.:mMMMMMMMMMMMMmNMMMMMMMMMMMMMMMMMd
echo             smmmmm`+mMMMMMMMMMNhMNNMNNMMMMMMMMMMMMMMy
echo             hmmmmh omMMMMMMMMMmhNMMMmNNNNMMMMMMMMMMM+
echo             mmmmms smMMMMMMMMMmddMMmmNmNMMMMMMMMMMMM:
echo            `mmmmmo hNMMMMMMMMMmddNMMMNNMMMMMMMMMMMMM.
echo            -mmmmm/ dNMMMMMMMMMNmddMMMNdhdMMMMMMMMMMN
echo            :mmmmm-`mNMMMMMMMMNNmmmNMMNmmmMMMMMMMMMMd
echo            +mmmmN.-mNMMMMMMMMMNmmmmMMMMMMMMMMMMMMMMy
echo            smmmmm`/mMMMMMMMMMNNmmmmNMMMMNMMNMMMMMNmy.
echo            hmmmmd`omMMMMMMMMMNNmmmNmMNNMmNNNNMNdhyhh.
echo            mmmmmh ymMMMMMMMMMNNmmmNmNNNMNNMMMMNyyhhh`
echo           `mmmmmy hmMMNMNNMMMNNmmmmmdNMMNmmMMMMhyhhy
echo           -mddmmo`mNMNNNNMMMNNNmdyoo+mMMMNmNMMMNyyys
echo           :mdmmmo-mNNNNNNNNNNdyo++sssyNMMMMMMMMMhs+-
echo          .+mmdhhmmmNNNNNNmdysooooosssomMMMNNNMMMm
echo          o/ossyhdmmNNmdyo+++oooooosssoyNMMNNNMMMM+
echo          o/::::::://++//+++ooooooo+oo++mNMMmNNMMMm
echo         `o//::::::::+////+++++++///:/+shNMMNmNNmMM+
echo         .o////////::+++++++oo++///+syyyymMmNmmmNMMm
echo         -+//////////o+ooooooosydmdddhhsosNMMmNNNmho            `:/
echo         .+++++++++++ssss+//oyyysso/:/shmshhs+:.          `-/oydNNNy
echo           `..-:/+ooss+-`          +mmhdy`           -/shmNNNNNdy+:`
echo                   `.              yddyo++:    `-/oymNNNNNdy+:`
echo                                   -odhhhhyddmmmmmNNmhs/:`
echo                                     :syhdyyyyso+/-`
echo                                                                        %string17%...
:: Important check for files. We need them to patch IOS's
if not exist 00000006-80.delta goto error_runtime_error
if not exist 00000006-31.delta goto error_runtime_error
if not exist libWiiSharp.dll goto error_runtime_error
if not exist Sharpii.exe goto error_runtime_error
if not exist WadInstaller.dll goto error_runtime_error
if not exist wget.exe goto error_runtime_error
if not exist xdelta3.exe goto error_runtime_error
set filcheck=1
if exist "%MainFolder%\failsafe.txt" del /q "%MainFolder%\failsafe.txt"
goto main_fade_out

:update_notice
if exist "%MainFolder%\failsafe.txt" del /q "%MainFolder%\failsafe.txt"
if %updateversion%==0.0.0 goto error_update_not_available
set /a update=1
cls
echo.
echo              `..````
echo              yNNNNNNNNMNNmmmmdddhhhyyyysssooo+++/:--.`
echo              hNNNNNNNNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMd
echo              ddmNNd:dNMMMMNMMMMMMMMMMMMMMMMMMMMMMMMMMs
echo             `mdmNNy dNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM+
echo             .mmmmNs mNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM:
echo             :mdmmN+`mNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM.
echo             /mmmmN:-mNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMN
echo             ommmmN.:mMMMMMMMMMMMMmNMMMMMMMMMMMMMMMMMd
echo             smmmmm`+mMMMMMMMMMNhMNNMNNMMMMMMMMMMMMMMy
echo             hmmmmh omMMMMMMMMMmhNMMMmNNNNMMMMMMMMMMM+
echo -----------------------------------------------------------------------------------------------------------------------------
echo    /---\   %string18%.
echo   /     \  %string19%
echo  /   !   \
echo  ---------  %string20%: %version%
echo             %string21%: %updateversion%
echo                       1. %string22%                      2. %string23%               3. %string24%
echo -----------------------------------------------------------------------------------------------------------------------------
echo           -mddmmo`mNMNNNNMMMNNNmdyoo+mMMMNmNMMMNyyys
echo           :mdmmmo-mNNNNNNNNNNdyo++sssyNMMMMMMMMMhs+-
echo          .+mmdhhmmmNNNNNNmdysooooosssomMMMNNNMMMm
echo          o/ossyhdmmNNmdyo+++oooooosssoyNMMNNNMMMM+
echo          o/::::::://++//+++ooooooo+oo++mNMMmNNMMMm
echo         `o//::::::::+////+++++++///:/+shNMMNmNNmMM+
echo         .o////////::+++++++oo++///+syyyymMmNmmmNMMm
echo         -+//////////o+ooooooosydmdddhhsosNMMmNNNmho            `:/
echo         .+++++++++++ssss+//oyyysso/:/shmshhs+:.          `-/oydNNNy
echo           `..-:/+ooss+-`          +mmhdy`           -/shmNNNNNdy+:`
echo                   `.              yddyo++:    `-/oymNNNNNdy+:`
echo                                   -odhhhhyddmmmmmNNmhs/:`
echo                                     :syhdyyyyso+/-`
set /p s=
if %s%==1 goto update_files
if %s%==2 goto 3
if %s%==3 goto whatsnew
goto update_notice
:update_files
cls
cls
echo.
echo              `..````
echo              yNNNNNNNNMNNmmmmdddhhhyyyysssooo+++/:--.`
echo              hNNNNNNNNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMd
echo              ddmNNd:dNMMMMNMMMMMMMMMMMMMMMMMMMMMMMMMMs
echo             `mdmNNy dNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM+
echo             .mmmmNs mNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM:
echo             :mdmmN+`mNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM.
echo             /mmmmN:-mNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMN
echo             ommmmN.:mMMMMMMMMMMMMmNMMMMMMMMMMMMMMMMMd
echo             smmmmm`+mMMMMMMMMMNhMNNMNNMMMMMMMMMMMMMMy
echo             hmmmmh omMMMMMMMMMmhNMMMmNNNNMMMMMMMMMMM+
echo -----------------------------------------------------------------------------------------------------------------------------
echo    /---\   %string25%
echo   /     \  %string17%...
echo  /   !   \
echo  --------- %string26%...
echo.
echo.
echo -----------------------------------------------------------------------------------------------------------------------------
echo           -mddmmo`mNMNNNNMMMNNNmdyoo+mMMMNmNMMMNyyys
echo           :mdmmmo-mNNNNNNNNNNdyo++sssyNMMMMMMMMMhs+-
echo          .+mmdhhmmmNNNNNNmdysooooosssomMMMNNNMMMm
echo          o/ossyhdmmNNmdyo+++oooooosssoyNMMNNNMMMM+
echo          o/::::::://++//+++ooooooo+oo++mNMMmNNMMMm
echo         `o//::::::::+////+++++++///:/+shNMMNmNNmMM+
echo         .o////////::+++++++oo++///+syyyymMmNmmmNMMm
echo         -+//////////o+ooooooosydmdddhhsosNMMmNNNmho            `:/
echo         .+++++++++++ssss+//oyyysso/:/shmshhs+:.          `-/oydNNNy
echo           `..-:/+ooss+-`          +mmhdy`           -/shmNNNNNdy+:`
echo                   `.              yddyo++:    `-/oymNNNNNdy+:`
echo                                   -odhhhhyddmmmmmNNmhs/:`
echo                                     :syhdyyyyso+/-`
echo INFO: Begining update process>>"%MainFolder%/IOSPatcherLogs.txt"
:: Deleting the temp files if they exist.
if exist 00000006-31.delta` del 00000006-31.delta` /q 2> nul
if exist 00000006-80.delta` del 00000006-80.delta` /q 2> nul
if exist WadInstaller.dll` del WadInstaller.dll` /q 2> nul
if exist wget.exe` del wget.exe` /q 2> nul
if exist xdelta3.exe` del xdelta3.exe` 2> nul
if exist patch.bat` del patch.bat` /q 2> nul
if exist libWiiSharp.dll` del  libWiiSharp.dll` /q 2> nul
if exist Sharpii.exe` del Sharpii.exe` /q 2> nul

:: Downloading the update files. In future i'm gonna add something called "Files Version" (at least i call it that way). Because most of the time the patch.bat is only updated
call powershell -command "(new-object System.Net.WebClient).DownloadFile('"%FilesHostedOn%/00000006-31.delta"', '00000006-31.delta`"')"
call powershell -command "(new-object System.Net.WebClient).DownloadFile('"%FilesHostedOn%/00000006-80.delta"', '00000006-80.delta`"')"
call powershell -command "(new-object System.Net.WebClient).DownloadFile('"%FilesHostedOn%/WadInstaller.dll"', 'WadInstaller.dll`"')"
call powershell -command "(new-object System.Net.WebClient).DownloadFile('"%FilesHostedOn%/libWiiSharp.dll"', 'libWiiSharp.dll`"')"
call powershell -command "(new-object System.Net.WebClient).DownloadFile('"%FilesHostedOn%/wget.exe"', 'wget.exe`"')"
call powershell -command "(new-object System.Net.WebClient).DownloadFile('"%FilesHostedOn%/xdelta3.exe"', 'xdelta3.exe`"')"
call powershell -command "(new-object System.Net.WebClient).DownloadFile('"%FilesHostedOn%/Sharpii.exe"', 'Sharpii.exe`"')"
call powershell -command "(new-object System.Net.WebClient).DownloadFile('"%FilesHostedOn%/patch.bat"', 'patch.bat`"')"

:: If download failed
if %update%==1 if not exist 00000006-31.delta` goto error_update_not_available
if %update%==1 if not exist 00000006-80.delta` goto error_update_not_available
if %update%==1 if not exist WadInstaller.dll` goto error_update_not_available
if %update%==1 if not exist wget.exe` goto error_update_not_available
if %update%==1 if not exist xdelta3.exe` goto error_update_not_available
if %update%==1 if not exist Sharpii.exe` goto error_update_not_available
if %update%==1 if not exist patch.bat` goto error_update_not_available
if %update%==1 if not exist libWiiSharp.dll` goto error_update_not_available

:: Delete the original files
if %update%==1 if exist 00000006-31.delta del 00000006-31.delta /q
if %update%==1 if exist 00000006-80.delta del 00000006-80.delta /q
if %update%==1 if exist WadInstaller.dll del WadInstaller.dll /q
if %update%==1 if exist wget.exe del wget.exe /q
if %update%==1 if exist xdelta3.exe del xdelta3.exe /q
if %update%==1 if exist Sharpii.exe del Sharpii.exe /q
if %update%==1 if exist libWiiSharp.dll del libWiiSharp.dll /q

:: Renaming the temp files to original names
ren 00000006-31.delta` 00000006-31.delta
ren 00000006-80.delta` 00000006-80.delta
ren WadInstaller.dll` WadInstaller.dll
ren wget.exe` wget.exe
ren xdelta3.exe` xdelta3.exe
ren Sharpii.exe` Sharpii.exe
ren libWiiSharp.dll` libWiiSharp.dll

:: Patch.bat cannot be overwritten while running so i'm creating a small script
echo echo off >>temp.bat
echo ping localhost -n 2^>NUL >>temp.bat
echo del patch.bat /q >>temp.bat
echo ren patch.bat` patch.bat >>temp.bat
echo start patch.bat >>temp.bat
echo exit >>temp.bat
:: Running the script and exiting patch.bat
echo INFO: Updating seems to be done. Restarting to the temporary script>>"%MainFolder%/IOSPatcherLogs.txt"
start temp.bat
exit
exit
exit
:whatsnew
cls
if not exist "%TempStorage%\whatsnew.txt" goto whatsnew_notexist
echo %header%
echo -----------------------------------------------------------------------------------------------------------------------------
echo.
echo %string27% %updateversion%?
echo.
type "%TempStorage%\whatsnew.txt"
pause>NUL
goto update_notice
:whatsnew_notexist
cls
echo %header%
echo ----------------------------------------------------------------------------------------------------------------------------
echo.
echo %string28%
echo.
echo %string11%
pause>NUL
goto update_notice
:winxp_notice
set updateserver=0
goto main_fade_out
:main_fade_out
cls

echo.
echo              `..````
echo              yNNNNNNNNMNNmmmmdddhhhyyyysssooo+++/:--.`
echo              hNNNNNNNNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMd
echo              ddmNNd:dNMMMMNMMMMMMMMMMMMMMMMMMMMMMMMMMs
echo             `mdmNNy dNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM+
echo             .mmmmNs mNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM:
echo             :mdmmN+`mNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM.
echo             /mmmmN:-mNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMN
echo             ommmmN.:mMMMMMMMMMMMMmNMMMMMMMMMMMMMMMMMd
echo             smmmmm`+mMMMMMMMMMNhMNNMNNMMMMMMMMMMMMMMy
echo             hmmmmh omMMMMMMMMMmhNMMMmNNNNMMMMMMMMMMM+
echo             mmmmms smMMMMMMMMMmddMMmmNmNMMMMMMMMMMMM:
echo            `mmmmmo hNMMMMMMMMMmddNMMMNNMMMMMMMMMMMMM.
echo            -mmmmm/ dNMMMMMMMMMNmddMMMNdhdMMMMMMMMMMN
echo            :mmmmm-`mNMMMMMMMMNNmmmNMMNmmmMMMMMMMMMMd
echo            +mmmmN.-mNMMMMMMMMMNmmmmMMMMMMMMMMMMMMMMy
echo            smmmmm`/mMMMMMMMMMNNmmmmNMMMMNMMNMMMMMNmy.
echo            hmmmmd`omMMMMMMMMMNNmmmNmMNNMmNNNNMNdhyhh.
echo            mmmmmh ymMMMMMMMMMNNmmmNmNNNMNNMMMMNyyhhh`
echo           `mmmmmy hmMMNMNNMMMNNmmmmmdNMMNmmMMMMhyhhy
echo           -mddmmo`mNMNNNNMMMNNNmdyoo+mMMMNmNMMMNyyys
echo           :mdmmmo-mNNNNNNNNNNdyo++sssyNMMMMMMMMMhs+-
echo          .+mmdhhmmmNNNNNNmdysooooosssomMMMNNNMMMm
echo          o/ossyhdmmNNmdyo+++oooooosssoyNMMNNNMMMM+
echo          o/::::::://++//+++ooooooo+oo++mNMMmNNMMMm
echo         `o//::::::::+////+++++++///:/+shNMMNmNNmMM+
echo         .o////////::+++++++oo++///+syyyymMmNmmmNMMm
echo         -+//////////o+ooooooosydmdddhhsosNMMmNNNmho            `:/
echo         .+++++++++++ssss+//oyyysso/:/shmshhs+:.          `-/oydNNNy
echo           `..-:/+ooss+-`          +mmhdy`           -/shmNNNNNdy+:`
echo                   `.              yddyo++:    `-/oymNNNNNdy+:`
echo                                   -odhhhhyddmmmmmNNmhs/:`
echo                                     :syhdyyyyso+/-`
echo.
ping localhost -n 3 >NUL
goto begin
:error_runtime_error
set /a update=0
echo ERROR: Some of the files are missing>>"%MainFolder%/IOSPatcherLogs.txt"
cls
echo.
echo              `..````
echo              yNNNNNNNNMNNmmmmdddhhhyyyysssooo+++/:--.`
echo              hNNNNNNNNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMd
echo              ddmNNd:dNMMMMNMMMMMMMMMMMMMMMMMMMMMMMMMMs
echo             `mdmNNy dNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM+
echo             .mmmmNs mNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM:
echo             :mdmmN+`mNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM.
echo             /mmmmN:-mNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMN
echo             ommmmN.:mMMMMMMMMMMMMmNMMMMMMMMMMMMMMMMMd
echo             smmmmm`+mMMMMMMMMMNhMNNMNNMMMMMMMMMMMMMMy
echo             hmmmmh omMMMMMMMMMmhNMMMmNNNNMMMMMMMMMMM+
echo -----------------------------------------------------------------------------------------------------------------------------
echo    /---\   %string29%
echo   /     \  %string30%
echo  /   !   \ %string31%
echo  ---------
echo -----------------------------------------------------------------------------------------------------------------------------
echo            mmmmmh ymMMMMMMMMMNNmmmNmNNNMNNMMMMNyyhhh`
echo           `mmmmmy hmMMNMNNMMMNNmmmmmdNMMNmmMMMMhyhhy
echo           -mddmmo`mNMNNNNMMMNNNmdyoo+mMMMNmNMMMNyyys
echo           :mdmmmo-mNNNNNNNNNNdyo++sssyNMMMMMMMMMhs+-
echo          .+mmdhhmmmNNNNNNmdysooooosssomMMMNNNMMMm
echo          o/ossyhdmmNNmdyo+++oooooosssoyNMMNNNMMMM+
echo          o/::::::://++//+++ooooooo+oo++mNMMmNNMMMm
echo         `o//::::::::+////+++++++///:/+shNMMNmNNmMM+
echo         .o////////::+++++++oo++///+syyyymMmNmmmNMMm
echo         -+//////////o+ooooooosydmdddhhsosNMMmNNNmho            `:/
echo         .+++++++++++ssss+//oyyysso/:/shmshhs+:.          `-/oydNNNy
echo           `..-:/+ooss+-`          +mmhdy`           -/shmNNNNNdy+:`
echo                   `.              yddyo++:    `-/oymNNNNNdy+:`
echo                                   -odhhhhyddmmmmmNNmhs/:`
echo                                     :syhdyyyyso+/-`
pause>NUL
goto update_files
:begin
cls
if not exist 00000006-80.delta set /a delta80=2
if not exist 00000006-31.delta set /a delta31=2
if not exist libWiiSharp.dll goto error_runtime_error
if not exist Sharpii.exe goto error_runtime_error
if not exist WadInstaller.dll goto error_runtime_error
if not exist wget.exe goto error_runtime_error
if not exist xdelta3.exe goto error_runtime_error
set filcheck=1
goto 3
:debug_load
cls
@echo off
cls

:debug_1
:: Debug menu
if not defined %output% set output=No output.
cls
echo IOS Patcher for RiiConnect24 Larsenv, KcrPL
echo debug menu
echo.
echo Output:
echo %output%
echo.
echo 1. Check for runtime files	
echo 2. Check system req
echo 3. Load a translation into memory
echo 4. Exit debug menu
echo 5. Exit.
echo 6. Run patching script
echo 7. Delete files/Refresh program.
echo 8. Change coding page to cmd defualt
echo 9. Change coding page to 65001 (UTF-8)
echo 10. Open command prompt
set /p s=Choose:
if %s%==1 goto debug_runtime
if %s%==2 goto debug_system_Req
if %s%==3 goto set_language
if %s%==4 goto begin
if %s%==5 exit
if %s%==6 goto debug_download
if %s%==7 goto refresh_database
if %s%==8 goto debug_coding_8
if %s%==9 goto debug_coding_utf
if %s%==10 cmd.exe

goto debug_1
:debug_runtime
set /a tempvariable=0
if not exist 00000006-31.delta set /a tempvariable=1
if not exist 00000006-80.delta set /a tempvariable=1
if not exist libWiiSharp.dll set /a tempvariable=1
if not exist Sharpii.exe set /a tempvariable=1
if not exist WadInstaller.dll set /a tempvariable=1
if not exist wget.exe set /a tempvariable=1
if not exist xdelta3.exe set /a tempvariable=1

if %tempvariable%==1 set output=Files are corrupted. Please download a new package from GitHub or unpack this program!
if %tempvariable%==0 set output=It seems that the files are OK!
goto debug_1
:debug_system_Req
set /a tempvariable=0
timeout 1 /nobreak >NUL || set /a tempvariable=1

if %tempvariable%==0 set output=There should be no problems with this program.
if %tempvariable%==1 set output=Your OS is probably Windows XP. You may experience some problems with this program.
goto debug_1
:refresh_database
cls
echo %header%
echo ---------------------------------------------------------------------------------------------------------------------------
echo  [*] Deleting files.
echo.
echo You are about to delete any temporary files that have been created by this Patcher.
echo.
echo Is that OK?
echo.
echo ---------------------------------------------------------------------------------------------------------------------------
echo                          1. Yes                                                 2. No
set /p s=
if %s%==1 goto debug_ref
if %s%==2 goto debug_1
goto refresh_database
:debug_ref
cls
echo %header%
echo ---------------------------------------------------------------------------------------------------------------------------
echo  [*] Deleting files.
echo.
del /q IOS31-old.wad >NUL
del /q IOS80-old.wad >NUL
del /q IOS31\00000006.app >NUL
rmdir /q /s IOS31 >NUL
rmdir /q /s IOS80 >NUL
del /q 00000006.app >NUL
del /q IOS80\00000006.app >NUL

set output=OK!
echo Files has been deleted.
echo This program will restart shortly.
ping localhost -n 5 >NUL
goto 1
:debug_coding_8
chcp 852
set output=Coding page change was successful.
goto debug_1
:debug_coding_utf
chcp 65001
set output=Coding page change was successful.
goto debug_1
:debug_download
cls
echo Downloading IOS 31...
Sharpii.exe NUSD -ios 31 -v latest -o IOS31-old.wad -wad >NUL
echo Downloading IOS 80...
Sharpii.exe NUSD -ios 80 -v latest -o IOS80-old.wad -wad >NUL
set output=Downloading successfull.
goto debug_download1
:debug_download1
echo Do you want to patch IOS 31 and 80 for RiiConnect?
echo 1. Yes
echo 2. No
set /p s=Choose:
if %s%==1 goto debug_download_patch
if %s%==2 goto debug_1
goto debug_download_1
:debug_download_patch
Sharpii.exe WAD -u IOS31-old.wad IOS31/ >NUL
Sharpii.exe WAD -u IOS80-old.wad IOS80/ >NUL
move IOS31\00000006.app 00000006.app >NUL
xdelta3.exe -f -d -s 00000006.app 00000006-31.delta IOS31\00000006.app >NUL
move IOS80\00000006.app 00000006.app >NUL
xdelta3.exe -f -d -s 00000006.app 00000006-80.delta IOS80\00000006.app >NUL
mkdir WAD
Sharpii.exe WAD -p IOS31\ WAD\IOS31.wad -fs >NUL
Sharpii.exe WAD -p IOS80\ WAD\IOS80.wad -fs >NUL
del 00000006.app /q >NUL
del IOS31-old.wad /q >NUL
del IOS80-old.wad /q >NUL
rmdir /s /q IOS31 >NUL
rmdir /s /q IOS80 >NUL
Sharpii.exe IOS WAD\IOS31.wad -fs -es -np -vp
Sharpii.exe IOS WAD\IOS80.wad -fs -es -np -vp
set output=Patching and downloading IOS 31, 80 done.
goto debug_1

:set_language
set translationsserror=0
mode %mode%
set s=NUL
rem ### Please do not make any changes to this part of code. ###
rem # Please contact me on Discord - KcrPL#4625 ###
cls
echo.
echo RiiConnect24 IOS Patcher - (C) Larsenv, (C) KcrPL. v%version% (Compiled on %last_build% at %at%)
echo ---------------------------------------------------------------------------------------------------------------------------
echo  [*] Please select your language
echo.
echo.
echo Notice from creator of this patcher.
echo.
echo I don't know how you got here (probably from debug menu).
echo If from debug menu, congratulation :P.
echo.
echo It was very fun to create this section of the program but it's time to delete it.
echo If you were using it, I'm sorry. Over 50%% of every language were not translated.
echo Thanks to:
echo  TimNook for German translation, iDroid for French translation, GameCube for Italian translation,
echo   Artuto for Spanish translation, prosuWANTED for Russian translation and Fun4TubeGr for Greek translation.
echo.
echo                                                                                            Thanks for understanding.
echo                                                                                                              -KcrPL.
echo.
echo Press anything to go back to main menu.
pause>NUL
goto begin_main
:3
if exist "%MainFolder%\failsafe.txt" del /q "%MainFolder%\failsafe.txt"
mode %mode%

if %file_access%==0 set /a updateserver=4

cls
echo.
echo %header%
echo :=======================================================================:
echo   %string32%
if %updateserver%==1 echo   %string33% %string38%
if %updateserver%==2 echo   %string34% %string38%
if %updateserver%==3 echo   %string35% %string38%
if %updateserver%==4 echo   %string36% %string38%
if %updateserver%==0 echo   %string37% %string38%
echo :=======================================================================:
echo.
echo ---------------------------------------------------------------------------------------------------------------------------
echo  [*] %string39%
echo.
echo %string40%
echo.
echo ---------------------------------------------------------------------------------------------------------------------------
echo                          1. Wii                                                 2. WiiU
set /p s=Choose:
if %s%==c goto more_info_update
if %s%==C goto more_info_update
if %s%==1 goto 4
if %s%==2 goto error_3
goto 3
:more_info_update
cls
echo %header%
echo.
if %updateserver%==1 echo %string41% (v%version%)
if %updateserver%==2 goto update_notice

if %updateserver%==3 echo %string42%

if %updateserver%==4 echo %string43%
if %updateserver%==4 echo %string44%

if %updateserver%==0 echo %string37%
if %updateserver%==0 echo %string45%
if %updateserver%==0 echo %string46%
pause>NUL
goto 3

:error_3
mode %mode%
cls
echo.
echo %header%
echo ---------------------------------------------------------------------------------------------------------------------------
echo  [*] Error.
echo.
echo %string47%
echo.
echo %string11%
pause>NUL
goto 3
:4
mode %mode%
set instalorder=1
set intrepeat=0
cls
echo.
echo %header%
echo ---------------------------------------------------------------------------------------------------------------------------
echo  [*] Info.
echo.
echo %string48%
echo %string49%
echo.
pause>NUL
goto set_variables
:set_variables
cls
set /a counter_done=0
set /a percent=0
set /a temperrorlev=0
goto 5
:5
set /a percent=%percent%+1

if /i %percent% GTR 0 if /i %percent% LSS 10 set /a counter_done=0
if /i %percent% GTR 10 if /i %percent% LSS 20 set /a counter_done=1
if /i %percent% GTR 20 if /i %percent% LSS 30 set /a counter_done=2
if /i %percent% GTR 30 if /i %percent% LSS 40 set /a counter_done=3
if /i %percent% GTR 40 if /i %percent% LSS 50 set /a counter_done=4
if /i %percent% GTR 50 if /i %percent% LSS 60 set /a counter_done=5
if /i %percent% GTR 60 if /i %percent% LSS 70 set /a counter_done=6
if /i %percent% GTR 70 if /i %percent% LSS 80 set /a counter_done=7
if /i %percent% GTR 80 if /i %percent% LSS 90 set /a counter_done=8
if /i %percent% GTR 90 if /i %percent% LSS 100 set /a counter_done=9
if %percent%==100 set /a counter_done=10
cls
echo.
echo %header%
echo ---------------------------------------------------------------------------------------------------------------------------
echo  [*] %string50%
echo.
if %counter_done%==0 echo :          : %percent% %%
if %counter_done%==1 echo :-         : %percent% %%
if %counter_done%==2 echo :--        : %percent% %%
if %counter_done%==3 echo :---       : %percent% %%
if %counter_done%==4 echo :----      : %percent% %%
if %counter_done%==5 echo :-----     : %percent% %%
if %counter_done%==6 echo :------    : %percent% %%
if %counter_done%==7 echo :-------   : %percent% %%
if %counter_done%==8 echo :--------  : %percent% %%
if %counter_done%==9 echo :--------- : %percent% %%
if %counter_done%==10 echo :----------: %percent% %%

if %percent%==25 call Sharpii.exe NUSD -ios 31 -v latest -o IOS31-old.wad -wad >NUL
if %percent%==25 set /a temperrorlev=%errorlevel%
if %percent%==25 set modul=Sharpii.exe
if %percent%==25 if not %temperrorlev%==0 goto error_patching

if %percent%==50 call Sharpii.exe NUSD -ios 80 -v latest -o IOS80-old.wad -wad >NUL
if %percent%==50 set /a temperrorlev=%errorlevel%
if %percent%==50 set modul=Sharpii.exe
if %percent%==50 if not %temperrorlev%==0 goto error_patching

if %percent%==55 call Sharpii.exe WAD -u IOS31-old.wad IOS31/ >NUL
if %percent%==55 set /a temperrorlev=%errorlevel%
if %percent%==55 set modul=Sharpii.exe
if %percent%==55 if not %temperrorlev%==0 goto error_patching

if %percent%==58 call Sharpii.exe WAD -u IOS80-old.wad IOS80/ >NUL
if %percent%==58 set /a temperrorlev=%errorlevel%
if %percent%==58 set modul=Sharpii.exe
if %percent%==58 if not %temperrorlev%==0 goto error_patching

if %percent%==60 move IOS31\00000006.app 00000006.app >NUL
if %percent%==60 set /a temperrorlev=%errorlevel%
if %percent%==60 set modul=move.exe
if %percent%==60 if not %temperrorlev%==0 goto error_patching

if %percent%==65 call xdelta3.exe -f -d -s 00000006.app 00000006-31.delta IOS31\00000006.app >NUL
if %percent%==65 set /a temperrorlev=%errorlevel%
if %percent%==65 set modul=xdelta.exe
if %percent%==65 if not %temperrorlev%==0 goto error_patching

if %percent%==70 move IOS80\00000006.app 00000006.app >NUL
if %percent%==70 set /a temperrorlev=%errorlevel%
if %percent%==70 set modul=move.exe
if %percent%==70 if not %temperrorlev%==0 goto error_patching

if %percent%==73 call xdelta3.exe -f -d -s 00000006.app 00000006-80.delta IOS80\00000006.app >NUL
if %percent%==73 set /a temperrorlev=%errorlevel%
if %percent%==73 set modul=xdelta3.exe
if %percent%==73 if not %temperrorlev%==0 goto error_patching

if %percent%==75 if not exist WAD mkdir WAD
if %percent%==75 set /a temperrorlev=%errorlevel%
if %percent%==75 set modul=mkdir.exe
if %percent%==75 if not %temperrorlev%==0 goto error_patching

if %percent%==77 call Sharpii.exe WAD -p IOS31\ WAD\IOS31.wad -fs >NUL
if %percent%==77 set /a temperrorlev=%errorlevel%
if %percent%==77 set modul=Sharpii.exe
if %percent%==77 if not %temperrorlev%==0 goto error_patching

if %percent%==80 call Sharpii.exe WAD -p IOS80\ WAD\IOS80.wad -fs >NUL
if %percent%==80 set /a temperrorlev=%errorlevel%
if %percent%==80 set modul=Sharpii.exe
if %percent%==80 if not %temperrorlev%==0 goto error_patching

if %percent%==83 del 00000006.app /q >NUL
if %percent%==83 set /a temperrorlev=%errorlevel%
if %percent%==83 set modul=del.exe
if %percent%==83 if not %temperrorlev%==0 goto error_patching

if %percent%==86 del IOS31-old.wad /q >NUL
if %percent%==86 set /a temperrorlev=%errorlevel%
if %percent%==86 set modul=del.exe
if %percent%==86 if not %temperrorlev%==0 goto error_patching

if %percent%==90 del IOS80-old.wad /q >NUL
if %percent%==90 set /a temperrorlev=%errorlevel%
if %percent%==90 set modul=del.exe
if %percent%==90 if not %temperrorlev%==0 goto error_patching

if %percent%==93 if exist IOS31 rmdir /s /q IOS31 >NUL
if %percent%==93 set /a temperrorlev=%errorlevel%
if %percent%==93 set modul=rmdir.exe
if %percent%==93 if not %temperrorlev%==0 goto error_patching

if %percent%==95 if exist IOS80 rmdir /s /q IOS80 >NUL
if %percent%==95 set /a temperrorlev=%errorlevel%
if %percent%==95 set modul=rmdir.exe
if %percent%==95 if not %temperrorlev%==0 goto error_patching

if %percent%==97 call Sharpii.exe IOS WAD\IOS31.wad -fs -es -np -vp>NUL
if %percent%==97 set /a temperrorlev=%errorlevel%
if %percent%==97 set modul=Sharpii.exe
if %percent%==97 if not %temperrorlev%==0 goto error_patching

if %percent%==99 call Sharpii.exe IOS WAD\IOS80.wad -fs -es -np -vp>NUL
if %percent%==99 set /a temperrorlev=%errorlevel%
if %percent%==99 set modul=Sharpii.exe
if %percent%==99 if not %temperrorlev%==0 goto error_patching

if %percent%==100 echo INFO: Patching done without errors>>"%MainFolder%/IOSPatcherLogs.txt"
if %percent%==100 goto ask_for_copy_to_an_sd_card
ping localhost -n 1 >NUL
goto 5

:error_patching
mode %mode%
cls
echo ERROR: There was an error while patching: Module: %modul% Error code: %temperrorlev%>>"%MainFolder%/IOSPatcherLogs.txt"
echo.
echo              `..````
echo              yNNNNNNNNMNNmmmmdddhhhyyyysssooo+++/:--.`
echo              hNNNNNNNNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMd
echo              ddmNNd:dNMMMMNMMMMMMMMMMMMMMMMMMMMMMMMMMs
echo             `mdmNNy dNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM+
echo             .mmmmNs mNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM:
echo             :mdmmN+`mNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM.
echo             /mmmmN:-mNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMN
echo             ommmmN.:mMMMMMMMMMMMMmNMMMMMMMMMMMMMMMMMd
echo             smmmmm`+mMMMMMMMMMNhMNNMNNMMMMMMMMMMMMMMy
echo             hmmmmh omMMMMMMMMMmhNMMMmNNNNMMMMMMMMMMM+
echo ---------------------------------------------------------------------------------------------------------------------------
echo    /---\   %string29%.
echo   /     \  %string51%
echo  /   !   \ %string52%: %temperrorlev%
echo  --------- %string53%: %modul%
echo %string54%
echo.
echo Error code: RC24-IOS-Patcher_v%version%_%temperrorlev%_%modul%_failure
echo.
if %temperrorlev%==-532459699 echo %string55%
if %temperrorlev%==-2146232576 echo %string56%
if %temperrorlev%==-1073741515 echo %string57% %string56%
echo       %string58%
echo ---------------------------------------------------------------------------------------------------------------------------
echo          o/ossyhdmmNNmdyo+++oooooosssoyNMMNNNMMMM+
echo          o/::::::://++//+++ooooooo+oo++mNMMmNNMMMm
echo         `o//::::::::+////+++++++///:/+shNMMNmNNmMM+
echo         .o////////::+++++++oo++///+syyyymMmNmmmNMMm
echo         -+//////////o+ooooooosydmdddhhsosNMMmNNNmho            `:/
echo         .+++++++++++ssss+//oyyysso/:/shmshhs+:.          `-/oydNNNy
echo           `..-:/+ooss+-`          +mmhdy`           -/shmNNNNNdy+:`
echo                   `.              yddyo++:    `-/oymNNNNNdy+:`
echo                                   -odhhhhyddmmmmmNNmhs/:`
echo                                     :syhdyyyyso+/-`
pause>NUL
goto begin_main
:ask_for_copy_to_an_sd_card
mode %mode%
cls
echo.
echo %header%
echo ---------------------------------------------------------------------------------------------------------------------------
echo  [*] SD Card
echo.
echo %string59%
echo %string60%
echo.
echo ---------------------------------------------------------------------------------------------------------------------------
echo  1. %string61%  2. %string62%  3. %string63%
set /p s=
if %s%==1 goto sd_card_check
if %s%==2 goto end
if %s%==3 goto copy_desktop
goto ask_for_copy_to_an_sd_card
:copy_desktop
cls
echo.
echo %header%
echo ---------------------------------------------------------------------------------------------------------------------------
echo  [*] %string64%...
echo.
echo INFO: Copying patched files to desktop. (%userprofile%/Desktop/)
echo %string17%...
copy "WAD" "%userprofile%/Desktop/" >>NUL
goto end
:sd_card_check
cls
echo.
echo %header%
echo ---------------------------------------------------------------------------------------------------------------------------
echo  [*] %string65%
echo.
echo INFO: Begining SD Card lookup>>"%MainFolder%/IOSPatcherLogs.txt"
set sdcard=NotDefined
echo %string17%...
goto sd_a
:: Shitty script but it works, duh. :P
:: Every Wii SD Card should have two folders in it: apps and private. That's how it's being checked :)
:sd_a
set /a check=0
if exist A:\apps set /a check=%check%+1
if %check%==1 set sdcard=A
goto sd_b
:sd_b
set /a check=0
if exist B:\apps set /a check=%check%+1
if %check%==1 set sdcard=B
goto sd_d
:sd_d
set /a check=0
if exist D:\apps set /a check=%check%+1
if %check%==1 set sdcard=D
goto sd_e
:sd_e
set /a check=0
if exist E:\apps set /a check=%check%+1
if %check%==1 set sdcard=E
goto sd_f
:sd_f
set /a check=0
if exist F:\apps set /a check=%check%+1
if %check%==1 set sdcard=F
goto sd_g
:sd_g
set /a check=0
if exist G:\apps set /a check=%check%+1
if %check%==1 set sdcard=G
goto sd_h
:sd_h
set /a check=0
if exist H:\apps set /a check=%check%+1
if %check%==1 set sdcard=H
goto sd_i
:sd_i
set /a check=0
if exist I:\apps set /a check=%check%+1
if %check%==1 set sdcard=J
goto sd_j
:sd_j
set /a check=0
if exist J:\apps set /a check=%check%+1
if %check%==1 set sdcard=J
goto sd_k
:sd_k
set /a check=0
if exist K:\apps set /a check=%check%+1
if %check%==1 set sdcard=K
goto sd_l
:sd_l
set /a check=0
if exist L:\apps set /a check=%check%+1
if %check%==1 set sdcard=L
goto sd_m
:sd_m
set /a check=0
if exist M:\apps set /a check=%check%+1
if %check%==1 set sdcard=M
goto sd_n
:sd_n
set /a check=0
if exist N:\apps set /a check=%check%+1
if %check%==1 set sdcard=N
goto sd_o
:sd_o
set /a check=0
if exist O:\apps set /a check=%check%+1
if %check%==1 set sdcard=O
goto sd_p
:sd_p
set /a check=0
if exist P:\apps set /a check=%check%+1
if %check%==1 set sdcard=P
goto sd_r
:sd_r
set /a check=0
if exist R:\apps set /a check=%check%+1
if %check%==1 set sdcard=R
goto sd_s
:sd_s
set /a check=0
if exist S:\apps set /a check=%check%+1
if %check%==1 set sdcard=S
goto sd_t
:sd_t
set /a check=0
if exist T:\apps set /a check=%check%+1
if %check%==1 set sdcard=T
goto sd_u
:sd_u
set /a check=0
if exist U:\apps set /a check=%check%+1
if %check%==1 set sdcard=U
goto sd_w
:sd_w
set /a check=0
if exist W:\apps set /a check=%check%+1
if %check%==1 set sdcard=W
goto sd_x
:sd_x
set /a check=0
if exist X:\apps set /a check=%check%+1
if %check%==1 set sdcard=X
goto sd_y
:sd_y
set /a check=0
if exist Y:\apps set /a check=%check%+1
if %check%==1 set sdcard=Y
goto sd_z
:sd_z
set /a check=0
if exist Z:\apps set /a check=%check%+1
if %check%==1 set sdcard=Z
goto sd_card_show
:sd_card_show
cls
echo.
echo %header%
echo ---------------------------------------------------------------------------------------------------------------------------
echo  [*] %string65%
echo.
echo ERROR: Could not find an SD Card>>"%MainFolder%/IOSPatcherLogs.txt"
if %sdcard%==NotDefined echo %string66%
if %sdcard%==NotDefined echo %string67%
if not %sdcard%==NotDefined goto sd_card_defined
pause>NUL
goto ask_for_copy_to_an_sd_card
:sd_card_defined
cls
echo.
echo %header%
echo ---------------------------------------------------------------------------------------------------------------------------
echo  [*] %string65%
echo.
echo %string68%: %sdcard%
echo %string69%
echo.
echo ---------------------------------------------------------------------------------------------------------------------------
echo 1. %string70%             2. %string71%                  3. %string72%
set /p s=
if %s%==1 goto sd_card_copying
if %s%==2 goto change_sd_card_letter
if %s%==3 goto ask_for_copy_to_an_sd_card
goto sd_card_defined
:change_sd_card_letter
cls
echo.
echo %header%
echo ---------------------------------------------------------------------------------------------------------------------------
echo  [*] %string65%
echo.
echo %string68%: %sdcard%
echo.
echo %string73%
set /p sdcard=
goto sd_card_defined
:sd_card_error
mode %mode%
cls
echo.
echo %header%
echo ---------------------------------------------------------------------------------------------------------------------------
echo  [*] %string29%
echo.
echo %string73%
pause
goto ask_for_copy_to_an_sd_card
:sd_card_copying
set /a copyingsdcard=1
set /a errorcopying=0
cls
echo INFO: Copying to SD Card (%sdcard%:\)>>"%MainFolder%\IOSPatcherLogs.txt"
echo.
echo %header%
echo ---------------------------------------------------------------------------------------------------------------------------
echo  [*] SD Card
echo.
echo %string17%...
copy "WAD" "%sdcard%:\" >NUL || set /a errorcopying=1
if %errorcopying%==1 goto sd_card_error
goto end


:end
set /a exiting=10
set /a timeouterror=1
timeout 1 /nobreak >NUL && set /a timeouterror=0
goto end1
:end1
mode %mode%
cls
cls
echo.
echo %header%
echo ---------------------------------------------------------------------------------------------------------------------------
echo  [*] %string74% :)
echo.
if %patchingok%==1 echo %string75%
if %patchingok%==1 echo %string76%
echo.
if %copyingsdcard%==1 echo %string77%
echo.
echo %string78%
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
if %copyingsdcard%==0 if %exiting%==0 start WAD
if %copyingsdcard%==1 if %exiting%==0 start %sdcard%:\WAD
if %exiting%==0 exit
if %timeouterror%==0 timeout 1 /nobreak >NUL
if %timeouterror%==1 ping localhost -n 2 >NUL
set /a exiting=%exiting%-1
goto end1
