******************************************************
***200323 - SOEP v35 - pl                          ***
******************************************************

* DoFile zum Aufsatz Baron/Görtz: "Sozioökonomische und einstellungsbezogene Ursachen für Wanderungen von CDU/CSU- und SPD-Wähler*innen zur AfD bei der Bundestagswahl 2017"

*******************************************************
********************************

clear

version 17

set more off

*** Verzeichnis festlegen

cd "..."		// In dieser Zeile muss der Ordner angegeben werden, in dem der nachfolgende Datensatz liegt

* SOEP-Datensatz inklusive Gewichten 

* Achtung: Es wird empfohlen, Version 35 des SOEP zu verwenden, um Kompatibilitaet der Variablennamen zu gewaehrleisten

* Es sollte der um Gewichtungen ergaenzte SOEP-Datensatz verwendet werden. Der DoFile befindet sich im Repositorium, Name: DoFile - PVS - Baron Goertz - Gewichte

* Generelle Hinweise zu Aufbereitungen hier: Grabka, Markus M. (2020): SOEP-Core v35 - 
* Codebook for the $PEQUIV File 1984-2018: CNEF variables with extended income information for the SOEP. SOEP Survey Papers No. 772: Series D. Berlin: DIE/SOEP

use "..."					

* Ggf. Missings deklarieren:

* mvdecode _all, mv (-9 -8 -7 -6 -5 -4 -3 -2 -1)

********************************

**** DATENAUFBEREITUNG ****

**** AV (plh0333) aufbereiten ****

* Dummies fuer jede Partei in Bundestag bilden:

* SPD

gen plh0333spd = .

replace plh0333spd=1 if plh0333==1
replace plh0333spd=0 if plh0333>=2 & plh0333<28 | plh0333==30 | plh0333==31

tab plh0333spd

* CDU

gen plh0333cdu_csu = .

replace plh0333cdu_csu=1 if plh0333==2 | plh0333==3
replace plh0333cdu_csu=0 if plh0333==1 | plh0333>=4 & plh0333<28 | plh0333==30 | plh0333==31

tab plh0333cdu_csu

* FDP

gen plh0333fdp = .

replace plh0333fdp=1 if plh0333==4
replace plh0333fdp=0 if plh0333>=1 & plh0333<=3 | plh0333>=5 & plh0333<28 | plh0333==30 | plh0333==31

tab plh0333fdp

* Gruene

gen plh0333gruene = .

replace plh0333gruene=1 if plh0333==5
replace plh0333gruene=0 if plh0333>=1 & plh0333<=4 | plh0333>=6 & plh0333<28 | plh0333==30 | plh0333==31

tab plh0333gruene

* Linke

gen plh0333linke = .

replace plh0333linke=1 if plh0333==6
replace plh0333linke=0 if plh0333>=1 & plh0333<=5 | plh0333>=7 & plh0333<28 | plh0333==30 | plh0333==31

tab plh0333linke

* AfD

gen plh0333afd = .

replace plh0333afd=1 if plh0333==27
replace plh0333afd=0 if plh0333>=1 & plh0333<=6 | plh0333>=5 & plh0333<27 | plh0333==30 | plh0333==31

tab plh0333afd

* Nicht gewaehlt

* ACHTUNG: Anderes Gesamtsample !

gen plh0333nichtwahl = .

replace plh0333nichtwahl=1 if plh0333==28
replace plh0333nichtwahl=0 if plh0333>0 & plh0333<28 | plh0333==29 | plh0333==30 | plh0333==31

tab plh0333nichtwahl

* Nicht wahlberechtigt

* ACHTUNG: Anderes Gesamtsample !

gen plh0333nichtwahlberecht = .

replace plh0333nichtwahlberecht=1 if plh0333==29
replace plh0333nichtwahlberecht=0 if plh0333>0 & plh0333<29 | plh0333==30 | plh0333==31

tab plh0333nichtwahlberecht

********************************

* Jahresspezifische Dummies fuer Parteien bilden:

* SPD-Waehlende 2013:

gen spd2013 = 0 if syear==2014 & plh0333spd==0

replace spd2013 = 1 if syear==2014 & plh0333spd==1

tab spd2013

* SPD-Waehlende 2017:

gen spd2017 = 0 if syear==2017 & plh0333spd[_n+1]==0

replace spd2017 = 1 if syear==2017 & plh0333spd[_n+1]==1

tab spd2017

forval i=1/5 {
	bysort pid: replace spd2017=1 if spd2017[_n+1]==1
}

forval i=1/5 {
	bysort pid: replace spd2017=0 if spd2017[_n+1]==0
}

* CDU/CSU-Waehlende 2013:

gen cdu_csu2013 = 0 if syear==2014 & plh0333cdu_csu==0

replace cdu_csu2013 = 1 if syear==2014 & plh0333cdu_csu==1

tab cdu_csu2013

* CDU/CSU-Waehlende 2017:

gen cdu_csu2017 = 0 if syear==2017 & plh0333cdu_csu[_n+1]==0

replace cdu_csu2017 = 1 if syear==2017 & plh0333cdu_csu[_n+1]==1

tab cdu_csu2017

* FDP-Waehlende 2013:

gen fdp2013 = 0 if syear==2014 & plh0333fdp==0

replace fdp2013 = 1 if syear==2014 & plh0333fdp==1

tab fdp2013

* FDP-Waehlende 2017:

gen fdp2017 = 0 if syear==2017 & plh0333fdp[_n+1]==0

replace fdp2017 = 1 if syear==2017 & plh0333fdp[_n+1]==1

tab fdp2017

* Gruene-Waehlende 2013:

gen gruene2013 = 0 if syear==2014 & plh0333gruene==0

replace gruene2013 = 1 if syear==2014 & plh0333gruene==1

tab gruene2013

* Gruene-Waehlende 2017:

gen gruene2017 = 0 if syear==2017 & plh0333gruene[_n+1]==0

replace gruene2017 = 1 if syear==2017 & plh0333gruene[_n+1]==1

tab gruene2017

* Linke-Waehlende 2013:

gen linke2013 = 0 if syear==2014 & plh0333linke==0

replace linke2013 = 1 if syear==2014 & plh0333linke==1

tab linke2013

* Linke-Waehlende 2017:

gen linke2017 = 0 if syear==2017 & plh0333linke[_n+1]==0

replace linke2017 = 1 if syear==2017 & plh0333linke[_n+1]==1

tab linke2017

* AfD-Waehlende 2013:

gen afd2013 = 0 if syear==2014 & plh0333afd==0

replace afd2013 = 1 if syear==2014 & plh0333afd==1

tab afd2013

* AfD-Waehlende 2017:

gen afd2017 = 0 if syear==2017 & plh0333afd[_n+1]==0

replace afd2017 = 1 if syear==2017 & plh0333afd[_n+1]==1

tab afd2017

* Nichtwaehler_innen 2013:

gen nichtwahl2013 = 0 if syear==2013 & plh0333nichtwahl[_n+1]==0

replace nichtwahl2013 = 1 if syear==2013 & plh0333nichtwahl[_n+1]==1

* Nichtwaehler_innen 2017:

gen nichtwahl2017 = 0 if syear==2017 & plh0333nichtwahl[_n+1]==0

replace nichtwahl2017 = 1 if syear==2017 & plh0333nichtwahl[_n+1]==1

********************************

* Datensatz sortieren und Uebersicht:

sort pid syear

* Beispiel:

list pid syear yearcount spd2013 afd2017 if pid==52402

sort pid syear

********************************

* Parteienspezifische AV bilden:

* AV bilden (Wechsel von SPD etc. 2013 zu AfD 2017 im Vergleich jenen, die bei SPD etc. 2017 bleiben)

* Hilfsvariable erstellen:

by pid: gen spdhilf=_N if spd2013==1

list pid syear yearcount spd2013 spd2017 afd2017 spdhilf if pid==52402

list pid syear yearcount spd2013 spd2017 afd2017 spdhilf if pid==31901

list pid syear yearcount spd2013 spd2017 afd2017 spdhilf if pid==1501

tab spdhilf

by pid: replace spdhilf=_N if spdhilf[_n-1]==6

list pid syear yearcount spd2013 spd2017 afd2017 spdhilf if pid==52402

list pid syear yearcount spd2013 spd2017 afd2017 spdhilf if pid==31901

list pid syear yearcount spd2013 spd2017 afd2017 spdhilf if pid==1501

tab spdhilf

* AV bilden fuer Studie 1 (Wechsel von SPD 2013 zu AfD 2017 im Vergleich jenen, die bei SPD 2017 bleiben)

by pid: gen wechselafdvonspd_1=1 if afd2017==1 & spdhilf[_n-1]==6

list pid syear yearcount spd2013 spd2017 afd2017 spdhilf wechselafdvonspd_1 if pid==52402

list pid syear yearcount spd2013 spd2017 afd2017 spdhilf wechselafdvonspd_1 if pid==31901

list pid syear yearcount spd2013 spd2017 afd2017 spdhilf wechselafdvonspd_1 if pid==1501

tab wechselafdvonspd_1

by pid: replace spdhilf=. if syear<2018

tab spdhilf

*** Einschub 21.9.21

forval i=1/5 {
	by pid: replace spdhilf=6 if spdhilf[_n+1]==6
}

by pid: replace wechselafdvonspd_1=0 if spd2017==1 & spdhilf==6 & (cdu_csu2017==0 | fdp2017==0 | gruene2017==0 | linke2017==0 | afd2017==0)

* Finale Kodierung

by pid: replace wechselafdvonspd_1=1 if spd2013==1

by pid: replace wechselafdvonspd_1=0 if spd2013==0 & spdhilf==6

by pid: replace wechselafdvonspd_1=0 if afd2017==. & spdhilf==6

by pid: replace spd2013=spd2013[_n+1] if syear==2013

by pid: replace spd2013=spd2013[_n-1] if syear==2015
by pid: replace spd2013=spd2013[_n-1] if syear==2016
by pid: replace spd2013=spd2013[_n-1] if syear==2017
by pid: replace spd2013=spd2013[_n-1] if syear==2018

* Einschub Ende

list pid syear yearcount spd2013 spd2017 afd2017 spdhilf wechselafdvonspd_1 if pid==52402

list pid syear yearcount spd2013 spd2017 afd2017 spdhilf wechselafdvonspd_1 if pid==31901

list pid syear yearcount spd2013 spd2017 afd2017 spdhilf wechselafdvonspd_1 if pid==1501

tab wechselafdvonspd_1

* Variablen- und Wertelabels erstellen:

label var wechselafdvonspd_1 "Wechsel zur AfD 2017 von SPD 2013"

label define wechselafdvon 1 "Wechsel (1)" 0 "Kein Wechsel (0)"

label values wechselafdvonspd_1 wechselafdvon

* Kontrolle:

tab wechselafdvonspd_1

tab spd2013

tab spd2017

********************************

* Weitere AV erstellen: Wechsel von CDU/CSU 2013 zu AfD 2017 im Vergleich jenen, die bei CDU/CSU 2017 bleiben)

* Hilfsvariable:

by pid: gen cdu_csuhilf=_N if cdu_csu2013==1

tab cdu_csuhilf

by pid: replace cdu_csuhilf=_N if cdu_csuhilf[_n-1]==6

tab cdu_csuhilf

* AV bilden

by pid: gen wechselafdvoncducsu_1=1 if afd2017==1 & cdu_csuhilf[_n-1]==6

tab wechselafdvoncducsu_1

by pid: replace cdu_csuhilf=. if syear<2018

tab cdu_csuhilf

*** Einschub 21.9.21

forval i=1/5 {
	by pid: replace cdu_csuhilf=6 if cdu_csuhilf[_n+1]==6
}

by pid: replace wechselafdvoncducsu_1=0 if cdu_csu2017==1 & cdu_csuhilf==6 & (spd2017==0 | fdp2017==0 | gruene2017==0 | linke2017==0 | afd2017==0)

* Finale Kodierung

by pid: replace wechselafdvoncducsu_1=1 if cdu_csu2013==1

by pid: replace wechselafdvoncducsu_1=0 if cdu_csu2013==0 & cdu_csuhilf==6

by pid: replace wechselafdvoncducsu_1=0 if afd2017==. & cdu_csuhilf==6

by pid: replace cdu_csu2013=cdu_csu2013[_n+1] if syear==2013

by pid: replace cdu_csu2013=cdu_csu2013[_n-1] if syear==2015
by pid: replace cdu_csu2013=cdu_csu2013[_n-1] if syear==2016
by pid: replace cdu_csu2013=cdu_csu2013[_n-1] if syear==2017
by pid: replace cdu_csu2013=cdu_csu2013[_n-1] if syear==2018

* Einschub Ende

tab wechselafdvoncducsu_1

* Variablen- und Wertelabels erstellen:

label var wechselafdvoncducsu_1 "Wechsel zur AfD 2017 von CDU/CSU 2013"

label values wechselafdvoncducsu_1 wechselafdvon

* Kontrolle:

tab wechselafdvoncducsu_1

tab cdu_csu2013

tab cdu_csu2017

********************************

* Weitere AV erstellen: Wechsel von FDP 2013 zu AfD 2017 im Vergleich jenen, die bei FDP 2017 bleiben)

* Hilfsvariable:

by pid: gen fdphilf=_N if fdp2013==1

tab fdphilf

by pid: replace fdphilf=_N if fdphilf[_n-1]==6

tab fdphilf

* AV bilden

by pid: gen wechselafdvonfdp_1=1 if afd2017==1 & fdphilf[_n-1]==6

tab wechselafdvonfdp_1

by pid: replace fdphilf=. if syear<2018

tab fdphilf

*** Einschub 21.9.21

forval i=1/5 {
	by pid: replace fdphilf=6 if fdphilf[_n+1]==6
}

by pid: replace wechselafdvonfdp_1=0 if fdp2017==1 & fdphilf==6 & (cdu_csu2017==0 | spd2017==0 | gruene2017==0 | linke2017==0 | afd2017==0)

* Finale Kodierung

by pid: replace wechselafdvonfdp_1=1 if fdp2013==1

by pid: replace wechselafdvonfdp_1=0 if fdp2013==0 & fdphilf==6

by pid: replace wechselafdvonfdp_1=0 if afd2017==. & fdphilf==6

by pid: replace fdp2013=fdp2013[_n+1] if syear==2013

by pid: replace fdp2013=fdp2013[_n-1] if syear==2015
by pid: replace fdp2013=fdp2013[_n-1] if syear==2016
by pid: replace fdp2013=fdp2013[_n-1] if syear==2017
by pid: replace fdp2013=fdp2013[_n-1] if syear==2018

* Einschub Ende

tab wechselafdvonfdp_1

* Variablen- und Wertelabels erstellen:

label var wechselafdvonfdp_1 "Wechsel zur AfD 2017 von FDP 2013"

label values wechselafdvonfdp_1 wechselafdvon

* Kontrolle:

tab wechselafdvonfdp_1

tab fdp2013

tab fdp2017

********************************

* Weitere AV erstellen: Wechsel von Gruene 2013 zu AfD 2017 im Vergleich jenen, die bei Gruene 2017 bleiben)

* Hilfsvariable:

by pid: gen gruenehilf=_N if gruene2013==1

tab gruenehilf

by pid: replace gruenehilf=_N if gruenehilf[_n-1]==6

tab gruenehilf

* AV bilden

by pid: gen wechselafdvongruene_1=1 if afd2017==1 & gruenehilf[_n-1]==6

tab wechselafdvongruene_1

by pid: replace gruenehilf=. if syear<2018

tab gruenehilf

*** Einschub 21.9.21

forval i=1/5 {
	by pid: replace gruenehilf=6 if gruenehilf[_n+1]==6
}

by pid: replace wechselafdvongruene_1=0 if gruene2017==1 & gruenehilf==6 & (cdu_csu2017==0 | spd2017==0 | fdp2017==0 | linke2017==0 | afd2017==0)

* Finale Kodierung

by pid: replace wechselafdvongruene_1=1 if gruene2013==1

by pid: replace wechselafdvongruene_1=0 if gruene2013==0 & gruenehilf==6

by pid: replace wechselafdvongruene_1=0 if afd2017==. & gruenehilf==6

by pid: replace gruene2013=gruene2013[_n+1] if syear==2013

by pid: replace gruene2013=gruene2013[_n-1] if syear==2015
by pid: replace gruene2013=gruene2013[_n-1] if syear==2016
by pid: replace gruene2013=gruene2013[_n-1] if syear==2017
by pid: replace gruene2013=gruene2013[_n-1] if syear==2018

* Einschub Ende

tab wechselafdvongruene_1

* Variablen- und Wertelabels erstellen:

label var wechselafdvongruene_1 "Wechsel zur AfD 2017 von Gruene 2013"

label values wechselafdvongruene_1 wechselafdvon

* Kontrolle:

tab wechselafdvongruene_1

tab gruene2013

