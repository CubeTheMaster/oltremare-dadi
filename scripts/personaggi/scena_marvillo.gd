extends CharacterClass # MARVILLO

# ----------------------------- V A R I A B I L I -----------------------------
## INTERFACCIA
# Pulsanti
@onready var pugnale = %Pugnale.button_pressed
@onready var bacco = %"Difesa Bacco".button_pressed

## COSTANTI
# Buff
const AQUILA: Dictionary = {"DIF": 1, "SCH": 1}                   # tecnica imparata dal Re in Rosso
const OMNIFORGIA: int = 3                                # arma perfezionata dalle omniforge di Eden

# ------------------------------- O P Z I O N I -------------------------------
## PUGNALE
func _on_pugnale_toggled(toggled_on: bool) -> void:
	pugnale = toggled_on

## DIFESA BACCO
func _on_difesa_bacco_toggled(toggled_on: bool) -> void:
	bacco = toggled_on

# -------------------------------- A Z I O N I --------------------------------
# - Attacchi MELEE -
## Attacco STOCCO (2 ATT, 2 ATT+1)                                      [br][br]
## + Omniforgia: +3 ATT+1 (2 ATT, 5 ATT+1)                              [br][br]
## con Pugnale: +1 ATT (3 ATT, 5 ATT+1)
func _on_stocco_pressed() -> void:
	# resetta variabili
	reset()
	
	# inizializza il danno al valore del M.AM
	danni += int(m_AM.value)
	
	# tiri dadi ATT
	risultato = tira(2 + int(pugnale), ATTACCO)
	danni += risultato["valore"]
	terminale.text += risultato["testo"]
	
	# tiri dadi ATT+1
	risultato = tira(2 + OMNIFORGIA, ATTACCO_PIU1)
	danni += risultato["valore"]
	terminale.text += risultato["testo"]
	
	# risultati
	terminale.text += "\nDANNI:  " + str(danni) + " Perforanti"

## Attacco ASSALTO PICENO (5 ATT, 5 ATT+1)                              [br][br]
## + Omniforgia: +3 ATT+1 (2 ATT, 8 ATT+1)
func _on_assalto_piceno_pressed() -> void:
	# resetta variabili
	reset()
	
	# inizializza il danno al valore del M.AM
	danni += int(m_AM.value)
	
	# tiri dadi ATT
	risultato = tira(5, ATTACCO)
	danni += risultato["valore"]
	terminale.text += risultato["testo"]
	
	# tiri dadi ATT+1
	risultato = tira(5 + OMNIFORGIA, ATTACCO_PIU1)
	danni += risultato["valore"]
	terminale.text += risultato["testo"]
	
	# risultati
	var danni_separati = int(ceil(danni/2.0))
	terminale.text += "\nDANNI:  " + str(danni_separati) + " Bruti"
	terminale.text += " + " + str(danni_separati) + " Perforanti"

# - Difese -
## Difesa CLASSE LEGGERA                                                [br][br]
## + Aquila Intoccabile: +1 DIF, +1 SCH (2 DIF, 2 SCH)                  [br][br]
## con Pugnale: +1 DIF (3 DIF, 2 SCH)                                   [br][br]
## con Bacco: +3 DIF+1 (3 DIF, 3 DIF+1, 2 SCH)
func _on_difesa_pressed() -> void:
	# resetta variabili
	reset()
	
	# tiri dadi DIF
	risultato = tira(N_LEGGERA["DIF"] + 1*int(pugnale) + AQUILA["DIF"], DIFESA)
	riduzione += risultato["valore"]
	terminale.text += risultato["testo"]
	
	# tiri dadi DIF+1
	if bacco:
		risultato = tira(3, DIFESA_PIU1)
		riduzione += risultato["valore"]
		terminale.text += risultato["testo"]
	
	# tiri dadi SCH
	risultato = tira(N_LEGGERA["SCH"] + AQUILA["SCH"], SCHIVATA)
	riduzione += risultato["valore"]
	terminale.text += risultato["testo"]
	
	# verifica schivata
	if schivata(riduzione, terminale):
		return
	
	# inserisci danni ricevuti e calcola danni subiti
	info_danni = await inserisci_danni_ricevuti()
	danni_subiti = danno_subito(info_danni, riduzione, terminale)

# - Altro -
## MACARENA
func _on_macarena_pressed() -> void:
	# aggiungi il nodo di tipo video
	var nodo_macarena = VideoStreamPlayer.new()
	nodo_macarena.set_name("Macarena")
	nodo_macarena.finished.connect($"."._on_macarena_finished)
	$Finestra.add_child(nodo_macarena)
	
	# imposta il nodo
	var indirizzo_macarena = "res://textures/varie/Los Del Rio - Macarena (Bayside Boys Remix) [cut].ogv"
	$Finestra/Macarena.expand = true
	$Finestra/Macarena.stream = load(indirizzo_macarena)
	
	# fai partire il video
	$Finestra/Macarena.play()
	
	# quando finisce rimuovi il nodo
func _on_macarena_finished() -> void:
	$Finestra/Macarena.queue_free()
