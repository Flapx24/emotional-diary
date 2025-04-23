extends Control

@onready var notes = $Notes_list
var widgetNote = preload("res://Scenes/notes_widget.tscn")

func _ready() -> void:
	showNotes()
	
func showNotes():
	var notes = Note.get_notes_sorted_by_date()
	for note in notes:
		var widget = widgetNote.instantiate()
		widget.noteText(note.text)
		notes.add_child(widget)

func _on_button_diary_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/calendar_screen.tscn")


func _on_button_stadistic_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/charts_view.tscn")
