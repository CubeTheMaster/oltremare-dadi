extends CharacterClass # NOSVAR

# ----------------------------- V A R I A B I L I -----------------------------
## INTERFACCIA
# Contatori
@onready var punti_frenesia: SpinBox = %Punti

# Pulsanti
@onready var frenesia = %Frenesia.button_pressed
@onready var braccio_demoniaco = %"Braccio Demoniaco".button_pressed

## COSTANTI
# Malus
const BRACCIO_PERSO: int = -5                           # usa un'arma a due mani con un braccio solo
const INESPERTO: int = -2                  # non è addestrato nell'utilizzo di armi diverse da falci

# ------------------------------- O P Z I O N I -------------------------------
## FRENESIA
func _on_frenesia_toggled(toggled_on: bool) -> void:
	frenesia = toggled_on
	if !frenesia:             # resetta le stack quando la frenesia si disattiva
		punti_frenesia.value = 0

## BRACCIO DEMONIACO
func _on_braccio_demoniaco_toggled(toggled_on: bool) -> void:
	braccio_demoniaco = toggled_on
	if braccio_demoniaco:
		m_AM.value += 1
	else:
		m_AM.value -= 1

# -------------------------------- A Z I O N I --------------------------------
# - Attacchi MELEE -
## Attacco ROSSO ARTIGLIO (4 ATT, 3 ATT+1)
func _on_falce_pressed() -> void:
	# resetta variabili
	reset()
	
	# inizializza il danno al valore del M.AM
	# +1 se l'arma è impugnata a due mani 
	# -malus se ha un braccio solo
	danni += int(m_AM.value)
	if braccio_demoniaco:
		danni += 1
	else:
		danni += BRACCIO_PERSO
		terminale.text += "MALUS: " + str(BRACCIO_PERSO) + " danni\n\n"
	
	# tiri dadi ATT
	risultato = tira(4, ATTACCO)
	danni += risultato["valore"]
	terminale.text += risultato["testo"]
	
	# tiri dadi ATT+1
	risultato = tira(3, ATTACCO_PIU1)
	danni += risultato["valore"]
	terminale.text += risultato["testo"]
	
	# se la frenesia è attiva, aggiungila al danno e incrementala
	if frenesia:
		var bonus = int(punti_frenesia.value)
		terminale.text += "\nbonus FRENESIA:  " + str(bonus)
		punti_frenesia.value += 1
		danni += bonus
		
		# risultati
		terminale.text += "\n\nDANNI:  " + str(danni) + " Taglienti/Perforanti - Arcano"
	else:
		terminale.text += "\nDANNI:  " + str(danni) + " Taglienti/Perforanti"

# - Difese -
## Difesa CLASSE MEDIA
func _on_difesa_pressed() -> void:
	# resetta variabili
	reset()
	
	# difesa classe MEDIA
	risultato = difesa_media()
	riduzione += risultato["valore"]
	terminale.text += risultato["testo"] + "\nRIDUZIONE:  " + str(riduzione)
