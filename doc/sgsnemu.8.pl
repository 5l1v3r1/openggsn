
.\" * OpenGGSN - Gateway GPRS Support Node
.\" * Copyright (C) 2002, 2003 Mondru AB.
.\" * Polish translation copyright (C) 2004 Marek �akowicz <mazaczek@users.sourceforge.net>
.\" * 
.\" * The contents of this file may be used under the terms of the GNU
.\" * General Public License Version 2, provided that the above copyright
.\" * notice and this permission notice is included in all copies or
.\" * substantial portions of the software.
.\" * 
.\" * The initial developer of the original code is
.\" * Jens Jakobsen <jj@openggsn.org>
.\" * 
.\" * Contributor(s):
.\" * 
.\" * Translation to polish: Marek Zakowicz <mazak@debian.linux.org.pl>
.\" Manual page for ggsn
.\" SH section heading
.\" SS subsection heading
.\" LP paragraph
.\" IP indented paragraph
.\" TP hanging label

.TH sgsnemu 8 "Maj 2004"
.SH NAZWA
sgsnemu \- Emulator W�z�a Dostarczaj�cego Us�ug GPRS
.SH U�YTKOWANIE
.B sgsnemu
\-\-help

.B sgsnemu
\-\-version

.B sgsnemu
[
.BI \-\-debug
] [
.BI \-\-conf " plik"
] [
.BI \-\-pidfile " plik"
] [
.BI \-\-statedir " plik" 
] [ 
.BI \-\-dns " host"
] [ 
.BI \-\-listen " host" 
] [
.BI \-\-remote " host"
] [
.BI \-\-contexts " liczba"
] [
.BI \-\-timelimit " sekundy" 
] [
.BI \-\-gtpversion " wersja"
] [
.BI \-\-apn " apn"
] [
.BI \-\-selmode " tryb"
] [
.BI \-\-imsi " imsi"
] [
.BI \-\-nsapi " nsapi"
] [
.BI \-\-msisdn " msisdn"
] [
.BI \-\-qos " qos"
] [
.BI \-\-charging " op�ata"
] [
.BI \-\-uid " uid"
] [
.BI \-\-pwd " pwd"
] [
.BI \-\-createif
] [
.BI \-\-net " sie�" 
] [
.BI \-\-defaultroute
] [
.BI \-\-ipup " skrypt" 
] [
.BI \-\-ipdown " skrypt" 
] [
.BI \-\-pinghost " host"
] [
.BI \-\-pingrate " liczba"
] [
.BI \-\-pingsize " liczba"
] [
.BI \-\-pingcount " liczba"
]
.SH OPIS
.B sgsnemu
jest cz�ci� projektu
.B OpenGGSN
i implementuje emulator w�z�a dostarczaj�cego us�ug GPRS (SGSN).
Mo�e on by� wykorzystywany zar�wno do testowania w�z��w GGSN,
jak rdzenia sieci GRPS, czy po��cze� odwiedzaj�cych. 

Funkcjonalno�� i protoko�y GPRS zosta�y ustandaryzowane w ramach projektu 
Third Generation Partnership Project (3GPP).
Wed�ug specyfikacji 3GPP, SGSN posiada kilka interfejs�w.
.B sgsnemu
implementuje interfejs Gn/Gp, kt�ry jest wykorzystywany w kierunku
w�z��w GGSN.

Interfejs Gn/Gp mo�e by� postrzegany jako ��cze nadrz�dne w�z�a SGSN.
Jest ono wykorzystywane do komunikacji z w�z�em GGSN, kt�ry zazwyczaj jest
pod��czony do Internetu.
Interfejs Gn/Gp wykorzystuje protok� tunelowania GPRS (GTP).
Pakiety u�ytkownika (zazwyczaj pakiety IP) s� tunelowane za po�rednictwem protoko�u GTP,
kt�ry z kolei wykorzystuje protok� UDP nad IP.


