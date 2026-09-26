extends DiceClass # MASTER

# ----------------------------- V A R I A B I L I -----------------------------
## COSTANTI
# Scene
var SCENA_TIRI: PackedScene = load("res://scenes/finestre/tiri.tscn")

# ------------------------------ F U N Z I O N I ------------------------------
## - INTERFACCIA -
# Finestre
## Apri la finestra dei tiri e gli assegna il numero di dadi inseriti
func _on_tira_pressed() -> void:
	var finestra_tiri = SCENA_TIRI.instantiate()
	
	finestra_tiri.numero_dadi_attacco          = %"Numero ATT".value
	finestra_tiri.numero_dadi_attacco_piu1     = %"Numero ATT+1".value
	finestra_tiri.numero_dadi_arcano           = %"Numero ARC".value
	finestra_tiri.numero_dadi_attacco_ADF      = %"Numero ADF".value
	finestra_tiri.numero_dadi_attacco_ADF_piu1 = %"Numero ADF+1".value
	finestra_tiri.numero_dadi_orridi           = %"Numero ORR".value
	finestra_tiri.numero_dadi_difesa           = %"Numero DIF".value
	finestra_tiri.numero_dadi_difesa_piu1      = %"Numero DIF+1".value
	finestra_tiri.numero_dadi_schivata         = %"Numero SCH".value
	
	add_child(finestra_tiri)

# Scena
## Se premi ESC torna al menu
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("indietro"):
		get_tree().change_scene_to_file("res://scenes/schermate/menu.tscn")

## Se premi la freccia indietro torna al menu
func _on_indietro_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/schermate/menu.tscn")
