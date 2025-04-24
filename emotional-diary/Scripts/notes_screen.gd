extends Control
@onready var noteTitle = $TextEditContent
@onready var noteContent = $TextEditTitle
@onready var db = $"/root/Database"


func _on_button_save_pressed() -> void:
	var title = noteTitle.text.strip_edges()
	var content = noteContent.text.strip_edges()
	
	if title != "" and content != "":
		var newNote = Note.new()
		newNote.text = "%s\n\n%s" % [title, content]
		db.add(newNote)
		noteTitle.text = ""
		noteContent.text = ""
	else:
		print("El título y el contenido no pueden estar vacíos.")


func _on_button_cancel_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/calendar_screen.tscn")
