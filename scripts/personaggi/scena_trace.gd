extends CharacterClass # TRACEDINO

# ----------------------------- V A R I A B I L I -----------------------------
## INTERFACCIA
# Pulsanti
@onready var incanalare = %Incanalare.button_pressed
@onready var due_mani = int(%Selettore.button_pressed)
@onready var scudo = int(not %Selettore.button_pressed)

## COSTANTI
# Buff
const OMNIFORGIA: int = 1                                # arma perfezionata dalle omniforge di Eden

# ------------------------------- O P Z I O N I -------------------------------
## INCANALARE
func _on_incanalare_toggled(toggled_on: bool) -> void:
	incanalare = toggled_on

func effetto_incanalare(valore_arcano, _terminale: TextEdit, newline: bool = true) -> void:
	if newline:
		_terminale.text += "\n"
	
	match valore_arcano:
		6: # se il dado fa 5: ripristino
			_terminale.text += "\n1 PUNTO ARCANO RIPRISTINATO!"
		8: # se il dado fa 6: esplosione
			_terminale.text += "\nESPLOSIONE! 4 DANNI SUBITI"
		_: # se il dado fa da 1 a 4: niente
			return

## SCUDO / DUE MANI
func _on_selettore_toggled(toggled_on: bool) -> void:
	scudo = int(!toggled_on)
	due_mani = int(toggled_on)

# -------------------------------- A Z I O N I --------------------------------
# - Attacchi MELEE -
## Attacco SPADA (2 ATT, 1 ATT+1)                                       [br][br]
## + Omniforgia: +1 ATT+1 (2 ATT, 2 ATT+1)                              [br][br]
## con Due Mani: +1 ATT, +1 ATT+1 (3 ATT, 3 ATT+1)                      [br][br]
## con Incanalare: +1 ARC (3 ATT, 3 ATT+1, 1 ARC)
func _on_spada_pressed() -> void:
	# resetta variabili
	reset()
	
	# inizializza il danno al valore del M.AM
	# +1 se l'arma è impugnata a due mani
	danni += int(m_AM.value) + due_mani
	
	# tiri dadi ATT
	risultato = tira(2 + due_mani, ATTACCO)
	danni += risultato["valore"]
	terminale.text += risultato["testo"]
	
	# tiri dadi ATT+1
	risultato = tira(1 + due_mani + OMNIFORGIA, ATTACCO_PIU1)
	danni += risultato["valore"]
	terminale.text += risultato["testo"]
	
	# tiri dadi ARC
	if incanalare:
		risultato = tira(1, ARCANO)
		danni += risultato["valore"]
		terminale.text += risultato["testo"]
		
		# risultati
		terminale.text += "\nDANNI:  " + str(danni) + " Taglienti/Perforanti - Arcano"
		effetto_incanalare(risultato["valore"], terminale)
	else:
		terminale.text += "\nDANNI:  " + str(danni) + " Taglienti/Perforanti"

## Attacco SPADONE ARCANO (3 ATT, 5 ATT+1, 1 ARC)                       [br][br]
## + Omniforgia: +1 ATT+1 (3 ATT, 6 ATT+1, 1 ARC)                       [br][br]
## con Incanalare: +1 ARC (3 ATT, 6 ATT+1, 2 ARC)
func _on_spadone_arcano_pressed() -> void:
	# resetta variabili
	reset()
	
	# inizializza il danno al valore del M.AM + 1 (sempre a due mani)
	danni += int(m_AM.value) + 1
	
	# tiri dadi ATT
	risultato = tira(3, ATTACCO)
	danni += risultato["valore"]
	terminale.text += risultato["testo"]
	
	# tiri dadi ATT+1
	risultato = tira(5 + OMNIFORGIA, ATTACCO_PIU1)
	danni += risultato["valore"]
	terminale.text += risultato["testo"]
	
	# tiri dadi ARC
	risultato = tira(1 + 1*int(incanalare), ARCANO)
	danni += risultato["valore"]
	terminale.text += risultato["testo"]
	
	# risultati
	terminale.text += "\nDANNI:  " + str(danni) + " Taglienti/Perforanti - Arcano"
	if incanalare:
		var valore_incanalare = ARCANO[risultato["tiri"][-1]]
		effetto_incanalare(valore_incanalare, terminale)

# - Attacchi AOE -
## Attacco DEVASTAZIONE DI ZOLFO (1 ADF, 2 ARC)
## infligge MARCHIATURA
func _on_zolfo_pressed() -> void:
	# resetta variabili
	reset()
	
	# tiri dadi ADF
	risultato = tira(1, ATTACCO_ADF)
	danni += risultato["valore"]
	terminale.text += risultato["testo"]
	
	# tiri dadi ARC
	risultato = tira(2, ARCANO)
	danni += risultato["valore"]
	terminale.text += risultato["testo"]
	
	# risultati
	terminale.text += "\nDANNI:  " + str(danni) + " Fuoco - Arcano"
	
	# marchiatura
	marchiatura(terminale)

## Attacco PRIGIONE DI SALE (2 ARC)
func _on_sale_pressed() -> void:
	# resetta variabili
	reset()
	
	# tiri dadi ARC
	risultato = tira(2, ARCANO)
	danni += risultato["valore"]
	terminale.text += risultato["testo"]
	
	# risultati
	terminale.text += "\nDANNI:  " + str(danni) + " Puri"

# - Difese -
## Difesa CLASSE MEDIA                                                  [br][br]
## con Scuduo: +1 DIF+1 (2 DIF, 2 DIF+1)
func _on_difesa_pressed() -> void:
	# resetta variabili
	reset()
	
	# tiri dadi DIF
	risultato = tira(N_MEDIA["DIF"], DIFESA)
	riduzione += risultato["valore"]
	terminale.text += risultato["testo"]
	
	# tiri dadi DIF+1
	risultato = tira(N_MEDIA["DIF+1"] + scudo, DIFESA_PIU1)
	riduzione += risultato["valore"]
	terminale.text += risultato["testo"]
	
	# risultati
	terminale.text += "\nRIDUZIONE:  " + str(riduzione)
	
	# inserisci danni ricevuti e calcola danni subiti
	info_danni = await inserisci_danni_ricevuti()
	danni_subiti = danno_subito(info_danni, riduzione, terminale)

## Cura SALVEZZA DI MERCURIO
func _on_mercurio_pressed() -> void:
	# resetta variabili
	reset()
	
	# inizializza al valore costante
	cura += 4
	
	# tiri dadi ARC
	risultato = tira(1, ARCANO)
	cura += risultato["valore"]
	terminale.text += risultato["testo"]
	
	# risultati
	terminale.text += "\nCURA:  " + str(cura)
