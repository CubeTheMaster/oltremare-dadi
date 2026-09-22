extends CharacterClass # CARMINE

# ----------------------------- V A R I A B I L I -----------------------------
## COSTANTI
const GITTATA_BALESTRA = 3

# -------------------------------- A Z I O N I --------------------------------
# - Attacchi MELEE -
## Attacco CALCIO DELLA PISTOLA (1 ATT, 2 ATT+1)
## + doppia Pistola: dadi x2 (2 ATT, 4 ATT+1)
func _on_calcio_pressed() -> void:
	# resetta variabili
	reset()
	
	# tiri dadi ATT
	risultato = tira(1*2, ATTACCO)
	danni += risultato["valore"]
	terminale.text += risultato["testo"]
	
	# tiri dadi ATT+1
	risultato = tira(2*2, ATTACCO_PIU1)
	danni += risultato["valore"]
	terminale.text += risultato["testo"]
	
	# risultati
	terminale.text += "\nDANNI:  " + str(danni) + " Bruti"

# - Attacchi RANGED -
## Attacco PISTOLA (1 ADF+1, 1 ATT, 2 ATT+1)
func _on_pistola_pressed() -> void:
	# resetta variabili
	reset()
	
	# inizializza la gittata al valore del M.AF
	gittata += int(m_AF.value)
	
	# tiri dadi ADF+1
	risultato = tira(1, ATTACCO_ADF_PIU1)
	gittata += risultato["valore"]
	danni += risultato["valore"]
	terminale.text += risultato["testo"]
	
	# tiri dadi ATT
	risultato = tira(1, ATTACCO)
	danni += risultato["valore"]
	terminale.text += risultato["testo"]
	
	# tiri dadi ATT+1
	risultato = tira(2, ATTACCO_PIU1)
	danni += risultato["valore"]
	terminale.text += risultato["testo"]
	
	# risultati
	terminale.text += "\nGITTATA min:  " + str(int(m_AF.value))
	terminale.text += "\nGITTATA max:  " + str(gittata)
	terminale.text += "\nDANNI max:  " + str(danni) + " Sparo"

## Attacco RAFFICA (1 ADF+1, 6 ATT)
func _on_raffica_pressed() -> void:
	# resetta variabili
	reset()
	
	# inizializza la gittata al valore del M.AF
	gittata += int(m_AF.value)
	
	# tiri dadi ADF+1
	risultato = tira(1, ATTACCO_ADF_PIU1)
	gittata += risultato["valore"]
	danni += risultato["valore"]
	terminale.text += risultato["testo"]
	
	# tiri dadi ATT+1
	risultato = tira(6, ATTACCO_PIU1)
	danni += risultato["valore"]
	terminale.text += risultato["testo"]
	
	# risultati
	terminale.text += "\nGITTATA min:  " + str(int(m_AF.value))
	terminale.text += "\nGITTATA max:  " + str(gittata)
	terminale.text += "\nDANNI max:  " + str(danni) + " Sparo"

## Attacco BALESTRA (2 ATT, 2 ATT+1)
func _on_balestra_pressed() -> void:
	# resetta variabili
	reset()
	
	# gittata costante
	gittata += int(m_AF.value) + GITTATA_BALESTRA
	
	# tiri dadi ATT
	risultato = tira(2, ATTACCO)
	danni += risultato["valore"]
	terminale.text += risultato["testo"]
	
	# tiri dadi ATT+1
	risultato = tira(2, ATTACCO_PIU1)
	danni += risultato["valore"]
	terminale.text += risultato["testo"]
	
	# risultati
	terminale.text += "\nGITTATA:  " + str(gittata)
	terminale.text += "\nDANNI:  " + str(danni) + " Perforanti"

## Attacco DOPPIA PISTOLA (1 ADF+1, 4 ATT, 2 ATT+1)
func _on_doppia_pistola_pressed() -> void:
	# resetta variabili
	reset()
	
	# inizializza la gittata al valore del M.AF
	gittata += int(m_AF.value)
	
	# tiri dadi ADF+1
	risultato = tira(1, ATTACCO_ADF_PIU1)
	gittata += risultato["valore"]
	danni += risultato["valore"]
	terminale.text += risultato["testo"]
	
	# tiri dadi ATT
	risultato = tira(4, ATTACCO)
	danni += risultato["valore"]
	terminale.text += risultato["testo"]
	
	# tiri dadi ATT+1
	risultato = tira(2, ATTACCO_PIU1)
	danni += risultato["valore"]
	terminale.text += risultato["testo"]
	
	# risultati
	terminale.text += "\nGITTATA min:  " + str(int(m_AF.value))
	terminale.text += "\nGITTATA max:  " + str(gittata)
	terminale.text += "\nDANNI max:  " + str(danni) + " Sparo"

## Attacco DOPPIA RAFFICA (1 ADF+1, 8 ATT, 4 ATT+1)
func _on_doppia_raffica_pressed() -> void:
	# resetta variabili
	reset()
	
	# inizializza la gittata al valore del M.AF
	gittata += int(m_AF.value)
	
	# tiri dadi ADF+1
	risultato = tira(1, ATTACCO_ADF_PIU1)
	gittata += risultato["valore"]
	danni += risultato["valore"]
	terminale.text += risultato["testo"]
	
	# tiri dadi ATT
	risultato = tira(8, ATTACCO)
	danni += risultato["valore"]
	terminale.text += risultato["testo"]
	
	# tiri dadi ATT+1
	risultato = tira(4, ATTACCO_PIU1)
	danni += risultato["valore"]
	terminale.text += risultato["testo"]
	
	# risultati
	terminale.text += "\nGITTATA min:  " + str(int(m_AF.value))
	terminale.text += "\nGITTATA max:  " + str(gittata)
	terminale.text += "\nDANNI max:  " + str(danni) + " Sparo"

# - Attacchi AOE -
## Attacco CANDELOTTO DI DINAMITE (1 ADF, 5 ATT+1)
func _on_dinamite_pressed() -> void:
	# resetta variabili
	reset()
	
	# inizializza la gittata al valore del M.AF
	gittata += int(m_AF.value)
	
	# tiri dadi ADF
	risultato = tira(1, ATTACCO_ADF)
	gittata += risultato["valore"]
	danni += risultato["valore"]
	terminale.text += risultato["testo"]
	
	# tiri dadi ATT+1
	risultato = tira(5, ATTACCO_PIU1)
	danni += risultato["valore"]
	terminale.text += risultato["testo"]
	
	# risultati
	terminale.text += "\nGITTATA min:  " + str(int(m_AF.value))
	terminale.text += "\nGITTATA max:  " + str(gittata)
	terminale.text += "\nDANNI max:  " + str(danni) + " Fuoco..?"

# - Difese -
## Difesa CLASSE LEGGERA
func _on_difesa_pressed() -> void:
	# resetta variabili
	reset()
	
	# difesa classe LEGGERA
	risultato = difesa_leggera()
	riduzione += risultato["valore"]
	terminale.text += risultato["testo"] 
	
	# verifica schivata
	if schivata(riduzione, terminale):
		return
	
	# inserisci danni ricevuti e calcola danni subiti
	info_danni = await inserisci_danni_ricevuti()
	danni_subiti = danno_subito(info_danni, riduzione, terminale)
