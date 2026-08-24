extends Control # GIOCATORE

# Torna al menu se premi ESC
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("indietro"):
		get_tree().change_scene_to_file("res://scenes/menu.tscn")

# Torna al menu se premi la freccia indietro
func _on_indietro_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

# Vai alla scena di Carmine
func _on_carmine_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/personaggi/carmine.tscn")

# Vai alla scena di Gastone
func _on_gastone_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/personaggi/gastone.tscn")

# Vai alla scena di Marvillo
func _on_marvillo_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/personaggi/marvillo.tscn")

# Vai alla scena di Nosvar
func _on_nosvar_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/personaggi/nosvar.tscn")

# Vai alla scena di Rosario
func _on_rosario_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/personaggi/rosario.tscn")

# Vai alla scena di Trace
func _on_trace_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/personaggi/trace.tscn")
