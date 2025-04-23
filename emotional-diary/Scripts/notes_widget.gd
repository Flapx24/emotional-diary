extends Control

@onready var title_label = $NinePatchRect/title
@onready var content_label = $NinePatchRect/content

func set_note_text(note: String) -> void:
	if not title_label or not content_label:
		return
	
	var clean_note = note.strip_edges()
	if clean_note.is_empty():
		title_label.text = "Nota vacía"
		content_label.text = ""
		return
	
	var elements = clean_note.split("\n", false)
	
	title_label.text = elements[0].replace("Título: ", "").strip_edges()
	
	if elements.size() > 1:
		content_label.text = "\n".join(elements.slice(1)).strip_edges()
	else:
		content_label.text = "Sin contenido más detalles"
