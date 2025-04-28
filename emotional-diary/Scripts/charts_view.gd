extends Control

@onready var numNotes = $GridContainer/NotesCount
@onready var numEmotions = $GridContainer/emotionsCount

func _ready() -> void:
	countNotesAndEmotions()

func countNotesAndEmotions():
	var numEmotionTotal = Entry.get_total_entries()
	var numTotal = Note.get_total_notes()
	numNotes.text = str(numTotal)
	numEmotions.text = str(numEmotionTotal)

func _on_button_diary_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/calendar_screen.tscn")

func _on_button_notes_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/notes_list_screen.tscn")