tab gruene2017

********************************

* Weitere AV erstellen: Wechsel von Linke 2013 zu AfD 2017 im Vergleich jenen, die bei Linke 2017 bleiben)

* Hilfsvariable:

by pid: gen linkehilf=_N if linke2013==1

tab linkehilf

by pid: replace linkehilf=_N if linkehilf[_n-1]==6

tab linkehilf

* AV bilden

by pid: gen wechselafdvonlinke_1=1 if afd2017==1 & linkehilf[_n-1]==6

tab wechselafdvonlinke_1

by pid: replace linkehilf=. if syear<2018

tab linkehilf

*** Einschub 21.9.21

forval i=1/5 {
	by pid: replace linkehilf=6 if linkehilf[_n+1]==6
}

by pid: replace wechselafdvonlinke_1=0 if linke2017==1 & linkehilf==6 & (cdu_csu2017==0 | spd2017==0 | fdp2017==0 | gruene2017==0 | afd2017==0)

* Finale Kodierung

by pid: replace wechselafdvonlinke_1=1 if linke2013==1

by pid: replace wechselafdvonlinke_1=0 if linke2013==0 & linkehilf==6

by pid: replace wechselafdvonlinke_1=0 if afd2017==. & linkehilf==6

by pid: replace linke2013=linke2013[_n+1] if syear==2013

by pid: replace linke2013=linke2013[_n-1] if syear==2015
by pid: replace linke2013=linke2013[_n-1] if syear==2016
by pid: replace linke2013=linke2013[_n-1] if syear==2017
by pid: replace linke2013=linke2013[_n-1] if syear==2018

* Einschub Ende

tab wechselafdvonlinke_1

* Variablen- und Wertelabels erstellen:

label var wechselafdvonlinke_1 "Wechsel zur AfD 2017 von Linke 2013"

label values wechselafdvonlinke_1 wechselafdvon

* Kontrolle:

tab wechselafdvonlinke_1

tab linke2013

tab linke2017

********************************

* Weitere AV erstellen: Wechsel von Nichtwahl 2013 zu AfD 2017 im Vergleich jenen, die bei Nichtwahl 2017 bleiben)

* Hilfsvariable erstellen:

by pid: gen nichtwahlhilf=_N if nichtwahl2013==1

tab nichtwahlhilf

by pid: replace nichtwahlhilf=_N if nichtwahlhilf[_n-1]==6

tab nichtwahlhilf

* AV bilden fuer Studie 1 (Wechsel von Nichtwahl 2013 zu AfD 2017 im Vergleich jenen, die bei Nichtwahl 2017 bleiben)

by pid: gen wechselafdvonnichtwahl_1=1 if afd2017==1 & nichtwahlhilf[_n-1]==6

tab wechselafdvonnichtwahl_1

by pid: replace nichtwahlhilf=. if syear<2018

tab nichtwahlhilf

*** Einschub 21.9.21

forval i=1/5 {
	by pid: replace nichtwahlhilf=6 if nichtwahlhilf[_n+1]==6
}

by pid: replace wechselafdvonnichtwahl_1=0 if nichtwahl2017==1 & nichtwahlhilf==6 & (spd2017==0 | cdu_csu2017==0 | fdp2017==0 | gruene2017==0 | linke2017==0 | afd2017==0)

* Finale Kodierung

by pid: replace wechselafdvonnichtwahl_1=1 if nichtwahl2013==1

by pid: replace wechselafdvonnichtwahl_1=0 if nichtwahl2013==0 & nichtwahlhilf==6

by pid: replace wechselafdvonnichtwahl_1=0 if afd2017==. & nichtwahlhilf==6

* by pid: replace nichtwahl2013=nichtwahl2013[_n+1] if syear==2013

by pid: replace nichtwahl2013=nichtwahl2013[_n-1] if syear==2014
by pid: replace nichtwahl2013=nichtwahl2013[_n-1] if syear==2015
by pid: replace nichtwahl2013=nichtwahl2013[_n-1] if syear==2016
by pid: replace nichtwahl2013=nichtwahl2013[_n-1] if syear==2017
by pid: replace nichtwahl2013=nichtwahl2013[_n-1] if syear==2018

by pid: replace wechselafdvonnichtwahl_1=0 if nichtwahl2013==1 & afd2017==0 & syear==2017

* set more on

* list pid syear yearcount nichtwahl2013 nichtwahl2017 afd2017 nichtwahlhilf wechselafdvonnichtwahl_1

* set more on

* list pid syear yearcount nichtwahl2013 nichtwahl2017 afd2017 nichtwahlhilf wechselafdvonnichtwahl_1 if syear==2017 & afd2017==1

* Einschub Ende

tab wechselafdvonnichtwahl_1

* Variablen- und Wertelabels erstellen:

label var wechselafdvonnichtwahl_1 "Wechsel zur AfD 2017 von Nichtwahl 2013"

label values wechselafdvonnichtwahl_1 wechselafdvon

* Kontrolle:

tab wechselafdvonnichtwahl_1

tab nichtwahl2013

tab nichtwahl2017

****************************************

* Gesamtuebersicht:

tab wechselafdvonspd_1

tab wechselafdvoncducsu_1

tab wechselafdvonfdp_1

tab wechselafdvongruene_1

tab wechselafdvonlinke_1

tab wechselafdvonnichtwahl_1

********************************

* Aufbereiten afd2013

by pid: replace afd2013=afd2013[_n+1] if syear==2013

by pid: replace afd2013=afd2013[_n-1] if syear==2015
by pid: replace afd2013=afd2013[_n-1] if syear==2016
by pid: replace afd2013=afd2013[_n-1] if syear==2017
by pid: replace afd2013=afd2013[_n-1] if syear==2018

tab afd2013

* Aufbereiten afd2017

by pid: replace afd2017=afd2017[_n+1] if syear==2016
by pid: replace afd2017=afd2017[_n+1] if syear==2015
by pid: replace afd2017=afd2017[_n+1] if syear==2014
by pid: replace afd2017=afd2017[_n+1] if syear==2013

tab afd2017

****************************************

* AV bilden (fuer Robustheitsanalysen): Wechsel von einer der anderen Parteien oder aus Nichtwahl zu AfD 2017:

gen wechsel_zu_afd=.

* Wechsler_innen

by pid: replace wechsel_zu_afd=1 if syear==2017 & afd2017==1 & (spdhilf==6 | cdu_csuhilf==6 | fdphilf==6 | gruenehilf==6 | linkehilf==6 | nichtwahlhilf==6)

* Personen, die nicht wechseln:

by pid: replace wechsel_zu_afd=0 if syear==2017 & afd2017==0 & (spdhilf==6 | cdu_csuhilf==6 | fdphilf==6 | gruenehilf==6 | linkehilf==6 | nichtwahlhilf==6)

by pid: replace wechsel_zu_afd=wechsel_zu_afd[_n+1] if syear==2016
by pid: replace wechsel_zu_afd=wechsel_zu_afd[_n+1] if syear==2015
by pid: replace wechsel_zu_afd=wechsel_zu_afd[_n+1] if syear==2014
by pid: replace wechsel_zu_afd=wechsel_zu_afd[_n+1] if syear==2013

lab var wechsel_zu_afd "Wechsel zur AfD 2017"

lab val wechsel_zu_afd wechselafdvon

* Kontrolle:

list pid syear yearcount spd2013 spd2017 afd2017 spdhilf wechsel_zu_afd wechselafdvonspd_1 if pid==52402

list pid syear yearcount spd2013 spd2017 afd2017 spdhilf wechsel_zu_afd wechselafdvonspd_1 if pid==31901

list pid syear yearcount spd2013 spd2017 afd2017 spdhilf wechsel_zu_afd wechselafdvonspd_1 if pid==1501

tab wechsel_zu_afd

* Jahr 2018 loeschen

****************************************

* AV bilden (fuer Robustheitsanalysen): Wanderung zur AfD von allen Parteien

gen partei2013=.

replace partei2013=0 if afd2013==1
replace partei2013=1 if cdu_csu2013==1
replace partei2013=2 if spd2013==1
replace partei2013=3 if fdp2013==1
replace partei2013=4 if gruene2013==1
replace partei2013=5 if linke2013==1
replace partei2013=6 if nichtwahl2013==1

lab var partei2013 "Wahlentscheidung 2013"

lab define partei2013 0 "AfD" 1 "CDU/CSU" 2 "SPD" 3 "FDP" 4 "Grüne" 5 "Linke" 6 "Nicht gewählt"

lab val partei2013 partei2013

tab partei2013

****************************************

* AV bilden (fuer Robustheitsanalysen): Wanderung zur AfD von allen Parteien fuer multinomiales Modelle

gen wanderung2017=.

by pid: replace wanderung2017=0 if syear==2013 & (cdu_csu2013==1 | spd2013==1 | fdp2013==1 | gruene2013==1 | linke2013==1)

by pid: replace wanderung2017=0 if syear==2017 & (cdu_csu2017==1 | spd2017==1 | fdp2017==1 | gruene2017==1 | linke2017==1)

by pid: replace wanderung2017=1 if syear==2017 & wechselafdvoncducsu_1==1

by pid: replace wanderung2017=2 if syear==2017 & wechselafdvonspd_1==1

by pid: replace wanderung2017=3 if syear==2017 & wechselafdvonfdp_1==1 | wechselafdvongruene_1==1 | wechselafdvonlinke_1==1

* Wertelabels

lab define wanderung2017 0 "Bleiben bei urspruenglicher Partei 2017" 1 "Wechsel von CDU/CSU zu AfD 2017" 2 "Wechsel von SPD zu AfD 2017" ///
3 "Wechsel von FDP, Gruenen od. Linke zu AfD 2017"

lab val wanderung2017 wanderung2017

tab wanderung2017

* set more on

* list pid syear yearcount cdu_csu2013 cdu_csu2017 wechselafdvoncducsu_1 wanderung2017, sepby(pid)

* set more on

* list pid syear yearcount cdu_csu2013 cdu_csu2017 wechselafdvoncducsu_1 wanderung2017 if pid==31901, sepby(pid)

* set more on

* list pid syear yearcount cdu_csu2013 cdu_csu2017 wechselafdvoncducsu_1 wanderung2017 if pid==162701, sepby(pid)

****************************************
****************************************

* UV aufbereiten

****************************************

sort pid syear

* Neue Variable zur Erfassung des Erwerbsstatus (zeitkonstant) erstellen (22.7.2021)

gen erwerbstat=.

replace erwerbstat=1 if plb0022_h>=1 & plb0022_h<=8
replace erwerbstat=0 if plb0022_h==9

lab define erwerbstat 0 "Erwerbslos" 1 "Erwerbstaetig"

lab val erwerbstat erwerbstat

tab erwerbstat

* Jahresspezifische Variablen: Erwerbsstatus 2013 - 2015

gen erwerbstat_2013 = erwerbstat if syear==2013

replace erwerbstat_2013=1 if plb0022_h>=1 & plb0022_h<=8 & syear==2013
replace erwerbstat_2013=0 if plb0022_h==9 & syear==2013

forval i=1/5 {
	by pid: replace erwerbstat_2013=erwerbstat_2013[_n-1] if erwerbstat_2013==.
}

gen erwerbstat_2014 = erwerbstat if syear==2014

replace erwerbstat_2014=1 if plb0022_h>=1 & plb0022_h<=8 & syear==2014
replace erwerbstat_2014=0 if plb0022_h==9 & syear==2014

gen erwerbstat_2015 = erwerbstat if syear==2015

replace erwerbstat_2015=1 if plb0022_h>=1 & plb0022_h<=8 & syear==2015
replace erwerbstat_2015=0 if plb0022_h==9 & syear==2015

* Jahresspezifische Variablen: Erwerbsstatus 2016 und 2017

gen erwerbstat_2016 = erwerbstat if syear==2016

replace erwerbstat_2016=1 if plb0022_h>=1 & plb0022_h<=8 & syear==2016
replace erwerbstat_2016=0 if plb0022_h==9 & syear==2016

gen erwerbstat_2017 = erwerbstat if syear==2017

replace erwerbstat_2017=1 if plb0022_h>=1 & plb0022_h<=8 & syear==2017
replace erwerbstat_2017=0 if plb0022_h==9 & syear==2017

lab val erwerbstat_2013 erwerbstat_2014 erwerbstat_2015 erwerbstat_2016 erwerbstat_2017 erwerbstat

tab erwerbstat_2013

tab erwerbstat_2014

tab erwerbstat_2015

tab erwerbstat_2016

tab erwerbstat_2017

* Neue zeitveraenderliche, dichotomisierte Erwerbstatus erstellen aus jahresspezifischen Dummy-Variablen

gen erwerbstat_2013_2017=.

replace erwerbstat_2013_2017=erwerbstat_2013 if syear==2013

replace erwerbstat_2013_2017=erwerbstat_2014 if syear==2014

replace erwerbstat_2013_2017=erwerbstat_2015 if syear==2015

replace erwerbstat_2013_2017=erwerbstat_2016 if syear==2016

replace erwerbstat_2013_2017=erwerbstat_2017 if syear==2017

lab val erwerbstat_2013_2017 erwerbstat

* erwerbstat_2013 invertieren fuer spaetere Analysen (Erwerbstaetige als Referenz)

gen erwerbstat_2013_inv=.

replace erwerbstat_2013_inv=1 if erwerbstat_2013==0
replace erwerbstat_2013_inv=0 if erwerbstat_2013==1

lab var erwerbstat_2013_inv "Erwerbsstatus 2013 (Ref.: Erwerbstaetig)"

lab define erwerbstat_inv 1 "Erwerbslos (1)" 0 "Erwerbstaetig (0)"

lab val erwerbstat_2013_inv erwerbstat_inv

tab erwerbstat_2013_inv erwerbstat_2013

************

* Differenzscore bilden fuer erwerbstatus (22.7.2021)

gen erwerbstat_diff_help=.

by pid: replace erwerbstat_diff_help=erwerbstat_2013_2017[_n]-erwerbstat_2013_2017[_n-4]

tab erwerbstat_diff_help

tab erwerbstat_diff_help if syear==2017

* Rekodieren

gen erwerbstat_diff=.

replace erwerbstat_diff=1 if erwerbstat_diff_help==1
replace erwerbstat_diff=0 if erwerbstat_diff_help==0
replace erwerbstat_diff=2 if erwerbstat_diff_help==-1

lab define erwerbstat_diff 1 "Erwerbstaetig 2013 --> Erwerbslos 2017" 0 "Unveraendert" 2 "Erwerbslos 2013 --> Erwerbstaetig 2017"

lab val erwerbstat_diff erwerbstat_diff

tab erwerbstat_diff

tab erwerbstat_diff if syear==2017

****************************************

* Indikator fuer Rentner_innen

gen erwerbstat_rente=.

replace erwerbstat_rente=plc0232

replace erwerbstat_rente=0 if erwerbstat_rente==.

tab erwerbstat_rente

****

* Alternative Erstellung aus Angaben ueber Rentenbezuegen

gen erwerbstat_rente_alt=0

replace erwerbstat_rente_alt=1 if plc0233_h<5000000000 | plc0236_h<5000000000 | plc0240_h<5000000000 | ///
plc0242<5000000000 | plc0243_h<5000000000 | plc0245_h<5000000000 | plc0249_h<5000000000

tab erwerbstat_rente_alt

****************************************

* Sozialstrukturelle Variablen rekodieren, Differenzscores bilden usw.

* erwerbstatus arbeitslos vs. erwerbstaetig rekodieren (plb0021)

gen plb0021_rek=.

replace plb0021_rek=1 if plb0021==1

replace plb0021_rek=0 if plb0021==2

tab plb0021_rek plb0021

* Variablenlabel

lab var plb0021_rek "erwerbstatus (dichotomisiert)"

* Wertelabels

lab define erwerbstatus 1 "   Arbeitslos (1)" 0 "   Erwerbstätig (0)"

lab val plb0021_rek erwerbstatus

* erwerbstatus befristet vs. unbefristet rekodieren (plb0037_v3)

gen plb0037_v3_rek=.

replace plb0037_v3_rek=1 if plb0037_v3==2

replace plb0037_v3_rek=0 if plb0037_v3==1

tab plb0037_v3_rek plb0037_v3

* Variablenlabel

lab var plb0037_v3_rek "erwerbstatus (Ref.: Unbefristet)"

* Wertelabels

lab define befristung 1 "   Befristet (1)" 0 "   Unbefristet (0)"

lab val plb0037_v3_rek befristung

* Variable erstellen: Berufliche Stellung

gen ber_stell=.