.B sgsnemu 
ustanawia pewn� liczb� po��cze� do GGSN.
Wewn�trzny ping transmituje ��dania ICMP poprzez ju� ustanowione po��czenia.
Alternatywnie, mo�e by� utworzony lokalny interfejs sieciowy.
W tym przypadku
.B sgsnemu
przekazuje pakiety pomi�dzy lokalnym interfejsem sieciowym i po��czeniami
ustanowionymi na interfejsie Gn/Gp.

.B sgsnemu
wykorzystuje sterownik
.B TUN/TAP
jako interfejs lokalny.  Interfejs sieci tun jest ustanawiany dla ka�dego
po��czenia zestawianego z w�z�em GGSN.
B��dy wyst�puj�ce podczas pracy programu s� raportowane z wykorzystaniem 
.B syslogd (8).

.SH OPCJE
.TP
.BI --help
Wy�wietla pomoc i na tym ko�czy wykonanie programu.
  
.TP
.BI --version
Wy�wietla pomoc i na tym ko�czy wykonanie programu.
 
.TP
.BI --debug
Uruchamia w trybie usuwania b��d�w (domy�lnie wy��czone).
  
.TP
.BI --conf " plik"
Odczytuje konfiguracj� z
.I pliku
,kt�rego ka�da linia odpowiada jednej opcji
linii polece� pozbawionej przedrostka '--'.  Opcje podane w linii polece�
nadpisuj� opcje podane w pliku konfiguracyjnym.
 
.TP
.BI --pidfile " plik"
Nazwa
.I pliku
z identyfikatorem procesu (domy�lnie ./sgsnemu.pid)
  
.TP
.BI --statedir " �cie�ka"
.I �cie�ka
do katalogu z trwa�ymi (nie ulotnymi) danymi (domy�lnie ./)

.TP
.BI --dns " host"
Serwer DNS wykorzystywany do zapyta� APN.
Je�li parametr zosta� pomini�ty, wykorzystywana jest domy�lna, systemowa konfiguracja DNS.

.TP
.BI --listen " host"
Lokalny adres IP, kt�ry zostanie u�yty do nas�uchu przez interfejs Gn/Gp.
Ta opcja musi zosta� podana.
Z przyczyn bezpiecze�stwa nie mo�e by� wykorzystany INADDR_ANY.

.TP
.BI --remote " host"
.I Host
z w�z�em GGSN wykorzystywanym do po��cze�.  Je�li DNS jest prawid�owo skonfigurowany
to powinno by� mo�liwe podanie nazwy punktu dost�powego (APN) jako nazwy zdalnego hosta.

.TP
.BI --contexts " liczba"
Liczba ustanawianych kontekst�w (domy�lnie = 1).  W przypadku wielu kontekst�w
pierwszy kontekst jest ustanawiany z wykorzystaniem imsi + 0 i msidn + 0.
Drugi kontekst jest ustanawiany z wykorzystaniem imsi + 1 i msidn +1.
Trzeci ...

.TP
.BI --timelimit " sekundy"
Ko�czy wykonanie
.b sgsnemu
po up�ywie podanej liczy \fIsekund\fP.
W przypadku wykorzystywania opcji ping mo�na zako�czy�
.B sgsnemu
po wy�aniu
.B --pingcount
pakiet�w.  

.TP
.BI --gtpversion " wersja"
.I wersja
protoko�u GTP wykorzystywana przy ustanawianiu kontekst�w (domy�lnie = 1).
Je�li nie jest mo�liwe ustanowienie kontekstu GTPw1
.B sgsnemu
powt�rzy ��danie wykorzystuj�c GTPw0.
  
.TP
.BI --apn " apn"
.I apn
wykorzystywany przy ��czeniu si� z w�z�em GGSN (domy�lnie = internet).
APN jest akronimem angielskich s��w Access Point Name.

.TP
.BI --selmode " tryb"
Tryb wyboru wykorzystywany w komunikacji z w�z�em GGSN (domy�lnie = 0x01).
Jako tryby wyboru mog� by� wykorzystane nast�puj�ce kody:
0: MS lub sie� dostarczana przez APN, subskrypcja zweryfikowana,
1: MS dostarczany przez APN, subskrypcja nie zweryfikowana,
2: sie� dostarczana przez APN, subskrypcja nie zweryfikowana.

