
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

.TH ggsn 8 "Lipiec 2003"
.SH NAZWA
ggsn \- W�ze� Wspieraj�cy Bramy GPRS (ang. Gateway GPRS Support Node).
.SH U�YTKOWANIE
.B ggsn
\-\-help
  
.B ggsn
  \-\-version

.B ggsn
[
.BI \-\-fg
] [
.BI \-\-debug
] [
.BI \-\-conf " plik"
] [
.BI \-\-pidfile " plik"
] [
.BI \-\-statedir " plik" 
] [ 
.BI \-\-listen " host" 
] [
.BI \-\-net " sie�" 
] [
.BI \-\-ipup " skrypt" 
] [
.BI \-\-ipdown " skrypt" 
] [
.BI \-\-dynip " sie�" 
] [
.BI \-\-statip " sie�" 
] [
.BI \-\-pcodns1 " host" 
] [
.BI \-\-pcodns2 " host" 
] [
.BI \-\-timelimit " sekundy" 
]

.SH OPIS
.B ggsn
jest cz�ci� projektu 
.B OpenGGSN
i implementuje funkcjonalno�� w�z�a wspieraj�cego bramy GPRS.
W�z�y GGSN s� wykorzystywane przez operator�w sieci kom�rkowych jako interfejsy
pomi�dzy Internetem i reszt� infrastruktury sieci kom�rkowej.
  
Funkcjonalno�� i protoko�y GPRS zosta�y ustandaryzowane w ramach projektu
Third Generation Partnership Project (3GPP).  Stosownie do specyfikacji 3GPP,
GGSN posiada dwa interfejsy: interfejs Gn/Gp oraz interfejs Gi.
 
Interfejs Gn/Gp mo�e by� postrzegany jako ��cze podrz�dne w�z�a GGSN.
Jest on wykorzystywany do komunikacji z W�z�em Dostarczaj�cym Us�ug GPRS
(SGSN), kt�ry z kolei jest interfejsem do radiowej sieci dost�powej.
Interfejs Gn/Gp wykorzystuje protok� tunelowania GPRS (GTP).  Pakiety danych
u�ytkownika (zazwyczaj pakiety IP) s� tunelowane za po�rednictwem protoko�u GTP,
kt�ry z kolei wykorzystuje protok� UDP nad IP.
  
Drugi z interfejs�w mo�e by� postrzegany jako ��cze nadrz�dne,
prowadz�ce z w�z�a GGSN do zewn�trznej sieci danych.
Gi jest najcz�ciej interfejsem do Internetu.
 
.B ggsn
wykorzystuje
.B sterownik TUN/TAP
jako interfejs Gi.  Interfejs w sieci tun jest uruchamiany podczas startu
.B ggsn.
 
.B ggsn
odbiera po��czenia nadchodz�ce od urz�dze� ruchomych za po�rednictwem
sieci radiowej oraz SGSN.  Gdy nadchodzi ��danie po��czenia, ggsn rezerwuje
dla urz�dzenia ruchomego dynamiczny adres IP i pozwala urz�dzeniu ruchomemu
korzysta� z interfejsu Gi.  Po��czenia mog� by� zamykane zar�wno przez
stacje ruchome, jak i SGSN.  B��dy wyst�puj�ce podczas pracy programu
s� raportowane z wykorzystaniem 
.B syslogd (8).
  
W typowej sytuacji
.B ggsn
jest uruchamiany na komputerze z dwoma kartami Ethernet - jedn�
przeznaczon� dla interfejsu Gn/Gp i jedn� dla interfejsu Gi.
Polityki trasowania i regu�y �ciany ogniowej powinny by� wykorzystane
w celu rozdzielenia ruchu Gi od ruchu Gn/Gp.
  
.SH OPCJE
.TP
.BI --help
Wy�wietla pomoc i na tym ko�czy wykonanie programu.
  
.TP
.BI --version
Wy�wietla pomoc i na tym ko�czy wykonanie programu.
 
.TP
.BI --fg
Uruchamia na pierwszym planie (domy�lnie wy��czone).
  
.TP
.BI --debug
Uruchamia w trybie usuwania b��d�w (domy�lnie wy��czone).
  
.TP
.BI --conf " plik"
Odczytuje konfiguracj� z
.I pliku
(domy�lnie /etc/ggsn.conf), kt�rego ka�da linia odpowiada jednej opcji
linii polece� pozbawionej przedrostka '--'.  Opcje podane w linii polece�
nadpisuj� opcje podane w pliku konfiguracyjnym.
 
