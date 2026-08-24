extends Button

# Carica la scena dei tiri
var scena_tiri: PackedScene = load("res://scenes/tiri.tscn")

# Cambia colore del contorno quando il mouse entra nel pulsanate
func _on_mouse_entered() -> void:
	$".".add_theme_color_override("font_outline_color", Color(1, 1, 1))

# // esce dal pulsante
func _on_mouse_exited() -> void:
	$".".add_theme_color_override("font_outline_color", Color(0, 0, 0))

# Aggiungi la scena dei tiri quando il pulsante viene premuto
func _on_pressed() -> void:
	var tiri = scena_tiri.instantiate()
	$"../..".add_child(tiri)