.TP
.BI --imsi " imsi"
.I imsi
wykorzystywane w komunikacji z w�z�em GGSN (domy�lnie = 240010123456789).
IMSI jest akronimem angielskich s��w International Mobile Subscriber Identity.
IMSI musi sk�ada� si� z dok�adnie 15 cyfr.  Por�wnaj z opcj�
.I contexts
by zobaczy� wykorzystanie 
.I imsi
w przypadku wielu kontekst�w.

.TP
.BI --nsapi " nsapi"
.I nsapi
wykorzystywane w komunikacji z w�z�em GGSN (domy�lnie = 0).
Warto�� musi by� pomi�dzy 0, a 15.

.TP
.BI --msisdn " msisdn"
.I msisdn
wykorzystywane w komunikacji z w�z�em GGSN (domy�lnie = 46702123456).
MSISDN jest akronimem angielskich s��w International Mobile Integrated Services Digital Network.
W istocie jest numerem telefonu zapisanym w mi�dzynarodowym formacie bez wiod�cych 00 lub 011.
Por�wnaj z opcj�
.I contexts
by zobaczy� wykorzystanie 
.I msisdn
w przypadku wielu kontekst�w.

.TP
.BI --qos " qos"
.I qos
wykorzystywany w komunikacji z w�z�em GGSN (domy�lnie = 0x0b921f).
QoS jest akronimem angielskich s��w Quality of Service.
Format tego parametru zosta� okre�lony na podstawie specyfikacji 3GPP 09.60.

.TP
.BI --charging " op�ata"
Charakterystyka rozliczania wykorzystywana w komunikacji z w�z�em GGSN
(domy�lnie = 0x0800).  0x0800 = normalna, 0x0400 = przedp�ata,
0x0200 = p�aska rata, 0x0100 = rozliczanie dynamiczne.
Format pola zosta� opisany w specyfikacji 3GPP 32.015.

.TP
.BI --uid " uid"
Identyfikator u�ytkownika wysy�any do GGSN jako opcja konfiguracyjna protoko�u.

.TP
.BI --pwd " has�o"
Identyfikator wysy�ane do GGSN jako opcja konfiguracyjna protoko�u.

.TP
.BI --createif
Tworzy lokalny interfejs tun, wykorzystywany dla
przesy�ania pakiet�w do i z interfejsu Gn/Gp.
Nale�y zaznaczy�, �e interfejs Gn/Gp zazwyczaj jest kierowany
do Internetu przez GGSN.  Tylko jeden interfejs mo�e by� utworzony, chocia�
wiele kontekst�w mo�e zosta� ustanowionych.
Interfejs mo�e by� podany dla ka�dego kontekstu jako adres IP, lub mo�e by�
okre�lony za pomoc� opcji
.I net.

.TP
.BI --net " sie�"
Adres sieci lokalnego interfejsu.
Opcja
.I net
jest poprawna tylko wtedy, gdy zosta�a wykorzystana opcja
.I createif.
Warto�� parametru
.I net
jest podawana w formacie cidr (sie�/maska).  Je�li opcja
.I net
zostanie pomini�ta, adres IP jest rezerwowany dla ka�dego ustanawianego kontekstu.

.TP
.BI --defaultroute
Definiuje domy�lne trasowanie przez lokalny interfejs tun.

.TP
.BI --ipup " skrypt"
Skrypt wykonywany po aktywacji interfejsu Gi w sieci tun.
Skrypt jest uruchamiany z nast�puj�cymi parametrami <nazwa urz�dzenia> <adres ip>.
  
.TP
.BI --ipdown " skrypt"
Skrypt wykonywany po wy��czeniu interfejsu Gi w sieci tun.
Skrypt jest uruchamiany z nast�puj�cymi parametrami <nazwa urz�dzenia> <adres ip>.
  
