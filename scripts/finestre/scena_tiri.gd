extends DiceClass

# ----------------------------- V A R I A B I L I -----------------------------
## NUMERO DADI
var numero_dadi_attacco          : int
var numero_dadi_attacco_piu1     : int
var numero_dadi_arcano           : int
var numero_dadi_attacco_ADF      : int
var numero_dadi_attacco_ADF_piu1 : int
var numero_dadi_orridi           : int
var numero_dadi_difesa           : int
var numero_dadi_difesa_piu1      : int
var numero_dadi_schivata         : int

# ------------------------------ F U N Z I O N I ------------------------------
## Ready (eseguito all'istante)
## Se il numero di dadi è maggiore di 0 tirali e mostra i risultati
func _ready() -> void:
	var risultato : Dictionary
	%Testo.text = ""
	
	# Attacco
	if numero_dadi_attacco > 0 :
		risultato = tira(numero_dadi_attacco, ATTACCO)
		%Testo.text += "ATTACCO: \n"
		%Testo.text += "Dadi: " + str(risultato["tiri"]) + "\n"
		%Testo.text += "Totale: " + str(risultato["valore"]) + "\n\n"
	
	# Attacco +1
	if numero_dadi_attacco_piu1 > 0 :
		risultato = tira(numero_dadi_attacco_piu1, ATTACCO_PIU1)
		%Testo.text += "ATTACCO +1: \n"
		%Testo.text += "Dadi: " + str(risultato["tiri"]) + "\n"
		%Testo.text += "Totale: " + str(risultato["valore"]) + "\n\n"
	
	# Arcano
	if numero_dadi_arcano > 0 :
		risultato = tira(numero_dadi_arcano, ARCANO)
		%Testo.text += "ARCANO: \n"
		%Testo.text += "Dadi: " + str(risultato["tiri"]) + "\n"
		%Testo.text += "Totale: " + str(risultato["valore"]) + "\n\n"
	
	# Attacco ADF
	if numero_dadi_attacco_ADF > 0 :
		risultato = tira(numero_dadi_attacco_ADF, ATTACCO_ADF)
		%Testo.text += "ATTACCO ARMA DA FUOCO: \n"
		%Testo.text += "Dadi: " + str(risultato["tiri"]) + "\n"
		%Testo.text += "Totale: " + str(risultato["valore"]) + "\n\n"
	
	# Attacco ADF +1
	if numero_dadi_attacco_ADF_piu1 > 0 :
		risultato = tira(numero_dadi_attacco_ADF_piu1, ATTACCO_ADF_PIU1)
		%Testo.text += "ATTACCO ARMA DA FUOCO +1: \n"
		%Testo.text += "Dadi: " + str(risultato["tiri"]) + "\n"
		%Testo.text += "Totale: " + str(risultato["valore"]) + "\n\n"
	
	# Orrido
	if numero_dadi_orridi > 0 :
		risultato = tira(numero_dadi_orridi, ORRIDO)
		%Testo.text += "ORRIDO: \n"
		%Testo.text += "Dadi: " + str(risultato["tiri"]) + "\n"
		%Testo.text += "Totale: " 
		for dadi in risultato["valore"]:
			%Testo.text += dadi["nome"] + ", "
		%Testo.text.substr(0,len(%Testo.text)-2)
		%Testo.text += "\n\n"
	
	# Difesa
	if numero_dadi_difesa > 0 :
		risultato = tira(numero_dadi_difesa, DIFESA)
		%Testo.text += "DIFESA: \n"
		%Testo.text += "Dadi: " + str(risultato["tiri"]) + "\n"
		%Testo.text += "Totale: " + str(risultato["valore"]) + "\n\n"
	
	# Difesa +1
	if numero_dadi_difesa_piu1 > 0 :
		risultato = tira(numero_dadi_difesa_piu1, DIFESA_PIU1)
		%Testo.text += "DIFESA +1: \n"
		%Testo.text += "Dadi: " + str(risultato["tiri"]) + "\n"
		%Testo.text += "Totale: " + str(risultato["valore"]) + "\n\n"
	
	# Schivata
	if numero_dadi_schivata > 0 :
		risultato = tira(numero_dadi_schivata, SCHIVATA)
		%Testo.text += "SCHIVATA: \n"
		%Testo.text += "Dadi: " + str(risultato["tiri"]) + "\n"
		if risultato["valore"] < INF :
			%Testo.text += "Totale: " + str(risultato["valore"]) + "\n\n"
		else :
			%Testo.text += "SCHIVA!\n\n"
	
	# Segnala se nessun dado è stato tirato, altrimenti togli gli ultimi \n inutili
	if %Testo.text == "" :
		%Testo.text = "Nessun dado selezionato"
	else :
		%Testo.text = %Testo.text.substr(0,len(%Testo.text)-2)

## Se premi il tasto ❌ chiudi
func _on_x_pressed() -> void:
	queue_free()

## Se premi ESC chiudi
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("indietro"):
		get_viewport().set_input_as_handled()
		queue_free()

## Se premi la freccia indietro torna al menu
func _on_indietro_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/schermate/menu.tscn")