replace ber_stell=0 if plb0057_h>=1 & plb0057_h<=6
replace ber_stell=0 if plb0059>=1 & plb0059<=3
replace ber_stell=0 if plb0060>=1 & plb0060<=3
replace ber_stell=0 if plb0061>=1 & plb0061<=3
replace ber_stell=0 if plb0586>=1 & plb0586<=4
replace ber_stell=1 if plb0065>=1 & plb0065<=4
replace ber_stell=2 if plb0064_v2>=1 & plb0064_v2<=6
replace ber_stell=3 if plb0058>=1 & plb0058<=5
replace ber_stell=4 if erwerbstat_2013==0 & syear==2013
replace ber_stell=4 if erwerbstat_2014==0 & syear==2014
replace ber_stell=4 if erwerbstat_2015==0 & syear==2015
replace ber_stell=4 if erwerbstat_2016==0 & syear==2016
replace ber_stell=4 if erwerbstat_2017==0 & syear==2017

tab ber_stell syear

lab var ber_stell "Berufliche Stellung"

lab define ber_stell 0 "Selbständige_r" 1 "Beamt_in" 2 "Angestelle_r" 3 "Arbeiter_in" 4 "Erwerbslos" 

lab val ber_stell ber_stell

* Bildungsstand (pgpsbil) dichotomisieren

gen pgpsbil_dich=.

replace pgpsbil_dich=0 if pgpsbil==3 | pgpsbil==4
replace pgpsbil_dich=1 if pgpsbil==1 | pgpsbil==2 | pgpsbil>4

tab pgpsbil_dich pgpsbil

* Variablenlabel

lab var pgpsbil_dich "Bildungsstand (Ref.: Kein Abitur od. FH-Reife)"

* Wertelabels

lab define bildungsstand 0 "   Abitur od. FH-Reife (0)" 1 "   Anderer od. kein Abschluss (1)"

lab val pgpsbil_dich bildungsstand

* Alter generieren aus Geburtsjahr (ple0010_v2) mit Bezugsjahr 2017

gen alter=.

replace alter=2013-ple0010_v2

sum alter if syear==2017

lab var alter "Alter (Jahre)"

* Zeitveraenderliche Altsersvariable

gen alter_zv=.

by pid: replace alter_zv=alter if syear==2013
by pid: replace alter_zv=alter+1 if syear==2014
by pid: replace alter_zv=alter+2 if syear==2015
by pid: replace alter_zv=alter+3 if syear==2016
by pid: replace alter_zv=alter+4 if syear==2017
by pid: replace alter_zv=alter+5 if syear==2018

lab var alter_zv "Alter (Jahre, zeitveränderlich)"

list pid syear yearcount alter alter_zv if pid==52402

list pid syear yearcount alter alter_zv if pid==31901

list pid syear yearcount alter alter_zv if pid==1501

* Geschlecht: pla0009_v2 rekodieren (1=maennlich, 0=weiblich)

gen pla0009_v2_rek=.

replace pla0009_v2_rek=1 if pla0009_v2==1

replace pla0009_v2_rek=0 if pla0009_v2==2

tab pla0009_v2_rek pla0009_v2 if syear==2017

* Variablenlabel

lab var pla0009_v2_rek "Geschlecht (Ref.: Weiblich)"

* Wertelabels

lab define geschlecht 0 "   Weiblich (0)" 1 "   Männlich (1)"

lab val pla0009_v2_rek geschlecht

* Invertieren: Intensitaet politisches Interesse (plh0007_inv)

gen plh0007_inv=.

replace plh0007_inv=0 if plh0007==4
replace plh0007_inv=1 if plh0007==3
replace plh0007_inv=2 if plh0007==2
replace plh0007_inv=3 if plh0007==1

* Variablenlabel

lab var plh0007_inv "Politisches Interesse (2013, Ref.: Keins od. schwach)"

* Wertelabels

lab def pol_int 0 "   Keins (0)" 1 "   Schwach (1)" 2 "   Stark (2)" 3 "   Sehr stark (3)"

lab val plh0007_inv pol_int

* Dichotomisieren Politisches Interesse

gen plh0007_dich=.

replace plh0007_dich=1 if plh0007_inv==3 | plh0007_inv==2
replace plh0007_dich=0 if plh0007_inv==1 | plh0007_inv==0

lab var plh0007_dich "Politisches Interesse (1=stark od. sehr stark, 0=schwach od. keins)"
lab def plh0007_dich 1"Stark od. sehr stark (1)" 0 "Schwach od. keins (0)"

lab val plh0007_dich plh0007_dich

lab var plh0007_dich "Politisches Interesse (2013, Ref.: Keins od. sehr schwach)"

* Invertieren Parteiidentifikation vorhanden:

gen plh0011_v2_inv=.

replace plh0011_v2_inv=0 if plh0011_v2==2
replace plh0011_v2_inv=1 if plh0011_v2==1

* Variablenlabel

lab var plh0011_v2_inv "Parteiidentifikation, (0=vorhanden, 1=nicht vorhanden)"

* Wertelabels

lab def pi_vorh 0 "   Vorhanden (0)" 1 "   Nicht vorhanden (1)"

lab val plh0011_v2_inv pi_vorh

* Rekodieren Intensitaet Parteiidentifikation:

gen plh0013_v2_rek=.

replace plh0013_v2_rek=4 if plh0013_v2==5
replace plh0013_v2_rek=3 if plh0013_v2==4
replace plh0013_v2_rek=2 if plh0013_v2==3
replace plh0013_v2_rek=1 if plh0013_v2==2
replace plh0013_v2_rek=0 if plh0013_v2==1

* Variablenlabel

lab var plh0013_v2_rek "Intensität Parteiidentifikation (0=sehr stark bis 4=sehr schwach)"

* Wertelabels

lab def pi_intensi_rek 4 "Sehr Schwach (4)" 3 "Schwach (3)" 2 "Mäßig (2)" 1 "Stark (1)" 0 "Sehr stark (0)"

lab val plh0013_v2_rek pi_intensi_rek

* Invertieren Intensitaet Parteiidentifikation:

gen plh0013_v2_inv=.

replace plh0013_v2_inv=0 if plh0013_v2==5
replace plh0013_v2_inv=1 if plh0013_v2==4
replace plh0013_v2_inv=2 if plh0013_v2==3
replace plh0013_v2_inv=3 if plh0013_v2==2
replace plh0013_v2_inv=4 if plh0013_v2==1

* Variablenlabel

lab var plh0013_v2_inv "Intensität Parteiidentifikation (4=sehr stark bis 0=sehr schwach)"

* Wertelabels

lab def pi_intensi 0 "Sehr Schwach (0)" 1 "Schwach (1)" 2 "Mäßig (2)" 3 "Stark (3)" 4 "Sehr stark (4)"

lab val plh0013_v2_inv pi_intensi

* Variablenlabel ostwest

lab var ostwest "Wohnort (Ref.: Westdeutschland)"

* Wertelabels ostwest

lab def ostwest 1 "   Ostdeutschland (1)" 0 "   Westdeutschland (0)", replace

lab val ostwest ostwest

****************************************

* Sorge-Variablen rekodieren, Differenzscores bilden

* Sorgen vor Zuwanderung von Migranten: plj0046 invertieren, dichotomisieren und Missings deklarieren

gen plj0046_inv=.

replace plj0046_inv=0 if plj0046==3
replace plj0046_inv=1 if plj0046==2
replace plj0046_inv=2 if plj0046==1

gen plj0046_dich=.

* Dichotomisieren

replace plj0046_dich=1 if plj0046==1

replace plj0046_dich=0 if plj0046==3 | plj0046==2

tab plj0046_dich plj0046 if syear==2017

* Variablenlabels

lab var plj0046_inv "Sorge Zuwanderung"

lab var plj0046_dich "Sorge Zuwanderung (1=viele, 0=keine od. geringe)"

* Wertelabels

lab define sorge 0 "   Keine Sorgen (0)" 1 "   Geringe Sorgen (1)" 2 "   Viele Sorgen (2)"

lab val plj0046_inv sorge

lab define sorge_dich 0 "   Keine Sorgen (0)" 1 "   Geringe od. viele Sorgen (1)"

lab val plj0046_dich sorge_dich

* Sorge vor Arbeitslosigkeit: plh0042 invertieren, neue Kategorie bilden (3=Erwerbslose) und Missings deklarieren

gen plh0042_inv=.

replace plh0042_inv=0 if plh0042==3
replace plh0042_inv=1 if plh0042==2
replace plh0042_inv=2 if plh0042==1

tab plh0042_inv

* Neue Kategorie (3) einfuegen fuer erwerbslose Personen

replace plh0042_inv=3 if erwerbstat==0

tab plh0042_inv

* Invertieren

* gen plh0042_dich=.

* replace plh0042_dich=1 if plh0042==1 | plh0042==2

* replace plh0042_dich=0 if plh0042==3

* tab plh0042_dich plh0042 if syear==2017

* Variablenlabels

lab var plh0042_inv "Sorge Arbeitslosigkeit"

* lab var plh0042_dich "Sorge Arbeitslosigkeit (1=geringe od. viele, 0=keine)"

* Wertelabels

lab define sorge_arb 0 "   Keine Sorgen (0)" 1 "   Geringe Sorgen (1)" 2 "   Viele Sorgen (2)" 3 "   Erwerbslos (3)"

lab val plh0042_inv sorge_arb

* lab val plh0042_dich sorge_dich

* Sorge um allgemeine ökonomische Entwicklung: plh0032 invertieren, dichotomisieren

gen plh0032_inv=.

replace plh0032_inv=0 if plh0032==3
replace plh0032_inv=1 if plh0032==2
replace plh0032_inv=2 if plh0032==1

gen plh0032_dich=.

replace plh0032_dich=1 if plh0032==1 | plh0032==2

replace plh0032_dich=0 if plh0032==3

tab plh0032_dich plh0032 if syear==2017

* Variablenlabels

lab var plh0032_inv "Sorge wirtschaftl. Entw."

lab var plh0032_dich "Sorge wirtschaftl. Entw. (1=geringe od. viele, 0=keine)"

* Wertelabels

lab val plh0032_inv sorge

lab val plh0032_dich sorge_dich

* Sorge um eigene wirtschaftliche Situation: plh0033 invertieren, dichotomisieren

gen plh0033_inv=.

replace plh0033_inv=0 if plh0033==3
replace plh0033_inv=1 if plh0033==2
replace plh0033_inv=2 if plh0033==1

gen plh0033_dich=.

replace plh0033_dich=1 if plh0033==1 

replace plh0033_dich=0 if plh0033==3 | plh0033==2

tab plh0033_dich plh0033 if syear==2017

* Variablenlabels

lab var plh0033_inv "Sorge wirtschaftl. Sit."

lab var plh0033_dich "Sorge wirtschaftl. Sit. (1=viele, 0=geringe od. keine)"

* Wertelabels

lab val plh0033_inv sorge

lab val plh0033_dich sorge_dich

*********************************

* Generieren: Parteispezifische Parteiidentifikation mit SPD vorhanden 2013 (plh0011_v2_spd2013)

gen plh0011_v2_spd2013=.

replace plh0011_v2_spd2013=1 if plh0012_v6==1 & plh0011_v2_inv==1 & syear==2013
replace plh0011_v2_spd2013=0 if (plh0011_v2_inv==. | plh0011_v2_inv==0) & syear==2013

tab plh0011_v2_spd2013

* Variablenlabel

lab var plh0011_v2_spd2013 "Identifikation mit SPD (2013, Ref.: Nein)"

* Wertelabels

lab def pi_partei_vorh 1 "   Vorhanden (1)" 0 "   Nicht vorhanden (0)"

lab val plh0011_v2_spd2013 pi_partei_vorh

* plh0011_v2_spd2013 zeitkonstant rekodieren

forval i=1/5 {
	by pid: replace plh0011_v2_spd2013=plh0011_v2_spd2013[_n-1] if plh0011_v2_spd2013==.
}

* Invertieren Parteiidentifikation mit SPD vorhanden 2013

gen plh0011_v2_spd2013_inv=.

replace plh0011_v2_spd2013_inv=1 if plh0011_v2_spd2013==0
replace plh0011_v2_spd2013_inv=0 if plh0011_v2_spd2013==1

lab var plh0011_v2_spd2013_inv "Identifikation mit SPD (2013, Ref.: Ja)"

* Wertelabels

lab def pi_partei_vorh_inv 0 "   Vorhanden (0)" 1 "   Nicht vorhanden (1)"

lab val plh0011_v2_spd2013_inv pi_partei_vorh_inv

tab plh0011_v2_spd2013_inv plh0011_v2_spd2013

* Generieren: Parteispezifische Parteiidentifikation mit SPD vorhanden 2017 (plh0011_v2_spd2017)

gen plh0011_v2_spd2017=.

replace plh0011_v2_spd2017=1 if plh0012_v6==1 & plh0011_v2_inv==1  & syear==2017
replace plh0011_v2_spd2017=0 if (plh0011_v2_inv==. | plh0011_v2_inv==0)  & syear==2017

tab plh0011_v2_spd2017

* plh0011_v2_spd2017 zeitkonstant rekodieren

forval i=1/5 {
	by pid: replace plh0011_v2_spd2017=plh0011_v2_spd2017[_n-1] if plh0011_v2_spd2017==.
}

forval i=1/5 {
	by pid: replace plh0011_v2_spd2017=plh0011_v2_spd2017[_n+1] if plh0011_v2_spd2017==.
}

* Variablen- und Wertelabels

lab var plh0011_v2_spd2017 "Identifikation mit SPD (2017)"

lab val plh0011_v2_spd2017 pi_partei_vorh

* Invertieren Parteiidentifikation mit SPD vorhanden 2017

gen plh0011_v2_spd2017_inv=.

replace plh0011_v2_spd2017_inv=1 if plh0011_v2_spd2017==0
replace plh0011_v2_spd2017_inv=0 if plh0011_v2_spd2017==1

lab var plh0011_v2_spd2017_inv "Identifikation mit SPD (2017, Ref.: Ja)"

lab val plh0011_v2_spd2017_inv pi_partei_vorh_inv

tab plh0011_v2_spd2017_inv plh0011_v2_spd2017

* Generieren: Intensitaet parteispezifische Parteiidentifikation mit SPD (plh0013_v2_spd)

gen plh0013_v2_spd=.

replace plh0013_v2_spd=plh0013_v2_rek if plh0012_v6==1

tab plh0013_v2_spd

* Variablenlabel

lab var plh0013_v2_spd "Intensität Identifikation SPD"

* Wertelabels

lab val plh0013_v2_spd pi_intensi_rek

* Generieren: Intensitaet parteispezifische Parteiidentifikation mit SPD in 2013 (plh0013_v2_spd2013, zeitkonstant)

gen plh0013_v2_spd2013=.


replace plh0013_v2_spd2013=plh0013_v2_rek if syear==2013 & (wechselafdvonspd_1==1 | wechselafdvonspd_1==0)

tab plh0013_v2_spd2013
sum plh0013_v2_spd2013

* Variablenlabel

lab var plh0013_v2_spd2013 "Intensität Identifikation SPD 2013 (0=sehr stark bis 4=sehr schwach)"

* Wertelabels

lab val plh0013_v2_spd2013 pi_intensi_rek

* plh0013_v2_spd2013 zeitkonstant rekodieren

by pid: replace plh0013_v2_spd2013=plh0013_v2_spd2013[_n-1] if plh0013_v2_spd2013==.

*********************************

* Generieren: Parteispezifische Parteiidentifikation mit CDUCSU vorhanden 2013 (plh0011_v2_cducsu2013)

gen plh0011_v2_cducsu2013=.

replace plh0011_v2_cducsu2013=1 if (plh0012_v6==2 | plh0012_v6==3) & plh0011_v2_inv==1 & syear==2013
replace plh0011_v2_cducsu2013=0 if (plh0011_v2_inv==. | plh0011_v2_inv==0) & syear==2013

tab plh0011_v2_cducsu2013

* plh0011_v2_cducsu2013 zeitkonstant rekodieren

forval i=1/5 {
	by pid: replace plh0011_v2_cducsu2013=plh0011_v2_cducsu2013[_n-1] if plh0011_v2_cducsu2013==.
}

* Variablen- und Wertelabels

lab var plh0011_v2_cducsu2013 "Identifikation mit CDU/CSU (2013, Ref.: Nein)"

lab val plh0011_v2_cducsu2013 pi_partei_vorh

* Invertieren Parteiidentifikation mit CDU/CSU vorhanden 2013

gen plh0011_v2_cducsu2013_inv=.

replace plh0011_v2_cducsu2013_inv=1 if plh0011_v2_cducsu2013==0
replace plh0011_v2_cducsu2013_inv=0 if plh0011_v2_cducsu2013==1

lab var plh0011_v2_cducsu2013_inv "Identifikation mit CDU/CSU (2013, Ref.: Ja)"

* Wertelabels

lab val plh0011_v2_cducsu2013_inv pi_partei_vorh_inv

tab plh0011_v2_cducsu2013_inv plh0011_v2_cducsu2013

* Generieren: Parteispezifische Parteiidentifikation mit CDUCSU vorhanden 2017 (plh0011_v2_cducsu2017)