.TP
.BI --pinghost " host"
Powoduje wysy�anie pakiet�w ICMP do urz�dzenia
.I host
poprzez interfejs Gn/Gp.  Statystyki po��cze� s� raportowane w formie
bardzo zbli�onej do wyj�cia oryginalnego programu ping.  Mo�esz wykorzysta�
to udogodnienie do testowania wydajno�ci GGSN.

.TP
.BI --pingrate " liczba"
Ilo�� ��da� ICMP generowanych w przeci�gu sekundy (domy�lnie = 1).

.TP
.BI --pingsize " liczba"
Rozmiar generowanych ��da� ICMP wyra�ony w oktetach (domy�lnie = 56).


.TP
.BI --pingcount " liczba"
Oczekiwana ilo�� wygenerowanych ��da� ICMP (domy�lnie  = 0).
Warto�� 0 (zero) oznacza wielko�� nieograniczon�.

.TP
.BI --pingquiet
Wy��cza wypisywanie informacji o otrzymanych pakietach (domy�lnie pakiety s� wypisywane).
Jest to ca�kiem przydatne dla du�ych ilo�ci pakiet�w ICMP generowanych w przeci�gu sekundy
(por�wnaj z opcj� pingrate).

.SH PLIKI
.I sgsnemu.conf
.RS
Plik konfiguracyjny dla
.B sgsnemu.
.RE
.I .sgsnemu.pid
.RS
Plik zawieraj�cy identyfikator procesu.
.RE
.I ./
.RS
Katalog przechowuj�cy trwa�e (nie ulotne) dane.
.RE

.SH B��DY
Zg�aszaj b��dy na list� �ledzenia b��d�w OpenGGSN
.I http://sourceforge.net/projects/sgsnemu/


.SH "ZOBACZ TAK�E"
.BR ggsn (8), 
.BR syslog (8)

.SH UWAGI
.LP

Opr�cz d�ugich, udokumentowanych w tym podr�czniku, opcji
.B sgsnemu
wspiera r�wnie� pewn� liczb� kr�tkich opcji o tej samej funkcjonalno�ci.
Wywo�aj 
.B sgsnemu --help
by uzyska� pe�n� list� dost�pnych opcji.

Sterownik TUN/TAP jest wymagany dla poprawnego dzia�ania
.B sgsnemu. 
Dla j�der linuksa p�niejszych ni� 2.4.7 sterownik TUN/TAP jest zawarty w j�drze,
chocia� w typowej sytuacji musi by� �adowany oddzielnie za pomoc�
.B modprobe tun.
Aby �adowa� automatycznie nale�y do pliku
.B /etc/modules.conf.
doda� lini�  
.B alias char-major-10-200 tun
Aby uzyska� informacje o innych platformach zobacz stron�
.I http://vtun.sourceforge.net/tun/
opisuj�c� jak zainstalowa� i skonfigurowa� sterownik tun.

.B ggsn 
wykorzystuje protok� tunelowania GPRS (GTP) wyspecyfikowany przez 
Third Generation Partnership Project (3GPP). Specyfikacje protoko��w 3GPP
mog� by� znalezione na
.I http://www.3gpp.org

.SH COPYRIGHT

Copyright (C) 2002, 2003, 2004 by Mondru AB.

Zawarto�� tego pliku mo�e by� wykorzystywana stosownie do termin�w
Og�lnej, Publicznej Licencji (GPL) GNU w wersji 2 dostarczonej wraz
z niniejsz� uwag� o prawach autorskich zawart� we wszystkich kopiach
i istotnych fragmentach oprogramowania.

.SH AUTORZY
Jens Jakobsen <jj@openggsn.org>

.SH T�UMACZENIE
Polish translation copyright (C) 2004 Marek �akowicz <mazaczek@users.sourceforge.net>

T�umaczenie jest chronione prawami autorskimi.
Dozwolone jest korzystanie, rozprowadzanie i modyfikacja na zasadach licencji GNU GPL 2.
