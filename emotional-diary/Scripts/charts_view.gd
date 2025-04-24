extends Control


func _on_button_diary_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/calendar_screen.tscn")


func _on_button_notes_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/notes_list_screen.tscn")