gen plh0011_v2_cducsu2017=.

replace plh0011_v2_cducsu2017=1 if (plh0012_v6==2 | plh0012_v6==3) & plh0011_v2_inv==1  & syear==2017
replace plh0011_v2_cducsu2017=0 if (plh0011_v2_inv==. | plh0011_v2_inv==0)  & syear==2017

tab plh0011_v2_cducsu2017

* plh0011_v2_cducsu2017 zeitkonstant rekodieren

forval i=1/5 {
	by pid: replace plh0011_v2_cducsu2017=plh0011_v2_cducsu2017[_n-1] if plh0011_v2_cducsu2017==.
}

forval i=1/5 {
	by pid: replace plh0011_v2_cducsu2017=plh0011_v2_cducsu2017[_n+1] if plh0011_v2_cducsu2017==.
}

* Variablen- und Wertelabels

lab var plh0011_v2_cducsu2017 "Identifikation mit CDU/CSU (2017)"

lab val plh0011_v2_cducsu2017 pi_partei_vorh

* Invertieren Parteiidentifikation mit CDU/CSU vorhanden 2017

gen plh0011_v2_cducsu2017_inv=.

replace plh0011_v2_cducsu2017_inv=1 if plh0011_v2_cducsu2017==0
replace plh0011_v2_cducsu2017_inv=0 if plh0011_v2_cducsu2017==1

lab var plh0011_v2_cducsu2017_inv "Identifikation mit CDU/CSU (2017, Ref.: Ja)"

* Wertelabels

lab val plh0011_v2_cducsu2017_inv pi_partei_vorh_inv

tab plh0011_v2_cducsu2017_inv plh0011_v2_cducsu2017

* Generieren: Intensitaet parteispezifische Parteiidentifikation mit CDUCSU (plh0013_v2_cducsu)

gen plh0013_v2_cducsu=.

replace plh0013_v2_cducsu=plh0013_v2_rek if plh0012_v6==2 | plh0012_v6==3

tab plh0013_v2_cducsu

* Variablenlabel

lab var plh0013_v2_cducsu "Intensität Identifikation CDU/CSU (0=sehr stark bis 4=sehr schwach)"

* Wertelabels

lab val plh0013_v2_cducsu pi_intensi_rek

* Generieren: Intensitaet parteispezifische Parteiidentifikation mit CDUCSU in 2013 (plh0013_v2_cducsu2013, zeitkonstant)

gen plh0013_v2_cducsu2013=.

replace plh0013_v2_cducsu2013=plh0013_v2_rek if syear==2013 & (wechselafdvoncducsu_1==1 | wechselafdvoncducsu_1==0)

tab plh0013_v2_cducsu2013
sum plh0013_v2_cducsu2013

* plh0013_v2_cducsu2013 zeitkonstant rekodieren

by pid: replace plh0013_v2_cducsu2013=plh0013_v2_cducsu2013[_n-1] if plh0013_v2_cducsu2013==.

* Variablenlabel

lab var plh0013_v2_cducsu2013 "Intensität Identifikation CDU/CSU 2013 (0=sehr stark bis 4=sehr schwach)"

* Wertelabels

lab val plh0013_v2_cducsu2013 pi_intensi_rek

*********************************

* Differenzscores bilden bei zeitveraenderlichen UV:

* Differenzscore: Sorgen vor Zuwanderung von Migranten: plj0046_diff

sort pid syear

gen plj0046_diff=.

sum plj0046 plj0046_diff

by pid: replace plj0046_diff=plj0046_inv[_n]-plj0046_inv[_n-4]

* Variablenlabel

lab var plj0046_diff "Sorgen um Zuwanderung (Diff. 2013-2017)"

* Differenzscore rekodieren

gen plj0046_diff_hilf=plj0046_diff

replace plj0046_diff=1 if plj0046_diff_hilf==-2
replace plj0046_diff=1 if plj0046_diff_hilf==-1
replace plj0046_diff=0 if plj0046_diff_hilf==0
replace plj0046_diff=2 if plj0046_diff_hilf==1
replace plj0046_diff=2 if plj0046_diff_hilf==2

tab plj0046_diff plj0046_diff_hilf

lab def sorge_diff 1 "Verringert" 0 "Keine Veränderung" 2 "Gestiegen"

lab val plj0046_diff sorge_diff

* Wert fuer 2013: Sorgen vor Zuwanderung von Migranten: plj0046_2013

gen plj0046_2013=.

replace plj0046_2013=plj0046_inv if syear==2013

forval i=1/5 {
	by pid: replace plj0046_2013=plj0046_2013[_n-1] if plj0046_2013==.
}

* Variablenlabel

lab var plj0046_2013 "Sorgen um Zuwanderung (2013)"

* Wertelabels

lab val plj0046_2013 sorge

* Dichotomisieren: Sorgen vor Zuwanderung von Migranten 2013: plj0046_2013_dich

gen plj0046_2013_dich=.

replace plj0046_2013_dich=1 if plj0046_2013==1 | plj0046_2013==2
replace plj0046_2013_dich=0 if plj0046_2013==0

* Variablenlabel

lab var plj0046_2013_dich "Sorgen um Zuwanderung (2013, dichotomisiert)"

* Wertelabels

lab val plj0046_2013_dich sorge_dich

* Dichotomisieren: Differenzscore Sorgen vor Zuwanderung von Migranten: plj0046_diff_dich

gen plj0046_diff_dich=.

replace plj0046_diff_dich=0 if plj0046_diff==0 | plj0046_diff==1

replace plj0046_diff_dich=1 if plj0046_diff==2

lab var plj0046_diff_dich "Sorgen um Zuwanderung (Diff. 2013-2017, dichotomisiert)"

lab define sorge_diff_dich 0 "Keine Veränderung od. verringert (0)" 1 "Gestiegen (1)"

lab val plj0046_diff_dich sorge_diff_dich

* Differenzscore: Sorge vor Arbeitslosigkeit: plh0042_diff

sort pid syear

gen plh0042_diff=.

sum plh0042 plh0042_inv plh0042_diff

by pid: replace plh0042_diff=0 if plh0042_inv==3

by pid: replace plh0042_diff=plh0042_inv[_n]-plh0042_inv[_n-4] if plh0042_inv[_n]!=3

by pid: replace plh0042_diff=0 if plh0042_diff==-3

tab plh0042_inv

tab plh0042_diff

* Variablenlabel

lab var plh0042_diff "Sorgen um Arbeitslosigkeit (Diff. 2013-2017)"

* Differenzscore rekodieren

gen plh0042_diff_hilf=plh0042_diff

replace plh0042_diff=1 if plh0042_diff_hilf==-2
replace plh0042_diff=1 if plh0042_diff_hilf==-1
replace plh0042_diff=0 if plh0042_diff_hilf==0
replace plh0042_diff=2 if plh0042_diff_hilf==1
replace plh0042_diff=2 if plh0042_diff_hilf==2

tab plh0042_diff plh0042_diff_hilf

lab val plh0042_diff sorge_diff

* Wert fuer 2013: Sorgen vor Arbeitslosigkeit: plh0042_2013

gen plh0042_2013=.

replace plh0042_2013=plh0042_inv if syear==2013

forval i=1/5 {
	by pid: replace plh0042_2013=plh0042_2013[_n-1] if plh0042_2013==.
}

* Variablenlabel

lab var plh0042_2013 "Sorgen um Arbeitslosigkeit (2013)"

* Wertelabels

lab val plh0042_2013 sorge_arb

* Dichotomisieren: Sorgen vor Arbeitslosigkeit 2013: plh0042_2013_dich

gen plh0042_2013_dich=.

replace plh0042_2013_dich=0 if plh0042_2013==0 | plh0042_2013==1
replace plh0042_2013_dich=1 if plh0042_2013==2

* Variablenlabel

lab var plh0042_2013_dich "Sorgen um Arbeitslosigkeit (2013, dichotomisiert)"

* Wertelabels

lab val plh0042_2013_dich sorge_dich

* Differenzscore: Sorge um eigene wirtschaftliche Situation: plh0033_diff

sort pid syear

gen plh0033_diff=.

by pid: replace plh0033_diff=plh0033_inv[_n]-plh0033_inv[_n-4]

* Variablenlabel

lab var plh0033_diff "Sorge wirtschaftl. Sit. (Diff. 2013-2017)"

sum plh0033 plh0033_diff

* Differenzscore rekodieren

gen plh0033_diff_hilf=plh0033_diff

replace plh0033_diff=1 if plh0033_diff_hilf==-2
replace plh0033_diff=1 if plh0033_diff_hilf==-1
replace plh0033_diff=0 if plh0033_diff_hilf==0
replace plh0033_diff=2 if plh0033_diff_hilf==1
replace plh0033_diff=2 if plh0033_diff_hilf==2

tab plh0033_diff plh0033_diff_hilf

lab val plh0033_diff sorge_diff

* Dichotomisieren: Differenzscore Sorge eigene wirtschaftliche Situation: plh0033_diff_dich

gen plh0033_diff_dich=.

replace plh0033_diff_dich = 0 if plh0033_diff==0 | plh0033_diff==1

replace plh0033_diff_dich=1 if plh0033_diff==2

lab var plh0033_diff_dich "Sorgen um eigene wirtschaftliche Situation (Diff. 2013-2017, dichotomisiert)"

lab val plh0033_diff_dich sorge_diff_dich

* Wert fuer 2013: Sorge um eigene wirtschaftliche Situation: plh0033_2013

gen plh0033_2013=.

replace plh0033_2013=plh0033_inv if syear==2013

forval i=1/5 {
	by pid: replace plh0033_2013=plh0033_2013[_n-1] if plh0033_2013==.
}

* Variablenlabel

lab var plh0033_2013 "Sorge wirtschaftl. Sit. (2013)"

* Wertelabels

lab val plh0033_2013 sorge

* Differenzscore: erwerbstatus (plb0021)

sort pid syear

gen plb0021_diff=. 

by pid: replace plb0021_diff=plb0021_rek[_n]-plb0021_rek[_n-4]

* Variablenlabel

lab var plb0021_diff "erwerbstatus (Diff. 2013-2017)"

* Wert fuer 2013: erwerbstatus (plb0021)

gen plb0021_2013=.

replace plb0021_2013=plb0021_rek if syear==2013

forval i=1/5 {
	by pid: replace plb0021_2013=plb0021_2013[_n-1] if plb0021_2013==.
}

* Variablenlabel

lab var plb0021_2013 "erwerbstatus (2013)"

* Wertelabels

lab val plb0021_2013 erwerbstatus

* Differenzscore: Befristung (plb0037_v3_rek)

sort pid syear

gen plb0037_v3_diff=. 

by pid: replace plb0037_v3_diff=plb0037_v3_rek[_n]-plb0037_v3_rek[_n-4]

* Variablenlabel

lab var plb0037_v3_diff "Befristung (Diff. 2013-2017)"

* Wert fuer 2013: erwerbstatus (plb0021)

gen plb0037_v3_2013=.

replace plb0037_v3_2013=plb0037_v3_rek if syear==2013

forval i=1/5 {
	by pid: replace plb0037_v3_2013=plb0037_v3_2013[_n-1] if plb0037_v3_2013==.
}

* Variablenlabel

lab var plb0037_v3_2013 "Befristung (2013)"

* Wertelabels

lab val plb0037_v3_2013 befristung

*********************************

* Differenzscore: Politisches Interesse (plh0007)

sort pid syear

gen plh0007_diff=.

by pid: replace plh0007_diff=plh0007_dich[_n]-plh0007_dich[_n-4]

* Rekodieren: Differenzscore politisches Interesse

replace plh0007_diff=2 if plh0007_diff==1
replace plh0007_diff=1 if plh0007_diff==-1

* Wertelabel

lab def pol_int_diff 1 "Verringert" 0 "Keine Veränderung" 2 "Gestiegen"

lab val plh0007_diff pol_int_diff

* Variablenlabel

lab var plh0007_diff "Politisches Interesse (Diff. 2013-2017)"

* Wert fuer 2013: Politisches Interesse (plh0007_2013)

gen plh0007_2013=.

replace plh0007_2013=plh0007_inv if syear==2013

forval i=1/5 {
	by pid: replace plh0007_2013=plh0007_2013[_n-1] if plh0007_2013==.
}

* Variablenlabel

lab var plh0007_2013 "Politisches Interesse (2013)"

* Wertelabels

lab val plh0007_2013 pol_int

* Differenzscore: Parteiidentifikation vorhanden (plh0011_v2_diff):

sort pid syear

gen plh0011_v2_diff=.

by pid: replace plh0011_v2_diff=plh0011_v2_inv[_n]-plh0011_v2_inv[_n-4]

* Variablenlabel

lab var plh0007_diff "Parteiidentifikation (Diff. 2013-2017)"

* Differenzscore: Spezifische Parteiidentifikation mit SPD vorhanden (plh0011_v2_spd_diff):

sort pid syear

gen plh0011_v2_spd_diff=.

by pid: replace plh0011_v2_spd_diff=plh0011_v2_spd2013[_n-5]-plh0011_v2_spd2017[_n-1]

* Rekodieren:

replace plh0011_v2_spd_diff=1 if plh0011_v2_spd_diff==1
replace plh0011_v2_spd_diff=2 if plh0011_v2_spd_diff==-1

* Wertelabels

lab define plh0011_v2_spd_diff2 0 "Unveraendert" 1 "Vorhanden 2013 --> Nicht vorhanden 2017" 2 "Nicht vorhanden 2013 --> Vorhanden 2017"

lab val plh0011_v2_spd_diff plh0011_v2_spd_diff2

* Variablenlabel

lab var plh0011_v2_spd_diff "Identifikation mit SPD (Diff. 2013-2017)"

* plh0011_v2_spd_diff zeitkonstant rekodieren:

forval i=1/5 {
	by pid: replace plh0011_v2_spd_diff=plh0011_v2_spd_diff[_n+1] if plh0011_v2_spd_diff==.
}

* Differenzscore: Spezifische Parteiidentifikation mit CDU/CSU vorhanden (plh0011_v2_cducsu_diff):

sort pid syear

gen plh0011_v2_cducsu_diff=.

by pid: replace plh0011_v2_cducsu_diff=plh0011_v2_cducsu2013[_n-5]-plh0011_v2_cducsu2017[_n-1]

* Rekodieren:

replace plh0011_v2_cducsu_diff=1 if plh0011_v2_cducsu_diff==1
replace plh0011_v2_cducsu_diff=2 if plh0011_v2_cducsu_diff==-1

* Wertelabels

lab define plh0011_v2_cducsu_diff2 0 "Unveraendert" 1 "Vorhanden 2013 --> Nicht vorhanden 2017" 2 "Nicht vorhanden 2013 --> Vorhanden 2017"

lab val plh0011_v2_cducsu_diff plh0011_v2_cducsu_diff2

* Variablenlabel

lab var plh0011_v2_cducsu_diff "Identifikation mit CDU/CSU (Diff. 2013-2017)"

* plh0011_v2_cducsu_diff zeitkonstant rekodieren:

forval i=1/5 {
	by pid: replace plh0011_v2_cducsu_diff=plh0011_v2_cducsu_diff[_n+1] if plh0011_v2_cducsu_diff==.
}

* Differenzscore: Intensitaet Parteiidentifikation (plh0013_v2)

sort pid syear

gen plh0013_v2_diff=.

by pid: replace plh0013_v2_diff=plh0013_v2_inv[_n]-plh0013_v2_inv[_n-4]

* Variablenlabel

lab var plh0013_v2_diff "Intensität Parteiidentifikation (Diff. 2013-2017)"

* Differenzscore: Intensitaet parteispezifische Parteiidentifikation mit SPD (plh0013_v2_spd_diff)

sort pid syear

gen plh0013_v2_spd_diff=.

by pid: replace plh0013_v2_spd_diff=plh0013_v2_spd[_n]-plh0013_v2_spd[_n-4]

* Variablenlabel

lab var plh0013_v2_spd_diff "Intensität Parteiidentifikation mit SPD (Diff. 2013-2017)"

* Ursprungsvariable Monatlicher Nettoverdienst rekodieren (in tausend Euro)

gen plc0014_h_rek=.

replace plc0014_h_rek=plc0014_h/1000

* Wert fuer 2013: Monatlicher Nettoverdienst (plc0014_h_2013) - inklusive Reskalierung ("in tausend Euro")

gen plc0014_h_2013=.

replace plc0014_h_2013=plc0014_h/1000 if syear==2013

* Variablenlabel

lab var plc0014_h_2013 "Einkommen (2013, Euro)"

forval i=1/5 {
	by pid: replace plc0014_h_2013=plc0014_h_2013[_n-1] if plc0014_h_2013==.
}

* Variablenlabel plc0014_h (Ursprungsvariable)

lab var plc0014_h "Einkommen (harmonisiert, Euro)"

