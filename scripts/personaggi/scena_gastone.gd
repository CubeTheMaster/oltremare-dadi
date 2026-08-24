extends CharacterClass # GASTONE

# ----------------------------- V A R I A B I L I -----------------------------
## INTERFACCIA
# Pulsanti
@onready var sovraccarico = %Sovraccarico.button_pressed
@onready var colpo_preciso = %"Colpo Preciso".button_pressed

# ------------------------------- O P Z I O N I -------------------------------
## COLPO PRECISO
func _on_colpo_preciso_toggled(toggled_on: bool) -> void:
	colpo_preciso = toggled_on

## SOVRACCARICO TONANTE
func _on_sovraccarico_toggled(toggled_on: bool) -> void:
	sovraccarico = toggled_on

# -------------------------------- A Z I O N I --------------------------------
# - Attacchi MELEE -
## Attacco ARTIGLI (1 ATT, 1 ATT+1)
func _on_artigli_pressed() -> void:
	# resetta variabili
	reset()
	
	# inizializza il danno al valore del M.AM
	danni += int(m_AM.value)
	
	# tiri dadi ATT
	risultato = tira(1, ATTACCO)
	danni += risultato["valore"]
	terminale.text += risultato["testo"]
	
	# tiri dadi ATT+1
	risultato = tira(1, ATTACCO_PIU1)
	danni += risultato["valore"]
	terminale.text += risultato["testo"]
	
	# risultati
	terminale.text += "\nDANNI:  " + str(danni) + " Taglienti/Perforanti"

## Attacco CHELE GEMELLE (4 ATT, 2 ATT+1)                               [br][br]
## Sovraccarico: +2 ATT+1, +1 ARC (4 ATT, 4 ATT+1, 1 ARC)
func _on_chele_gemelle_pressed() -> void:
	# resetta variabili
	reset()
	
	# inizializza il danno al valore del M.AM
	danni += int(m_AM.value)
	
	# tiri dadi ATT
	risultato = tira(4, ATTACCO)
	danni += risultato["valore"]
	terminale.text += risultato["testo"]
	
	# tiri dadi ATT+1
	risultato = tira(2 + 2*int(sovraccarico), ATTACCO_PIU1)
	danni += risultato["valore"]
	terminale.text += risultato["testo"]
	
	# tiri dadi ARC
	if sovraccarico:
		risultato = tira(1, ARCANO)
		danni += risultato["valore"]
		terminale.text += risultato["testo"]
	
	# risultati
	terminale.text += "\nDANNI:  " + str(danni) + " Taglienti"
	if sovraccarico:
		terminale.text += " - Fulmine"
		terminale.text += "\nSBILANCIAMENTO!"

# - Attacchi RANGED -
## Attacco FUCILE (1 ADF, 1 ADF+1, 3 ATT+1)                             [br][br]
## Sovraccarico: +1 ADF+1, +3 ATT+1 (1 ADF, 2 ADF+1, 6 ATT+1)
func _on_fucile_pressed() -> void:
	# resetta variabili
	reset()
	
	# inizializza la gittata al valore del M.AF (x2 con Colpo Preciso/Sovraccaarico)
	gittata += int(m_AF.value)
	if colpo_preciso or sovraccarico:
		gittata *= 2
	var gittata_min: int = gittata
	
	# tiri dadi ADF
	risultato = tira(1, ATTACCO_ADF)
	gittata += risultato["valore"]
	danni += risultato["valore"]
	terminale.text += risultato["testo"]
	
	# tiri dadi ADF+1
	risultato = tira(1 + 1*int(sovraccarico), ATTACCO_ADF_PIU1)
	gittata += risultato["valore"]
	danni += risultato["valore"]
	terminale.text += risultato["testo"]
	
	# tiri dadi ATT+1
	risultato = tira(3 + 3*int(sovraccarico), ATTACCO_PIU1)
	danni += risultato["valore"]
	terminale.text += risultato["testo"]
	
	# risultati
	terminale.text += "\nGITTATA min:  " + str(gittata_min)
	terminale.text += "\nGITTATA max:  " + str(gittata)
	terminale.text += "\nDANNI max:  " + str(danni) + " Sparo"
	if sovraccarico:
		terminale.text += " - Fulmine"

# - Difese -
## Difesa CLASSE PESANTE                                                [br][br]
## con Sovraccarico: +2 DIF (3 DIF, 4 DIF+1)
func _on_difesa_pressed() -> void:
	# resetta variabili
	reset()
	
	# tiri dadi DIF
	risultato = tira(N_PESANTE["DIF"] + 2*int(sovraccarico), DIFESA)
	riduzione += risultato["valore"]
	terminale.text += risultato["testo"]
	
	# tiri dadi DIF+1
	risultato = tira(N_PESANTE["DIF+1"], DIFESA_PIU1)
	riduzione += risultato["valore"]
	terminale.text += risultato["testo"]
	
	# risulsati
	terminale.text += "\nRIDUZIONE:  " + str(riduzione)