.TP
.BI --pidfile " plik"
Nazwa
.I pliku
z identyfikatorem procesu (domy�lnie /var/run/ggsn.pid)
  
.TP
.BI --statedir " �cie�ka"
.I �cie�ka
do katalogu z trwa�ymi (nie ulotnymi) danymi (domy�lnie /var/lib/ggsn/)
 
.TP
.BI --listen " host"
Lokalny adres IP, kt�ry zostanie u�yty do nas�uchu przez interfejs Gn/Gp.
Ta opcja musi zosta� podana.
Z przyczyn bezpiecze�stwa nie mo�e by� wykorzystany INADDR_ANY.

.TP
.BI --net " sie�"
Adres sieci interfejsu Gi (domy�lnie 192.168.0.0/24).
Adres sieci jest ustawiany podczas inicjalizacji, gdy
.B ggsn
uruchamia urz�dzenie tun dla interfejsu Gi.
 
.TP
.BI --ipup " skrypt"
Skrypt wykonywany po aktywacji interfejsu Gi w sieci tun.
Skrypt jest uruchamiany z nast�puj�cymi parametrami <nazwa urz�dzenia> <adres ip>.
  
.TP
.BI --ipdown " skrypt"
Skrypt wykonywany po wy��czeniu interfejsu Gi w sieci tun.
Skrypt jest uruchamiany z nast�puj�cymi parametrami <nazwa urz�dzenia> <adres ip>.
  
.TP
.BI --dynip " sie�"
Pula dynamicznych adres�w sieci IP.  Okre�la pul� dynamicznych adres�w IP.
Je�li ta opcja zostanie pomini�ta, ggsn wykorzystuje do dynamicznej rezerwacji
adres�w IP, adres sieci okre�lony przez opcj�
.BI --net.
  
.TP
.BI --pcodns1 " host"
Serwer PCO DNS 1 (domy�lnie 0.0.0.0). PCO jest akronimem 
Protocol Configuration Options, co t�umaczy si� jako Protok� Opcji
Konfiguracyjnych i jest cz�ci� specyfikacji prtoko��w GPRS.  Jest
wykorzystywany do informowania stacji ruchomej o adresie serwera DNS
stosowanego do rozwi�zywania nazw host�w.
  
.TP
.BI --pcodns2 " host"
Serwer PCO DNS 2 (domy�lnie 0.0.0.0). PCO jest akronimem 
Protocol Configuration Options, co t�umaczy si� jako Protok� Opcji
Konfiguracyjnych i jest cz�ci� specyfikacji prtoko��w GPRS.  Jest
wykorzystywany do informowania stacji ruchomej o adresie serwera DNS
stosowanego do rozwi�zywania nazw host�w.
  
.TP
.BI --timelimit " sekundy"
Ko�czy wykonanie
.b ggsn
po up�ywie podanej liczy \fIsekund\fP.
Opcja wykorzystywana w celu usuwania b��d�w.
  

.SH PLIKI
.I /etc/ggsn.conf
.RS
Plik konfiguracyjny dla
.B ggsn.
.RE
.I /var/run/ggsn.pid
.RS
Plik zawieraj�cy identyfikator procesu.
.RE
.I /var/lib/ggsn
.RS
Katalog przechowuj�cy trwa�e (nie ulotne) dane.
.RE

.SH B��DY
Zg�aszaj b��dy na list� �ledzenia b��d�w OpenGGSN
.I http://sourceforge.net/projects/ggsn/

.B ggsn
ma bardzo ograniczone wsparcie dla zarz�dzania.
Obecnie zar�wno SNMP jak i mechanizmy rozliczania s� pomini�te.
  
.SH "ZOBACZ TAK�E"
.BR sgsnemu (8), 
.BR syslogd (8)
 
.SH UWAGI
.LP
  
Opr�cz d�ugich, udokumentowanych w tym podr�czniku, opcji
.B ggsn
wspiera r�wnie� pewn� liczb� kr�tkich opcji o tej samej funkcjonalno�ci.
Wywo�aj 
.B ggsn --help
by uzyska� pe�n� list� dost�pnych opcji.

Sterownik TUN/TAP jest wymagany dla poprawnego dzia�ania
.B ggsn. 
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

Copyright (C) 2002, 2003 by Mondru AB.

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