* Wert fuer 2017: Monatlicher Nettoverdienst (plc0014_h_2017) - inklusive Reskalierung ("in tausend Euro")

gen plc0014_h_2017=.

replace plc0014_h_2017=plc0014_h/1000 if syear==2017

* Variablenlabel

lab var plc0014_h_2017 "Einkommen (2017, Euro)"

forval i=1/5 {
	by pid: replace plc0014_h_2017=plc0014_h_2017[_n-1] if plc0014_h_2017==.
}


* Differenzscore: Monatlicher Nettoverdienst (plc0014_h_diff)

sort pid syear

gen plc0014_h_diff=.

by pid: replace plc0014_h_diff=plc0014_h_rek[_n]-plc0014_h_rek[_n-4]

sum plc0014_h_diff

* Variablenlabel

lab var plc0014_h_diff "Einkommen (Diff. 2013-2017)"

* Recode Monatliches Nettoaequivalenzeinkommen in 1000:

replace equiv_inc_net_l=equiv_inc_net_l/1000

sum equiv_inc_net_l

* Aequivalenzeinkommen (Netto) mit positiven Werten (fuer korrekte CI und Interaktionen spaeter)

* sum equiv_inc_net_l_diff

* replace equiv_inc_net_l_diff=equiv_inc_net_l_diff+674267.625

* sum equiv_inc_net_l_diff

* Differenzscore: Monatliches Nettoaequivalenzeinkommen (pro Kopf, Diff. 2013-2017)

sort pid syear

gen equiv_inc_net_l_diff_help=.

by pid: replace equiv_inc_net_l_diff_help=equiv_inc_net_l[_n]-equiv_inc_net_l[_n-4]

sum equiv_inc_net_l_diff_help

sum equiv_inc_net_l_diff_help if syear==2018


gen equiv_inc_net_l_diff=.

by pid: replace equiv_inc_net_l_diff=equiv_inc_net_l_diff_help[_N] if syear==2017

sum equiv_inc_net_l_diff

sum equiv_inc_net_l_diff if syear==2017

sum equiv_inc_net_l_diff if syear==2018

lab var equiv_inc_net_l_diff "Nettoaequivalenzeinkommen (Diff. 2013-2017)"



* Differenzscore: Monatliches Bruttoaequivalenzeinkommen (pro Kopf, Diff. 2013-2017)

sort pid syear

gen equiv_inc_gross_l_diff_help=.

by pid: replace equiv_inc_gross_l_diff_help=equiv_inc_gross_l[_n]-equiv_inc_gross_l[_n-4]

sum equiv_inc_gross_l_diff_help

sum equiv_inc_gross_l_diff_help if syear==2018


gen equiv_inc_gross_l_diff=.

by pid: replace equiv_inc_gross_l_diff=equiv_inc_gross_l_diff_help[_N] if syear==2017

sum equiv_inc_gross_l_diff

sum equiv_inc_gross_l_diff if syear==2017

sum equiv_inc_gross_l_diff if syear==2018

lab var equiv_inc_gross_l_diff "Bruttoaequivalenzeinkommen (Diff. 2013-2017)"

* Aequivalenzeinkommen (Brutto) mit positiven Werten (fuer korrekte CI und Interaktionen spaeter)

sum equiv_inc_gross_l_diff

replace equiv_inc_gross_l_diff=equiv_inc_gross_l_diff+1270762.25

sum equiv_inc_gross_l_diff

* Nettoaequivalenzeinkommen und Bruttoaequivalenzeinkommen in korrekte Jahre ziehen

gen equiv_inc_net_2013_corr=.

by pid: replace equiv_inc_net_2013_corr=equiv_inc_net_2013[_n+1] if syear==2013

gen equiv_inc_net_2014_corr=.

by pid: replace equiv_inc_net_2014_corr=equiv_inc_net_2014[_n+1] if syear==2014

gen equiv_inc_net_2015_corr=.

by pid: replace equiv_inc_net_2015_corr=equiv_inc_net_2015[_n+1] if syear==2015

gen equiv_inc_net_2016_corr=.

by pid: replace equiv_inc_net_2016_corr=equiv_inc_net_2016[_n+1] if syear==2016

gen equiv_inc_net_2017_corr=.

by pid: replace equiv_inc_net_2017_corr=equiv_inc_net_2017[_n+1] if syear==2017


gen equiv_inc_gross_2013_corr=.

by pid: replace equiv_inc_gross_2013_corr=equiv_inc_gross_2013[_n+1] if syear==2013

gen equiv_inc_gross_2014_corr=.

by pid: replace equiv_inc_gross_2014_corr=equiv_inc_gross_2014[_n+1] if syear==2014

gen equiv_inc_gross_2015_corr=.

by pid: replace equiv_inc_gross_2015_corr=equiv_inc_gross_2015[_n+1] if syear==2015

gen equiv_inc_gross_2016_corr=.

by pid: replace equiv_inc_gross_2016_corr=equiv_inc_gross_2016[_n+1] if syear==2016

gen equiv_inc_gross_2017_corr=.

by pid: replace equiv_inc_gross_2017_corr=equiv_inc_gross_2017[_n+1] if syear==2017

* rename

drop equiv_inc_net_2013 equiv_inc_net_2014 equiv_inc_net_2015 equiv_inc_net_2016 equiv_inc_net_2017

drop equiv_inc_gross_2013 equiv_inc_gross_2014 equiv_inc_gross_2015 equiv_inc_gross_2016 equiv_inc_gross_2017

rename equiv_inc_net_2013_corr equiv_inc_net_2013

rename equiv_inc_net_2014_corr equiv_inc_net_2014

rename equiv_inc_net_2015_corr equiv_inc_net_2015

rename equiv_inc_net_2016_corr equiv_inc_net_2016

rename equiv_inc_net_2017_corr equiv_inc_net_2017


rename equiv_inc_gross_2013_corr equiv_inc_gross_2013

rename equiv_inc_gross_2014_corr equiv_inc_gross_2014

rename equiv_inc_gross_2015_corr equiv_inc_gross_2015

rename equiv_inc_gross_2016_corr equiv_inc_gross_2016

rename equiv_inc_gross_2017_corr equiv_inc_gross_2017

* Zeilen fuer 2017 mit Werten aus 2013 fuellen (fuer spaetere Analysen)

by pid: replace equiv_inc_net_2013=equiv_inc_net_2013[_n-4] if syear==2017

by pid: replace equiv_inc_net_2014=equiv_inc_net_2014[_n-3] if syear==2017

by pid: replace equiv_inc_net_2015=equiv_inc_net_2015[_n-2] if syear==2017

by pid: replace equiv_inc_net_2016=equiv_inc_net_2016[_n-1] if syear==2017


by pid: replace equiv_inc_gross_2013=equiv_inc_gross_2013[_n-4] if syear==2017

by pid: replace equiv_inc_gross_2014=equiv_inc_gross_2014[_n-3] if syear==2017

by pid: replace equiv_inc_gross_2015=equiv_inc_gross_2015[_n-2] if syear==2017

by pid: replace equiv_inc_gross_2016=equiv_inc_gross_2016[_n-1] if syear==2017

* Umrechnen Aequivalenzeinkommen in Tausend Euro

replace equiv_inc_net_2013=equiv_inc_net_2013/1000
replace equiv_inc_net_2014=equiv_inc_net_2014/1000
replace equiv_inc_net_2015=equiv_inc_net_2015/1000
replace equiv_inc_net_2016=equiv_inc_net_2016/1000
replace equiv_inc_net_2017=equiv_inc_net_2017/1000

replace equiv_inc_gross_2013=equiv_inc_gross_2013/1000
replace equiv_inc_gross_2014=equiv_inc_gross_2014/1000
replace equiv_inc_gross_2015=equiv_inc_gross_2015/1000
replace equiv_inc_gross_2016=equiv_inc_gross_2016/1000
replace equiv_inc_gross_2017=equiv_inc_gross_2017/1000

*********************************
*********************************

* Nicht benoetigte Wellen droppen

drop if syear==2018

*********************************
*********************************

*********************************
*********************************

* Finale AV generieren fuer syear==2017

by pid: replace wechselafdvonspd_1=0 if spd2013==1

* by pid: replace wechselafdvonspd_1=1 if spd2013==0 & spdhilf==6

by pid: replace wechselafdvonspd_1=1 if afd2017==1 & spdhilf==6

tab wechselafdvonspd_1

by pid: replace wechselafdvoncducsu_1=0 if cdu_csu2013==1

* by pid: replace wechselafdvoncducsu_1=0 if cdu_csu2013==0 & cdu_csuhilf==6

by pid: replace wechselafdvoncducsu_1=1 if afd2017==1 & cdu_csuhilf==6

tab wechselafdvoncducsu_1

list pid syear yearcount spd2013 spd2017 afd2017 spdhilf wechselafdvonspd_1 if pid==52402

list pid syear yearcount spd2013 spd2017 afd2017 spdhilf wechselafdvonspd_1 if pid==31901

list pid syear yearcount spd2013 spd2017 afd2017 spdhilf wechselafdvonspd_1 if pid==1501


*********************************

* Variable generieren, die Veraenderung der AfD-Wahl misst

gen afd2013_2017=.

replace afd2013_2017=afd2013 if syear==2013
replace afd2013_2017=afd2017 if syear==2017

tab afd2013_2017

tab afd2013_2017 syear

* Verawenderung der AfD-Wahl, ohne fehlende Werte in Zwischenjahren

gen afd2013_2017_fill=afd2013_2017

replace afd2013_2017_fill=afd2013 if syear==2014
replace afd2013_2017_fill=afd2013 if syear==2015
replace afd2013_2017_fill=afd2013 if syear==2016

tab afd2013_2017_fill

tab afd2013_2017_fill syear

*********************************
*********************************

* XTSET

xtset pid syear

*********************************
*********************************

* Verwendete Variablen

* AV:

* wechselafdvonspd_1 bzw. wechselafdvoncducsu_1

* Wechsel von SPD (CDU/CSU) 2013 zu AfD 2017
* 0 = Personen, die 2013 und 2017 SPD (CDU/CSU) gewaehlt haben
* 1 = Personen, die 2013 SPD (CDU/CSU) und 2017 AfD gewaehlt haben

* UV:

* (1) plj0046_diff: Sorgen um Zuzug vor Auslaendern (Differenzscore)

* Ursprungsvariable: plj0046_inv (1=keine Sorgen, 2=geringe Sorgen, 3=große Sorgen)

* Zusaetzlich: plj0046_2013_dich: Sorgen um Zuzug vor Auslaendern (2013, 1=Sehr stark od. stark, 0=Keine)

* (2) plh0042_diff: Sorgen um Arbeitslosigkeit (Differenzscore)

* Ursprungsvariable: plh0042__inv (1=keine Sorgen, 2=geringe Sorgen, 3=große Sorgen)

* Zusaetzlich: plh0042__2013_dich: Sorgen um Arbeitslosigkeit (2013, 1=Sehr stark od. stark, 0=Keine)

* KV:

* (1) plh0013_v2_spd2013: Parteiidentifikation mit SPD vorhanden 2013 (Dummy, 1=ja, 0=nein)

* Ursprungsvariable: plh0013_v2_inv (1=sehr schwach bis 5=sehr stark, ///
* unter der Bedingung, dass 2013 SPD angegeben wurde als Parteiidentifikation)

* Anmerkung: Parteiidentifikation mit SPD wird nur als zeitkonstante Messung des Jahres 2013 ins Modell aufgenommen , denn:

* (a) Eine andere theoretische Frage ("Wandel von Parteiidentifikationen", s. z.B. Lengfeld 2017)

* (b) Gefahr eines Overcontrol Bias (Elwert/Winship 2014) bzw. Post-Treatment Bias (Montgomery et al. 2018), denn KV "Differenzscore Parteiidentifikation" kann ebenso ein Kriterium von "Sorgen um Zuwanderung" und "Sorgen um Arbeitsplatz" sein wie "Wahlentscheidung" - zudem kann "Differenzscore Parteiidentifikation" ein Kriterium sein von "Wahlentscheidung"

* Aufgrund von Missing Data-Problemen wird auf Verwendung der Intensitaet der spezifischen Parteiidentifikation verzichtet:

* Beispiel - SPD:

tab wechselafdvonspd_1 plh0013_v2_spd2013 if syear==2017

mdesc plh0013_v2_spd2013 if plh0012_v6==1 & wechselafdvonspd_1!=.

* (2) plh0007_2013: Intensitaet politisches Interesse (2013)

* Ursprungsvariable: plh0007_inv (1=Sehr stark od. stark, 0=Nicht so stark)

* (3) plc0014_h_2013: Monatliches Nettoeinkommen (2013, Euro)

* Ursprungsvariable: plc0014_h

* (4) plc0014_h_diff: Monatliches Nettoeinkommen (Differenzscore, Euro)

* Ursprungsvariable: plc0014_h

* (5) pgpsbil_dich: Hoechster Schulabschluss (Dummy, 0=Andere bzw. keine, 1=Abitur oder FH-Reife)

* (6) pla0009_v2_rek: Geschlecht (Dummy, (0=weiblich, 1=maennlich)

* (7) alter: Alter (zeitveraenderlich)

* (8)) ostwest: Wohnort (0=Westdeutschland, 1=Ostdeutschland)

* NICHT ueberprueft / beinhaltet, da zu geringes n:

* erwerbstatus (plb0021)

tab plb0021_2013 ///
if wechselafdvonspd_1!=.& plj0046_diff!=. & plh0042_diff!=. & ///
plh0011_v2_spd2013!=. & plh0007_2013!=. & plc0014_h_diff!=. & pgpsbil_dich!=. & pla0009_v2_rek!=. & alter!=. & ostwest!=. & syear==2017

sum plb0021_diff ///
if wechselafdvonspd_1!=.& plj0046_diff!=. & plh0042_diff!=. & ///
plh0011_v2_spd2013!=. & plh0007_2013!=. & plc0014_h_diff!=. & pgpsbil_dich!=. & pla0009_v2_rek!=. & alter!=. & ostwest!=. & syear==2017

* Befristungsstatus (plb)

tab plb0037_v3_2013 ///
if wechselafdvonspd_1!=.& plj0046_diff!=. & plh0042_diff!=. & ///
plh0011_v2_spd2013!=. & plh0007_2013!=. & plc0014_h_diff!=. & pgpsbil_dich!=. & pla0009_v2_rek!=. & alter!=. & ostwest!=. & syear==2017

sum plb0037_v3_diff ///
if wechselafdvonspd_1!=.& plj0046_diff!=. & plh0042_diff!=. & ///
plh0011_v2_spd2013!=. & plh0007_2013!=. & plc0014_h_diff!=. & pgpsbil_dich!=. & pla0009_v2_rek!=. & alter!=. & ostwest!=. & syear==2017

*********************************
*********************************

* Voranalysen

*********************************
*********************************

*Bivariate Analysen fuer Fallzahlanalysen

* CDU/CSU

