extends Control

@onready var notes_container = $Notes_list
var widget_note = preload("res://Scenes/notes_widget.tscn")

func _ready() -> void:
	show_notes()
	
func show_notes():
	# Limpiar contenedor primero
	for child in notes_container.get_children():
		child.queue_free()
	
	var all_notes = Note.get_notes_sorted_by_date()
	for note in all_notes:
		var widget = widget_note.instantiate()
		notes_container.add_child(widget)
		
		# Esperar para asegurar carga
		await get_tree().process_frame
		
		# Pasar todos los datos de la nota
		widget.set_note_data({
			"text": note.text,
			"timestamp": note.timestamp
		})

func _on_button_diary_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/calendar_screen.tscn")

func _on_button_stadistic_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/charts_view.tscn")

func _on_button_notes_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/notes_screen.tscn")
