******************************************************
***200323 - SOEP v35 - pl                          ***
******************************************************

/* Projekt: 2003 - Wahlerwanderung */
/* Mergen Gewichtungsfaktoren fuer alle Befragten 2013 - 2017 */

/* Dokumentationen: */

/* Generell zu $$pequiv 1984-2018: Grabka, Markus M. (2020): SOEP-Core v35 - */
/* Codebook for the $PEQUIV File 1984-2018: CNEF variables with extended income information for the SOEP. SOEP Survey Papers No. 772: Series D. Berlin: DIE/SOEP */

*******************************************************

* Usevariables:

* Identifier:

* cid				Case ID
* hid				Current Wave HH Number
* persnr			Never Changing Person ID
* syear				Survey Year
* hhnr				Ursprungshaushaltsnummer
* $$hhnr			Current Wave HH Number (=HHNRAKT)
* hhnrakt			Current Wave HH Number (=beHHNR)
* pid 				Never Changing Person ID

* Angaben zu Gewichtung:

* w11104 			Individual cross-sectional weight (without 1st wave of subsample)
* w11102 			HH weight
* w11103 			Longitudinal weight (respondent individual)
* w11105 			Cross-sectional weight - all samples
* w11107			x-sectional weight (enumerated individual)
* w11108			longitudinal weight (enumerated individual)
* w11101 			individual cross-sectional weight (without 1st wave of subsample)
 
********************************

clear

version 17
 
set more off

********************************

*** Verzeichnis festlegen
cd "..."									// In dieser Zeile muss der Ordner angegeben werden, in dem der nachfolgende Datensatz liegt

*** Datensatz laden
use "..."									// In o.g. Ordner muss dieser Datensatz platziert werden. Bei Aenderung des Dateinamens diese Aenderung hier uebernehmen

********************************

* Gewichte uebernehmen aus 200521-SOEP_v35pequiv.dta

merge 1:1 pid syear using 200521-SOEP_v35pequiv.dta, keepusing(pid syear w11104 w11102 w11103 w11105 w11107 w11108 w11101)

drop if _merge==2

* Datensatz speichern

save "...", replace							// Dateiname eintragen