tab wechselafdvoncducsu_1 ///
if !missing(wechselafdvoncducsu_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_cducsu2013, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

* Ost/West

tab wechselafdvoncducsu_1 ostwest ///
if !missing(wechselafdvoncducsu_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_cducsu2013, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

* Geschlecht

tab wechselafdvoncducsu_1 pla0009_v2_rek ///
if !missing(wechselafdvoncducsu_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_cducsu2013, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

**********************************************

* SPD:

tab wechselafdvonspd_1 ///
if !missing(wechselafdvonspd_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, erwerbstat_2013_inv, ///
plh0011_v2_spd2013, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

* Ost/West

tab wechselafdvonspd_1 ostwest ///
if !missing(wechselafdvonspd_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, erwerbstat_2013_inv, ///
plh0011_v2_spd2013, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

* Geschlecht:

tab wechselafdvonspd_1 pla0009_v2_rek ///
if !missing(wechselafdvonspd_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, erwerbstat_2013_inv, ///
plh0011_v2_spd2013, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

*********************************
*********************************

* HAUPTANALYSEN

*********************************
*********************************

* log using "E:\Projekte+Ideen_laufend\2003-Wählerwanderung\Stata Logfiles\210728-Hauefigkeiten_cducsu", replace

* Deskriptive Statistiken - Haeufigkeiten

* CDU/CSU

tab wechselafdvoncducsu_1 ///
if !missing(wechselafdvoncducsu_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_cducsu2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

tab plj0046_2013 ///
if !missing(wechselafdvoncducsu_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_cducsu2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

tab plj0046_diff_dich ///
if !missing(wechselafdvoncducsu_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_cducsu2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

tab plh0033_2013 ///
if !missing(wechselafdvoncducsu_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_cducsu2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

tab plh0033_diff_dich ///
if !missing(wechselafdvoncducsu_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_cducsu2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

* Aequivalenzeinkommen

tab erwerbstat_2013_inv ///
if !missing(wechselafdvoncducsu_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_cducsu2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

tab plh0011_v2_cducsu2013_inv ///
if !missing(wechselafdvoncducsu_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_cducsu2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

tab pgpsbil_dich ///
if !missing(wechselafdvoncducsu_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_cducsu2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

tab ostwest ///
if !missing(wechselafdvoncducsu_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_cducsu2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

tab pla0009_v2_rek ///
if !missing(wechselafdvoncducsu_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_cducsu2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

* Alter

*******

* Hauefigkeiten Erwerbsstatus

tab plb0022_h ///
if !missing(wechselafdvoncducsu_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_cducsu2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017


*******

* Mittelwerte:

sum equiv_inc_net_l alter ///
if !missing(wechselafdvoncducsu_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_cducsu2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

*******

* Mittelwerte zentrieren (fuer CDU/CSU-Waehlende)

* Nettoaequivalenzeinkommen

sum equiv_inc_net_l ///
if !missing(wechselafdvoncducsu_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_cducsu2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

gen equiv_inc_net_l_cducsu=.

replace equiv_inc_net_l_cducsu = equiv_inc_net_l-r(mean) ///
if !missing(wechselafdvoncducsu_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_cducsu2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

sum equiv_inc_net_l_cducsu ///
if !missing(wechselafdvoncducsu_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_cducsu2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

sum equiv_inc_net_l_cducsu

* Veraenderung Nettoaequivalenzeinkommen CDU/CSU

gen equiv_inc_net_l_diff_cducsu=.

replace equiv_inc_net_l_diff_cducsu=equiv_inc_net_l_diff-r(mean) ///
if !missing(wechselafdvoncducsu_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_cducsu2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

sum equiv_inc_net_l_diff_cducsu

* Intensitaet Parteiidentifikation mit CDU/CSU

sum plh0013_v2_cducsu2013 ///
if !missing(wechselafdvoncducsu_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_cducsu2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

gen plh0013_v2_cducsu2013_z=.

replace plh0013_v2_cducsu2013_z=plh0013_v2_cducsu2013-r(mean) ///
if !missing(wechselafdvoncducsu_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_cducsu2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

sum plh0013_v2_cducsu2013_z

* Alter

sum alter ///
if !missing(wechselafdvoncducsu_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_cducsu2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

gen alter_cducsu=.

replace alter_cducsu = alter-r(mean) ///
if !missing(wechselafdvoncducsu_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_cducsu2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

sum alter_cducsu

*******

* Mittelwerte

* Nettoaequivalenzeinkommen (2013), Veraenderung Nettoaequivalenzeinkommen (2013 bis 2017), Alter

sum equiv_inc_net_l_cducsu equiv_inc_net_l_diff_cducsu alter_cducsu ///
if !missing(wechselafdvoncducsu_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l_cducsu, equiv_inc_net_l_diff_cducsu, ///
plh0011_v2_cducsu2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter_cducsu) & syear==2017

**

* Problem: Keine Personen in Kategorie Erwerbstaetig 2013 --> Erwerbslos 2013 bei CDU/CSU-Waehler_innen

tab wechselafdvoncducsu_1 erwerbstat_diff ///
if !missing(wechselafdvoncducsu_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_cducsu2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017, ///
row

* Anzahl Rentner_innen unter CDU/CSU-Waehler_innen 2013:

tab erwerbstat_rente ///
if !missing(wechselafdvoncducsu_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_cducsu2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

************************************

* SPD:

* Deskriptive Statistiken - Haeufigkeiten

* SPD

tab wechselafdvonspd_1 ///
if !missing(wechselafdvonspd_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_spd2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

tab plj0046_2013 ///
if !missing(wechselafdvonspd_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_spd2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

tab plj0046_diff_dich ///
if !missing(wechselafdvonspd_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_spd2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

tab plh0033_2013 ///
if !missing(wechselafdvonspd_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_spd2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

tab plh0033_diff_dich ///
if !missing(wechselafdvonspd_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_spd2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

* Aequivalenzeinkommen

tab erwerbstat_2013_inv ///
if !missing(wechselafdvonspd_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_spd2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

tab plh0011_v2_spd2013_inv ///
if !missing(wechselafdvonspd_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_spd2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

tab pgpsbil_dich ///
if !missing(wechselafdvonspd_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_spd2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

tab ostwest ///
if !missing(wechselafdvonspd_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_spd2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

tab pla0009_v2_rek ///
if !missing(wechselafdvonspd_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_spd2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

* Alter

*******

* Mittelwerte:

sum equiv_inc_net_l equiv_inc_net_l_diff alter ///
if !missing(wechselafdvonspd_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_spd2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

*****

* Mittelwerte zentrieren (fuer SPD-Waehlende)

* Nettoaequivalenzeinkommen

sum equiv_inc_net_l ///
if !missing(wechselafdvonspd_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_spd2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

gen equiv_inc_net_l_spd=.

replace equiv_inc_net_l_spd = equiv_inc_net_l-r(mean) ///
if !missing(wechselafdvonspd_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_spd2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

sum equiv_inc_net_l_spd ///
if !missing(wechselafdvonspd_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_spd2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

* Veraenderung Nettoaequivalenzeinkommen SPD

gen equiv_inc_net_l_diff_spd=.

replace equiv_inc_net_l_diff_spd=equiv_inc_net_l_diff-r(mean) ///
if !missing(wechselafdvonspd_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_spd2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

* Intensitaet Parteiidentifikation mit SPD

sum plh0013_v2_spd2013 ///
if !missing(wechselafdvonspd_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_spd2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

gen plh0013_v2_spd2013_z=.

replace plh0013_v2_spd2013_z=plh0013_v2_spd2013-r(mean) ///
if !missing(wechselafdvonspd_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_spd2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

sum plh0013_v2_spd2013_z

* Alter

sum alter ///
if !missing(wechselafdvonspd_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_spd2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

gen alter_spd=.

replace alter_spd = alter-r(mean) ///
if !missing(wechselafdvonspd_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_spd2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

sum alter_spd

*******

* Mittelwerte

* Nettoaequivalenzeinkommen (2013), Veraenderung Nettoaequivalenzeinkommen (2013 bis 2017), Alter

sum equiv_inc_net_l_spd equiv_inc_net_l_diff_spd alter_spd ///
if !missing(wechselafdvonspd_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l_spd, equiv_inc_net_l_diff_spd, ///
plh0011_v2_spd2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter_spd) & syear==2017

*******

* Problem: Wenige Personen in Kategorie Erwerbstaetig 2013 --> Erwerbslos 2013 bei SPD-Waehler_innen

tab wechselafdvonspd_1 erwerbstat_diff ///
if !missing(wechselafdvonspd_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_spd2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017, ///
row

**

* Anzahl Rentner_innen unter SPD-Waehler_innen 2013:

tab erwerbstat_rente ///
if !missing(wechselafdvonspd_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_spd2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017, ///

* Longitudinal weight:

* [pw=w11103]

********************************************
********************************************

* Im Anhang auffuehren (wg. Dokumentation moeglicher geringer Zellenbesetzungen)

* Gruppenspezfisiche Deskriptionen fuer Wechsler_innen

* CDU/CSU:

tab plj0046_2013 ///
if !missing(wechselafdvoncducsu_1, plj0046_2013, plj0046_diff, plh0033_2013, plh0033_diff, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_cducsu2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017 & ///
wechselafdvoncducsu_1==1

tab plj0046_diff ///
if !missing(wechselafdvoncducsu_1, plj0046_2013, plj0046_diff, plh0033_2013, plh0033_diff, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_cducsu2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017 & ///
wechselafdvoncducsu_1==1

tab plh0033_2013 ///
if !missing(wechselafdvoncducsu_1, plj0046_2013, plj0046_diff, plh0033_2013, plh0033_diff, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_cducsu2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017 & ///
wechselafdvoncducsu_1==1

tab plh0033_diff ///
if !missing(wechselafdvoncducsu_1, plj0046_2013, plj0046_diff, plh0033_2013, plh0033_diff, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_cducsu2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017 & ///
wechselafdvoncducsu_1==1

* Aequivalenzeinkommen

tab erwerbstat_2013_inv ///
if !missing(wechselafdvoncducsu_1, plj0046_2013, plj0046_diff, plh0033_2013, plh0033_diff, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_cducsu2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017 & ///
wechselafdvoncducsu_1==1

tab erwerbstat_diff ///
if !missing(wechselafdvoncducsu_1, plj0046_2013, plj0046_diff, plh0033_2013, plh0033_diff, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_cducsu2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017 & ///
wechselafdvoncducsu_1==1

tab plh0011_v2_cducsu2013_inv ///
if !missing(wechselafdvoncducsu_1, plj0046_2013, plj0046_diff, plh0033_2013, plh0033_diff, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_cducsu2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017 & ///
wechselafdvoncducsu_1==1

tab pgpsbil_dich ///
if !missing(wechselafdvoncducsu_1, plj0046_2013, plj0046_diff, plh0033_2013, plh0033_diff, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_cducsu2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017 & ///
wechselafdvoncducsu_1==1

tab ostwest ///
if !missing(wechselafdvoncducsu_1, plj0046_2013, plj0046_diff, plh0033_2013, plh0033_diff, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_cducsu2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017 & ///
wechselafdvoncducsu_1==1

tab pla0009_v2_rek ///
if !missing(wechselafdvoncducsu_1, plj0046_2013, plj0046_diff, plh0033_2013, plh0033_diff, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_cducsu2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017 & ///
wechselafdvoncducsu_1==1

* Alter

***

* Mittelwerte

* Nettoaequivalenzeinkommen (2013), Veraenderung Nettoaequivalenzeinkommen (2013 bis 2017), Alter

sum equiv_inc_net_l equiv_inc_net_l_diff alter ///
if !missing(wechselafdvoncducsu_1, plj0046_2013, plj0046_diff, plh0033_2013, plh0033_diff, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_cducsu2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017 & ///
wechselafdvoncducsu_1==1

********************

* SPD:

tab plj0046_2013 ///
if !missing(wechselafdvonspd_1, plj0046_2013, plj0046_diff, plh0033_2013, plh0033_diff, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_spd2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017 & ///
wechselafdvonspd_1==1

tab plj0046_diff ///
if !missing(wechselafdvonspd_1, plj0046_2013, plj0046_diff, plh0033_2013, plh0033_diff, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_spd2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017 & ///
wechselafdvonspd_1==1

tab plh0033_2013 ///
if !missing(wechselafdvonspd_1, plj0046_2013, plj0046_diff, plh0033_2013, plh0033_diff, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_spd2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017 & ///
wechselafdvonspd_1==1

tab plh0033_diff ///
if !missing(wechselafdvonspd_1, plj0046_2013, plj0046_diff, plh0033_2013, plh0033_diff, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_spd2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017 & ///
wechselafdvonspd_1==1

* Aequivalenzeinkommen

tab erwerbstat_2013_inv ///
if !missing(wechselafdvonspd_1, plj0046_2013, plj0046_diff, plh0033_2013, plh0033_diff, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_spd2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017 & ///
wechselafdvonspd_1==1

tab erwerbstat_diff ///
if !missing(wechselafdvonspd_1, plj0046_2013, plj0046_diff, plh0033_2013, plh0033_diff, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_spd2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017 & ///
wechselafdvonspd_1==1

tab plh0011_v2_spd2013_inv ///
if !missing(wechselafdvonspd_1, plj0046_2013, plj0046_diff, plh0033_2013, plh0033_diff, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_spd2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017 & ///
wechselafdvonspd_1==1

tab pgpsbil_dich ///
if !missing(wechselafdvonspd_1, plj0046_2013, plj0046_diff, plh0033_2013, plh0033_diff, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_spd2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017 & ///
wechselafdvonspd_1==1

tab ostwest ///
if !missing(wechselafdvonspd_1, plj0046_2013, plj0046_diff, plh0033_2013, plh0033_diff, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_spd2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017 & ///
wechselafdvonspd_1==1

tab pla0009_v2_rek ///
if !missing(wechselafdvonspd_1, plj0046_2013, plj0046_diff, plh0033_2013, plh0033_diff, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_spd2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017 & ///
wechselafdvonspd_1==1

* Alter

***

* Mittelwerte

* Nettoaequivalenzeinkommen (2013), Veraenderung Nettoaequivalenzeinkommen (2013 bis 2017), Alter

sum equiv_inc_net_l equiv_inc_net_l_diff alter ///
if !missing(wechselafdvonspd_1, plj0046_2013, plj0046_diff, plh0033_2013, plh0033_diff, ///
equiv_inc_net_l_spd, equiv_inc_net_l_diff_spd, ///
plh0011_v2_spd2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter_spd) & syear==2017 & ///
wechselafdvonspd_1==1

******************
******************
******************
******************

* MULTIVARIATE ANALYSEN

* Logistische Regression CDU/CSU (Tabelle 1):

* (1) UV: Sorge um Zuzug, ohne Kontrollvariablen

logit wechselafdvoncducsu_1 ib0.plj0046_2013 ib0.plj0046_diff_dich ///
if !missing(wechselafdvoncducsu_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l_cducsu, equiv_inc_net_l_diff_cducsu, erwerbstat_2013_inv, ///
plh0011_v2_cducsu2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter_cducsu) & syear==2017

* Information criteria:

estat ic

* Average Marginal Effects:

eststo A: margins, dydx (_all) post

* (2) UV: Sorge um eigene wirtschaftliche Lage, ohne Kontrollvariablen

logit wechselafdvoncducsu_1 ib0.plh0033_2013 ib0.plh0033_diff_dich ///
if !missing(wechselafdvoncducsu_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l_cducsu, equiv_inc_net_l_diff_cducsu, erwerbstat_2013_inv, ///
plh0011_v2_cducsu2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter_cducsu) & syear==2017

* Information criteria:

estat ic

* Average Marginal Effects:

eststo B: margins, dydx (_all) post

* (3) UV: Einkommen, ohne Kontrollvariablen

logit wechselafdvoncducsu_1 equiv_inc_net_l_cducsu equiv_inc_net_l_diff_cducsu ///
if !missing(wechselafdvoncducsu_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l_cducsu, equiv_inc_net_l_diff_cducsu, erwerbstat_2013_inv, ///
plh0011_v2_cducsu2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter_cducsu) & syear==2017

* Information criteria:

estat ic

* Average Marginal Effects:

eststo C: margins, dydx (_all) post

****

* Korrelation Einkommen und Sorge um eigene wirtschaftliche Lage (CDU/CSU)

pwcorr equiv_inc_net_l_cducsu plh0033_2013 ///
if !missing(wechselafdvoncducsu_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l_cducsu, equiv_inc_net_l_diff_cducsu, erwerbstat_2013_inv, ///
plh0011_v2_cducsu2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter_cducsu) & syear==2017, ///
sig

****

* (4) Mit Kontrollvariablen

logit wechselafdvoncducsu_1 ib0.plj0046_2013 ib0.plj0046_diff_dich ib0.plh0033_2013 ib0.plh0033_diff_dich ///
equiv_inc_net_l_cducsu equiv_inc_net_l_diff_cducsu ib0.erwerbstat_2013_inv ///
ib0.plh0011_v2_cducsu2013_inv ib0.pgpsbil_dich ib0.ostwest ib0.pla0009_v2_rek alter_cducsu ///
if !missing(wechselafdvoncducsu_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l_cducsu, equiv_inc_net_l_diff_cducsu, erwerbstat_2013_inv, ///
plh0011_v2_cducsu2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter_cducsu) & syear==2017

* Information criteria:

estat ic

* Average Marginal Effects:

eststo D: margins, dydx (_all) post

*** Fuer Output in Word ***

esttab A B C D using "E:\Projekte+Ideen_laufend\2003-Wählerwanderung\Stata Tables\220704_ame_cducsu_neu.rtf", replace ///
title({Tabelle 2:} {Wanderung von der CDU/CSU zur AfD}) ///
nonumbers mtitles("Modell 1" "Modell 2" "Modell 3" "Modell 4") label ///
cells("b (star fmt(3) label(AME)) se(par fmt(2) label(SE)) p(fmt(3) label(p))") starlevels(+ 0.10 * 0.05 ** 0.01 *** 0.001) dmarker(,) ///
stats(n pr2 aic bic, fmt(0 2 4 4) labels("n" "Pseudo R^2" "AIC" "BIC")) constant ///
nonotes addnote("Quelle: SOEP 2013 und 2017. Logistische Regression mit durchschnittlichen marginalen Effekten." ///
"AME = Durchschnittl. marginaler Effekt, SE = Standardfehler, p = empirische Signifikanz") legend scalars(n pr2 aic bic) ///
fonttbl(\f0\fnil arial; ) nogaps compress

******************************************************

* Stepwise Modelle erstellen, um moeglichen Post-Treatment-Bias aufzudecken

* Logistische Regression SPD (Tabelle 2):

* (1) UV: Sorge um Zuzug, ohne Kontrollvariablen

logit wechselafdvonspd_1 ib0.plj0046_2013 ib0.plj0046_diff_dich ///
if !missing(wechselafdvonspd_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l_spd, equiv_inc_net_l_diff_spd, erwerbstat_2013_inv, ///
plh0011_v2_spd2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter_spd) & syear==2017

* Information criteria:

estat ic

* Average Marginal Effects:

eststo E: margins, dydx (_all) post

* (2) UV: Sorge um eigene wirtschaftliche Lage, ohne Kontrollvariablen

logit wechselafdvonspd_1 ib0.plh0033_2013 ib0.plh0033_diff_dich ///
if !missing(wechselafdvonspd_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l_spd, equiv_inc_net_l_diff_spd, erwerbstat_2013_inv, ///
plh0011_v2_spd2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter_spd) & syear==2017

* Information criteria:

estat ic

* Average Marginal Effects:

eststo F: margins, dydx (_all) post

* (3) UV: Einkommen, ohne Kontrollvariablen

logit wechselafdvonspd_1 equiv_inc_net_l_spd equiv_inc_net_l_diff_spd ///
if !missing(wechselafdvonspd_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l_spd, equiv_inc_net_l_diff_spd, erwerbstat_2013_inv, ///
plh0011_v2_spd2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter_spd) & syear==2017

* Information criteria:

estat ic

* Average Marginal Effects:

eststo G: margins, dydx (_all) post

****

* Korrelation Einkommen und Sorge um eigene wirtschaftliche Lage (SPD)

pwcorr equiv_inc_net_l_spd plh0033_2013 ///
if !missing(wechselafdvonspd_1, plj0046_2013, plj0046_diff_dich,plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l_spd, equiv_inc_net_l_diff_spd, erwerbstat_2013_inv, ///
plh0011_v2_spd2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter_spd) & syear==2017, ///
sig

****

* (4) Mit Kontrollvariablen

logit wechselafdvonspd_1 ib0.plj0046_2013 ib0.plj0046_diff_dich ib0.plh0033_2013 ib0.plh0033_diff_dich ///
equiv_inc_net_l_spd equiv_inc_net_l_diff_spd ib0.erwerbstat_2013_inv ///
ib0.plh0011_v2_spd2013_inv ib0.pgpsbil_dich ib0.ostwest ib0.pla0009_v2_rek alter_spd ///
if !missing(wechselafdvonspd_1, plj0046_2013, plj0046_diff_dich,plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l_spd, equiv_inc_net_l_diff_spd, erwerbstat_2013_inv, ///
plh0011_v2_spd2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter_spd) & syear==2017

* Information criteria:

estat ic

* Average Marginal Effects:

eststo H: margins, dydx (_all) post

*** Fuer Output in Word ***

esttab E F G H using "E:\Projekte+Ideen_laufend\2003-Wählerwanderung\Stata Tables\220704_ame_spd_neu.rtf", replace ///
title({Tabelle 2:} {Wanderung von der SPD zur AfD}) ///
nonumbers mtitles("Modell 1" "Modell 2" "Modell 3" "Modell 4") label ///
cells("b (star fmt(3) label(AME)) se(par fmt(2) label(SE)) p(fmt(3) label(p))") starlevels(+ 0.10 * 0.05 ** 0.01 *** 0.001) dmarker(,) ///
stats(n pr2 aic bic, fmt(0 2 4 4) labels("n" "Pseudo R^2" "AIC" "BIC")) constant ///
nonotes addnote("Quelle: SOEP 2013 und 2017. Logistische Regression mit durchschnittlichen marginalen Effekten." ///
"AME = Durchschnittl. marginaler Effekt, SE = Standardfehler, p = empirische Signifikanz") legend scalars(n pr2 aic bic) ///
fonttbl(\f0\fnil arial; ) nogaps compress

estat clear

******************************************************

*** Alternative Modellierung: multinomiale AV (Robustheitsanalysen)

* Mittelwerte zentrieren fuer multinomiales Modell

* Nettoaequivalenzeinkommen

sum equiv_inc_net_l ///
if !missing(wanderung2017) & syear==2017

gen equiv_inc_net_l_wanderung2017=.

replace equiv_inc_net_l_wanderung2017 = equiv_inc_net_l-r(mean) ///
if !missing(wanderung2017) & syear==2017

sum equiv_inc_net_l_wanderung2017

* Veraenderung Nettoaequivalenzeinkommen

gen equiv_inc_net_l_diff_wander2017=.

replace equiv_inc_net_l_diff_wander2017=equiv_inc_net_l_diff-r(mean) ///
if !missing(wanderung2017) & syear==2017

sum equiv_inc_net_l_diff_wander2017

* Alter

sum alter ///
if !missing(wanderung2017) & syear==2017

gen alter_wanderung2017=.

replace alter_wanderung2017 = alter-r(mean) ///
if !missing(wanderung2017) & syear==2017

sum alter_wanderung2017

***

* Multinomiale Regression Wanderung 2017 (Robustheitsanalysen, Tabelle A2 im Online-Supplement)

* Fallzahlen AV:

tab wanderung2017 ///
if !missing(wanderung2017, plj0046_2013, plj0046_diff_dich,plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l_wanderung2017, equiv_inc_net_l_diff_wander2017, erwerbstat_2013_inv, ///
pgpsbil_dich, ostwest, pla0009_v2_rek, alter_wanderung2017) & syear==2017

* FDP:

tab wechselafdvonfdp_1 ///
if !missing(wanderung2017, plj0046_2013, plj0046_diff_dich,plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l_wanderung2017, equiv_inc_net_l_diff_wander2017, erwerbstat_2013_inv, ///
pgpsbil_dich, ostwest, pla0009_v2_rek, alter_wanderung2017) & syear==2017

* Gruene:

tab wechselafdvongruene_1 ///
if !missing(wanderung2017, plj0046_2013, plj0046_diff_dich,plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l_wanderung2017, equiv_inc_net_l_diff_wander2017, erwerbstat_2013_inv, ///
pgpsbil_dich, ostwest, pla0009_v2_rek, alter_wanderung2017) & syear==2017

* Linke:

tab wechselafdvonlinke_1 ///
if !missing(wanderung2017, plj0046_2013, plj0046_diff_dich,plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l_wanderung2017, equiv_inc_net_l_diff_wander2017, erwerbstat_2013_inv, ///
pgpsbil_dich, ostwest, pla0009_v2_rek, alter_wanderung2017) & syear==2017

* Outcome 0: Personen, die zwischen 2013 und 2017 bei der 2013 gewaehlten Partei bleiben

* Outcome: Wechsel von CDU/CSU 2013 zu AfD 2017

mlogit wanderung2017 ib0.plj0046_2013 ib0.plj0046_diff_dich ib0.plh0033_2013 ib0.plh0033_diff_dich ///
equiv_inc_net_l_wanderung2017 equiv_inc_net_l_diff_wander2017 ib0.erwerbstat_2013_inv ///
ib0.pgpsbil_dich ib0.ostwest ib0.pla0009_v2_rek alter_wanderung2017 ///
if !missing(wanderung2017, plj0046_2013, plj0046_diff_dich,plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l_wanderung2017, equiv_inc_net_l_diff_wander2017, erwerbstat_2013_inv, ///
pgpsbil_dich, ostwest, pla0009_v2_rek, alter_wanderung2017) & syear==2017

eststo I: margins, dydx (*) predict (pr outcome(1)) post

* Outcome: Wechsel von SPD 2013 zu AfD 2017

mlogit wanderung2017 ib0.plj0046_2013 ib0.plj0046_diff_dich ib0.plh0033_2013 ib0.plh0033_diff_dich ///
equiv_inc_net_l_wanderung2017 equiv_inc_net_l_diff_wander2017 ib0.erwerbstat_2013_inv ///
ib0.pgpsbil_dich ib0.ostwest ib0.pla0009_v2_rek alter_wanderung2017 ///
if !missing(wanderung2017, plj0046_2013, plj0046_diff_dich,plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l_wanderung2017, equiv_inc_net_l_diff_wander2017, erwerbstat_2013_inv, ///
pgpsbil_dich, ostwest, pla0009_v2_rek, alter_wanderung2017) & syear==2017

eststo J: margins, dydx (*) predict (pr outcome (2)) post

* Outcome: Wechsel von Gruene, Linke oder FDP 2013 zu AfD 2017

mlogit wanderung2017 ib0.plj0046_2013 ib0.plj0046_diff_dich ib0.plh0033_2013 ib0.plh0033_diff_dich ///
equiv_inc_net_l_wanderung2017 equiv_inc_net_l_diff_wander2017 ib0.erwerbstat_2013_inv ///
ib0.pgpsbil_dich ib0.ostwest ib0.pla0009_v2_rek alter_wanderung2017 ///
if !missing(wanderung2017, plj0046_2013, plj0046_diff_dich,plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l_wanderung2017, equiv_inc_net_l_diff_wander2017, erwerbstat_2013_inv, ///
pgpsbil_dich, ostwest, pla0009_v2_rek, alter_wanderung2017) & syear==2017

eststo K: margins, dydx (*) predict (pr outcome (3)) post

esttab I J K using "E:\Projekte+Ideen_laufend\2003-Wählerwanderung\Stata Tables\220704_ame_mlogit_modell.rtf", replace ///
title({Tabelle xy:} {Wanderung von der CDU/CSU, SPD oder anderen Parteien zur AfD}) ///
nonumbers mtitles("Modell 1") label ///
cells("b (star fmt(3) label(AME)) se(par fmt(2) label(SE)) p(fmt(3) label(p))") starlevels(+ 0.10 * 0.05 ** 0.01 *** 0.001) dmarker(,) ///
stats(n pr2 aic bic, fmt(0 2 4 4) labels("n" "Pseudo R^2" "AIC" "BIC")) constant ///
nonotes addnote("Quelle: SOEP 2013 und 2017. Multinomiale logistische Regression mit durchschnittlichen marginalen Effekten." ///
"Referenzkategorie: Verbleiben bei der 2013 gewählten Partei." ///
"AME = Durchschnittl. marginaler Effekt, SE = Standardfehler, p = empirische Signifikanz") legend scalars(n pr2 aic bic) ///
fonttbl(\f0\fnil arial; ) nogaps compress

***

* Wanderungsmodell fuer Sample bestehend aus Personen, die 2013 und 2017 die AfD waehlten (= 0), und jenen, die 2017 von der CDU/CSU bzw. der SPD der AfD zuwanderten (= 1)

* Zusatzanalysen fuer Gutachterbericht, nicht abgebildet und berichtet

* Erstellen: AV Wechsel zur AfD 2017 von CDU/CSU 2013

gen wechsel_zu_afd2017_von_cducsu=.

lab var wechsel_zu_afd2017_von_cducsu "Wechsel zur AfD 2017 von CDU/CSU 2013"

lab define wechsel_zu_afd2017_von_cducsu 0 "AfD gewaehlt 2013 und 2017" 1 "Zuwanderung zur AfD 2017 von CDU/CSU 2013"

lab val wechsel_zu_afd2017_von_cducsu wechsel_zu_afd2017_von_cducsu

replace wechsel_zu_afd2017_von_cducsu=0 if afd2013==1 & afd2017==1

replace wechsel_zu_afd2017_von_cducsu=1 if cdu_csu2013==1 & afd2017==1

tab wechsel_zu_afd2017_von_cducsu

tab wechsel_zu_afd2017_von_cducsu if syear==2017

* Erstellen: AV Wechsel zur AfD 2017 von SPD 2013

gen wechsel_zu_afd2017_von_spd=.

lab var wechsel_zu_afd2017_von_spd "Wechsel zur AfD 2017 von SPD 2013"

lab define wechsel_zu_afd2017_von_spd 0 "AfD gewaehlt 2013 und 2017" 1 "Zuwanderung zur AfD 2017 von SPD 2013"

lab val wechsel_zu_afd2017_von_spd wechsel_zu_afd2017_von_spd

replace wechsel_zu_afd2017_von_spd=0 if afd2013==1 & afd2017==1

replace wechsel_zu_afd2017_von_spd=1 if spd2013==1 & afd2017==1

tab wechsel_zu_afd2017_von_spd

tab wechsel_zu_afd2017_von_spd if syear==2017

*****

* Mittelwertzentrierungen:

* CDU/CSU:

* Nettoaequivalenzeinkommen

sum equiv_inc_net_l ///
if !missing(wechsel_zu_afd2017_von_cducsu, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

gen equiv_inc_net_l_cducsu2=.

replace equiv_inc_net_l_cducsu2 = equiv_inc_net_l-r(mean) ///
if !missing(wechsel_zu_afd2017_von_cducsu, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

sum equiv_inc_net_l_cducsu2 ///
if !missing(wechsel_zu_afd2017_von_cducsu, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

sum equiv_inc_net_l_cducsu

* Veraenderung Nettoaequivalenzeinkommen CDU/CSU

gen equiv_inc_net_l_diff_cducsu2=.

replace equiv_inc_net_l_diff_cducsu2=equiv_inc_net_l_diff-r(mean) ///
if !missing(wechsel_zu_afd2017_von_cducsu, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

sum equiv_inc_net_l_diff_cducsu2

* Alter

sum alter ///
if !missing(wechsel_zu_afd2017_von_cducsu, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

gen alter_cducsu2=.

replace alter_cducsu2 = alter-r(mean) ///
if !missing(wechsel_zu_afd2017_von_cducsu, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

sum alter_cducsu2

* SPD:

* Nettoaequivalenzeinkommen

sum equiv_inc_net_l ///
if !missing(wechselafdvonspd_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

gen equiv_inc_net_l_spd2=.

replace equiv_inc_net_l_spd2 = equiv_inc_net_l-r(mean) ///
if !missing(wechsel_zu_afd2017_von_spd, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

sum equiv_inc_net_l_spd2 ///
if !missing(wechsel_zu_afd2017_von_spd, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

* Veraenderung Nettoaequivalenzeinkommen SPD

gen equiv_inc_net_l_diff_spd2=.

replace equiv_inc_net_l_diff_spd2=equiv_inc_net_l_diff-r(mean) ///
if !missing(wechsel_zu_afd2017_von_spd, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
plh0011_v2_spd2013_inv, erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

* Alter

sum alter ///
if !missing(wechsel_zu_afd2017_von_spd, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

gen alter_spd2=.

replace alter_spd2 = alter-r(mean) ///
if !missing(wechsel_zu_afd2017_von_spd, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l, equiv_inc_net_l_diff, ///
erwerbstat_2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter) & syear==2017

sum alter_spd2

*****

* Logistische Regressionen

* (1) AV: wechsel_zu_afd2017_von_cducsu

logit wechsel_zu_afd2017_von_cducsu ib0.plj0046_2013 ib0.plj0046_diff_dich ib0.plh0033_2013 ib0.plh0033_diff_dich ///
equiv_inc_net_l_cducsu2 equiv_inc_net_l_diff_cducsu2 ib0.erwerbstat_2013_inv ///
ib0.pgpsbil_dich ib0.ostwest ib0.pla0009_v2_rek alter_cducsu2 ///
if !missing(wechsel_zu_afd2017_von_cducsu, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l_cducsu2, equiv_inc_net_l_diff_cducsu2, erwerbstat_2013_inv, ///
pgpsbil_dich, ostwest, pla0009_v2_rek, alter_cducsu2) & syear==2017, or

* (2) wechsel_zu_afd2017_von_spd

logit wechsel_zu_afd2017_von_spd ib0.plj0046_2013 ib0.plj0046_diff_dich ib0.plh0033_2013 ib0.plh0033_diff_dich ///
equiv_inc_net_l_spd2 equiv_inc_net_l_diff_spd2 ib0.erwerbstat_2013_inv ///
ib0.pgpsbil_dich ib0.ostwest ib0.pla0009_v2_rek alter_spd2 ///
if !missing(wechsel_zu_afd2017_von_spd, plj0046_2013, plj0046_diff_dich,plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l_spd2, equiv_inc_net_l_diff_spd2, erwerbstat_2013_inv, ///
pgpsbil_dich, ostwest, pla0009_v2_rek, alter_spd2) & syear==2017, or

******

* Wechselvergleiche (Robustheitsanalysen, Tabelle A3 im Online-Supplement)

* AV bilden fuer Wechslervergleiche: 1 = Wechsel von CDU/CSU 2013 bzw. SPD2013 zu AfD 2017, 0 = Wechsel von AfD 2013 zu CDU/CSU 2017 bzw. SPD 2017

* AV fuer CDU/CSU

gen afd_wechs_cducsu=.

replace afd_wechs_cducsu=1 if wechselafdvoncducsu_1==1

replace afd_wechs_cducsu= 0 if afd2013==1 & cdu_csu2017==1

lab var afd_wechs_cducsu "Wechselvergleich zwischen AfD und CDU/CSU"

lab define afd_wechs_cducsu 1 "Wechsel von CDU/CSU 2013 zu AfD 2017" 0 "Wechsel von AfD 2013 zu CDU/CSU 2017"

lab val afd_wechs_cducsu afd_wechs_cducsu

tab afd_wechs_cducsu

tab afd_wechs_cducsu if syear==2017

* AV fuer SPD

gen afd_wechs_spd=.

replace afd_wechs_spd=1 if wechselafdvonspd_1==1

replace afd_wechs_spd= 0 if afd2013==1 & spd2017==1

lab var afd_wechs_spd "Wechselvergleich zwischen AfD und SPD"

lab define afd_wechs_spd 1 "Wechsel von SPD 2013 zu AfD 2017" 0 "Wechsel von AfD 2013 zu SPD 2017"

lab val afd_wechs_spd afd_wechs_spd

tab afd_wechs_spd

tab afd_wechs_spd if syear==2017

***

* Mittelwerte zentrieren

* CDU/CSU

* Nettoaequivalenzeinkommen

sum equiv_inc_net_l ///
if !missing(afd_wechs_cducsu) & syear==2017

gen equiv_inc_net_l_cducsu3=.

replace equiv_inc_net_l_cducsu3 = equiv_inc_net_l-r(mean) ///
if !missing(afd_wechs_cducsu) & syear==2017

sum equiv_inc_net_l_cducsu3 ///
if !missing(afd_wechs_cducsu) & syear==2017

sum equiv_inc_net_l_cducsu3

* Veraenderung Nettoaequivalenzeinkommen CDU/CSU

gen equiv_inc_net_l_diff_cducsu3=.

replace equiv_inc_net_l_diff_cducsu3=equiv_inc_net_l_diff-r(mean) ///
if !missing(afd_wechs_cducsu) & syear==2017

sum equiv_inc_net_l_diff_cducsu3

* Alter

sum alter ///
if !missing(afd_wechs_cducsu) & syear==2017

gen alter_cducsu3=.

replace alter_cducsu3 = alter-r(mean) ///
if !missing(afd_wechs_cducsu) & syear==2017

sum alter_cducsu3

* SPD 

* Nettoaequivalenzeinkommen

sum equiv_inc_net_l ///
if !missing(afd_wechs_spd) & syear==2017

gen equiv_inc_net_l_spd3=.

replace equiv_inc_net_l_spd3 = equiv_inc_net_l-r(mean) ///
if !missing(afd_wechs_spd) & syear==2017

sum equiv_inc_net_l_spd3 ///
if !missing(afd_wechs_spd) & syear==2017

* Veraenderung Nettoaequivalenzeinkommen SPD

gen equiv_inc_net_l_diff_spd3=.

replace equiv_inc_net_l_diff_spd3=equiv_inc_net_l_diff-r(mean) ///
if !missing(afd_wechs_spd) & syear==2017

* Alter

sum alter ///
if !missing(afd_wechs_spd) & syear==2017

gen alter_spd3=.

replace alter_spd3 = alter-r(mean) ///
if !missing(afd_wechs_spd) & syear==2017

sum alter_spd3

***

* Fallzahlen AV

* (1) CDU/CSU

xttab afd_wechs_cducsu ///
if !missing(afd_wechs_cducsu, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l_cducsu3, equiv_inc_net_l_diff_cducsu3, erwerbstat_2013_inv, ///
pgpsbil_dich, ostwest, pla0009_v2_rek, alter_cducsu3) & syear==2017

* (2) SPD 

xttab afd_wechs_spd ///
if !missing(afd_wechs_spd, plj0046_2013, plj0046_diff_dich,plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l_spd3, equiv_inc_net_l_diff_spd3, erwerbstat_2013_inv, ///
pgpsbil_dich, ostwest, pla0009_v2_rek, alter_spd3) & syear==2017

* Logistische Regressionen

* (1) CDU/CSU

logit afd_wechs_cducsu ib0.plj0046_2013 ib0.plj0046_diff_dich ib0.plh0033_2013 ib0.plh0033_diff_dich ///
equiv_inc_net_l_cducsu3 equiv_inc_net_l_diff_cducsu3 ib0.erwerbstat_2013_inv ///
ib0.pgpsbil_dich ib0.ostwest ib0.pla0009_v2_rek alter_cducsu3 ///
if !missing(afd_wechs_cducsu, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l_cducsu3, equiv_inc_net_l_diff_cducsu3, erwerbstat_2013_inv, ///
pgpsbil_dich, ostwest, pla0009_v2_rek, alter_cducsu3) & syear==2017, or

* Information criteria:

estat ic

* Average Marginal Effects:

eststo L: margins, dydx (_all) post

* (2) SPD 

logit afd_wechs_spd ib0.plj0046_2013 ib0.plj0046_diff_dich ib0.plh0033_2013 ib0.plh0033_diff_dich ///
equiv_inc_net_l_spd3 equiv_inc_net_l_diff_spd3 ib0.erwerbstat_2013_inv ///
ib0.pgpsbil_dich ib0.ostwest ib0.pla0009_v2_rek alter_spd3 ///
if !missing(afd_wechs_spd, plj0046_2013, plj0046_diff_dich,plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l_spd3, equiv_inc_net_l_diff_spd3, erwerbstat_2013_inv, ///
pgpsbil_dich, ostwest, pla0009_v2_rek, alter_spd3) & syear==2017, or

* Information criteria:

estat ic

* Average Marginal Effects:

eststo M: margins, dydx (_all) post

*** Fuer Output in Word ***

esttab L M using "E:\Projekte+Ideen_laufend\2003-Wählerwanderung\Stata Tables\220708_ame_nettowechsel.rtf", replace ///
title({Tabelle xy:} {Wanderung von der SPD zur AfD}) ///
nonumbers mtitles("Modell 1 - CDU/CSU" "Modell 2 - SPD") label ///
cells("b (star fmt(3) label(AME)) se(par fmt(2) label(SE)) p(fmt(3) label(p))") starlevels(+ 0.10 * 0.05 ** 0.01 *** 0.001) dmarker(,) ///
stats(n pr2 aic bic, fmt(0 2 4 4) labels("n" "Pseudo R^2" "AIC" "BIC")) constant ///
nonotes addnote("Quelle: SOEP 2013 und 2017. Logistische Regression mit durchschnittlichen marginalen Effekten." ///
"AME = Durchschnittl. marginaler Effekt, SE = Standardfehler, p = empirische Signifikanz") legend scalars(n pr2 aic bic) ///
fonttbl(\f0\fnil arial; ) nogaps compress

**********************************************************

* Hauptanalysen - Odds Ratios (Tabellen A4 und A5 im Online-Supplement)

* Logistische Regression CDU/CSU:

* (1) UV: Sorge um Zuzug, ohne Kontrollvariablen

eststo P: logit wechselafdvoncducsu_1 ib0.plj0046_2013 ib0.plj0046_diff_dich ///
if !missing(wechselafdvoncducsu_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l_cducsu, equiv_inc_net_l_diff_cducsu, erwerbstat_2013_inv, ///
plh0011_v2_cducsu2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter_cducsu) & syear==2017, or

* Information criteria:

estat ic

* (2) UV: Sorge um eigene wirtschaftliche Lage, ohne Kontrollvariablen

eststo Q: logit wechselafdvoncducsu_1 ib0.plh0033_2013 ib0.plh0033_diff_dich ///
if !missing(wechselafdvoncducsu_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l_cducsu, equiv_inc_net_l_diff_cducsu, erwerbstat_2013_inv, ///
plh0011_v2_cducsu2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter_cducsu) & syear==2017, or

* Information criteria:

estat ic

* (3) UV: Einkommen, ohne Kontrollvariablen

eststo R: logit wechselafdvoncducsu_1 equiv_inc_net_l_cducsu equiv_inc_net_l_diff_cducsu ///
if !missing(wechselafdvoncducsu_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l_cducsu, equiv_inc_net_l_diff_cducsu, erwerbstat_2013_inv, ///
plh0011_v2_cducsu2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter_cducsu) & syear==2017, or

* Information criteria:

estat ic

****

* (4) Mit Kontrollvariablen

eststo S: logit wechselafdvoncducsu_1 ib0.plj0046_2013 ib0.plj0046_diff_dich ib0.plh0033_2013 ib0.plh0033_diff_dich ///
equiv_inc_net_l_cducsu equiv_inc_net_l_diff_cducsu ib0.erwerbstat_2013_inv ///
ib0.plh0011_v2_cducsu2013_inv ib0.pgpsbil_dich ib0.ostwest ib0.pla0009_v2_rek alter_cducsu ///
if !missing(wechselafdvoncducsu_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l_cducsu, equiv_inc_net_l_diff_cducsu, erwerbstat_2013_inv, ///
plh0011_v2_cducsu2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter_cducsu) & syear==2017, or

* --> ACHTUNG! BERICHTEN: Negativer Zusammenhang zwischen Erwerbsstatus und Wanderung verschwindet, wenn fuer Bildungsstand kontrolliert wird. ///
* Bildung ist ein Suppressor fuer Erwerbseffekt (s.u.)

* --> Auch berichten (in Anhang): Spezifische Deskriptionen fuer Wechsler_innen je Partei (s.u.)

* Information criteria:

estat ic

*** Fuer Output in Word ***

esttab P Q R S using "E:\Projekte+Ideen_laufend\2003-Wählerwanderung\Stata Tables\220714_or_cducsu_neu.rtf", replace ///
title({Tabelle 2:} {Wanderung von der CDU/CSU zur AfD}) ///
nonumbers mtitles("Modell 1" "Modell 2" "Modell 3" "Modell 4") label eform ///
cells("b (star fmt(3) label(OR)) se(par fmt(2) label(SE)) p(fmt(3) label(p))") starlevels(+ 0.10 * 0.05 ** 0.01 *** 0.001) dmarker(,) ///
stats(n pr2 aic bic, fmt(0 2 4 4) labels("n" "Pseudo R^2" "AIC" "BIC")) constant ///
nonotes addnote("Quelle: SOEP 2013 und 2017. Logistische Regression mit Odds Ratios." ///
"OR = Odds Ratio, SE = Standardfehler, p = empirische Signifikanz") legend scalars(n pr2 aic bic) ///
fonttbl(\f0\fnil arial; ) nogaps compress

******

* Logistische Regression SPD:

* (1) UV: Sorge um Zuzug, ohne Kontrollvariablen

eststo T: logit wechselafdvonspd_1 ib0.plj0046_2013 ib0.plj0046_diff_dich ///
if !missing(wechselafdvonspd_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l_spd, equiv_inc_net_l_diff_spd, erwerbstat_2013_inv, ///
plh0011_v2_spd2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter_spd) & syear==2017, or

* Information criteria:

estat ic

* (2) UV: Sorge um eigene wirtschaftliche Lage, ohne Kontrollvariablen

eststo U: logit wechselafdvonspd_1 ib0.plh0033_2013 ib0.plh0033_diff_dich ///
if !missing(wechselafdvonspd_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l_spd, equiv_inc_net_l_diff_spd, erwerbstat_2013_inv, ///
plh0011_v2_spd2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter_spd) & syear==2017, or

* Information criteria:

estat ic

* (3) UV: Einkommen, ohne Kontrollvariablen

eststo V: logit wechselafdvonspd_1 equiv_inc_net_l_spd equiv_inc_net_l_diff_spd ///
if !missing(wechselafdvonspd_1, plj0046_2013, plj0046_diff_dich, plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l_spd, equiv_inc_net_l_diff_spd, erwerbstat_2013_inv, ///
plh0011_v2_spd2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter_spd) & syear==2017, or

* Information criteria:

estat ic

****

* (4) Mit Kontrollvariablen

eststo W: logit wechselafdvonspd_1 ib0.plj0046_2013 ib0.plj0046_diff_dich ib0.plh0033_2013 ib0.plh0033_diff_dich ///
equiv_inc_net_l_spd equiv_inc_net_l_diff_spd ib0.erwerbstat_2013_inv ///
ib0.plh0011_v2_spd2013_inv ib0.pgpsbil_dich ib0.ostwest ib0.pla0009_v2_rek alter_spd ///
if !missing(wechselafdvonspd_1, plj0046_2013, plj0046_diff_dich,plh0033_2013, plh0033_diff_dich, ///
equiv_inc_net_l_spd, equiv_inc_net_l_diff_spd, erwerbstat_2013_inv, ///
plh0011_v2_spd2013_inv, pgpsbil_dich, ostwest, pla0009_v2_rek, alter_spd) & syear==2017, or

* Information criteria:

estat ic

*** Fuer Output in Word ***

esttab T U V W using "E:\Projekte+Ideen_laufend\2003-Wählerwanderung\Stata Tables\220714_or_spd_neu.rtf", replace ///
title({Tabelle 2:} {Wanderung von der SPD zur AfD}) ///
nonumbers mtitles("Modell 1" "Modell 2" "Modell 3" "Modell 4") label eform ///
cells("b (star fmt(3) label(OR)) se(par fmt(2) label(SE)) p(fmt(3) label(p))") starlevels(+ 0.10 * 0.05 ** 0.01 *** 0.001) dmarker(,) ///
stats(n pr2 aic bic, fmt(0 2 4 4) labels("n" "Pseudo R^2" "AIC" "BIC")) constant ///
nonotes addnote("Quelle: SOEP 2013 und 2017. Logistische Regression mit Odds Ratios." ///
"OR = Odds Ratio, SE = Standardfehler, p = empirische Signifikanz") legend scalars(n pr2 aic bic) ///
fonttbl(\f0\fnil arial; ) nogaps compress

************************************************************************

* Wechselmodelle als FE-Modelle (Zusatzanalysen fuer Gutachterbericht, nicht abgebildet und berichtet):

* Logistische Regressionen

tab plh0033_dich if !missing(afd_wechs_cducsu , plj0046_dich, plh0033_dich, equiv_inc_net_l, alter)

pwcorr afd_wechs_cducsu plj0046_dich plh0033_dich equiv_inc_net_l alter ///
if !missing(afd_wechs_cducsu, plj0046_dich, plh0033_dich, equiv_inc_net_l, alter)

xttab afd_wechs_cducsu plh0033_dich ///
if !missing(afd_wechs_cducsu, plj0046_dich, equiv_inc_net_l, alter)

xttab afd_wechs_spd plh0033_dich ///
if !missing(afd_wechs_spd, plj0046_dich, equiv_inc_net_l, alter)

xttab afd_wechs_cducsu ///
if !missing(afd_wechs_cducsu, plj0046_dich, equiv_inc_net_l, alter)

xttab afd_wechs_spd ///
if !missing(afd_wechs_spd, plj0046_dich, equiv_inc_net_l, alter)


* --> Problem: Bei Personen, die 2017 von der AfD zur CDU/CSU wechselten, ist niemand, der/die sich viele Sorgen um eigene wirtschaftliche Lage machten
* --> Effekt plh0033_dich nicht schaetzbar, ausschließen aus Analysen

* (1) CDU/CSU (FE)

eststo X: xtlogit afd_wechs_cducsu plj0046_dich equiv_inc_net_l alter ///
if !missing(afd_wechs_cducsu, plj0046_dich, equiv_inc_net_l, alter), or post

* Average Marginal Effects:

* margins, dydx (_all) post

* ---> nicht stabil schaetzbar aufgrund geringer Fallzahlen (sehr lange Rechenzeiten)

* (2) SPD (FE)

eststo Y: xtlogit afd_wechs_spd plj0046_dich equiv_inc_net_l alter ///
if !missing(afd_wechs_spd, plj0046_dich, equiv_inc_net_l, alter), or

* Average Marginal Effects:

* margins, dydx (_all) post

* ---> nicht stabil schaetzbar aufgrund geringer Fallzahlen (sehr lange Rechenzeiten)

*** Fuer Output in Word ***

esttab X Y using "E:\Projekte+Ideen_laufend\2003-Wählerwanderung\Stata Tables\220714_or_nettowechsel_Fixed_effects.rtf", replace ///
title({Tabelle xy:} {Wanderung von der SPD zur AfD}) ///
nonumbers mtitles("Modell 1 - CDU/CSU" "Modell 2 - SPD") label eform ///
cells("b (star fmt(3) label(OR)) se(par fmt(2) label(SE)) p(fmt(3) label(p))") starlevels(+ 0.10 * 0.05 ** 0.01 *** 0.001) dmarker(,) ///
stats(n pr2 aic bic, fmt(0 2 4 4) labels("n" "Pseudo R^2" "AIC" "BIC")) constant ///
nonotes addnote("Quelle: SOEP 2013 und 2017. Logistische Fixed Effects-Regression mit Odds Ratio." ///
"OR = Odds Ratio, SE = Standardfehler, p = empirische Signifikanz") legend scalars(n pr2 aic bic) ///
fonttbl(\f0\fnil arial; ) nogaps compress

estat clear