extends Control # MASTER

# Se premi ESC chiudi la finestra dei tiri/torna al menu
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("indietro"):
		get_tree().change_scene_to_file("res://scenes/schermate/menu.tscn")

# Se premi la freccia indietro torna al menu
func _on_indietro_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/schermate/menu.tscn")
