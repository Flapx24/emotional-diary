extends Control

@onready var title = $title
@onready var content = $content

func noteText(note: String) -> void:
	var elements = note.split("\n")

	if elements.size() > 0:
		title.text = elements[0].replace("Título: ", "")
	else:
		title.text = "Sin título"

	if elements.size() > 1:
		var content_text = ""
		for i in range(1, elements.size()):
			content_text += elements[i] + "\n"
		content.text = content_text.strip_edges() 
	else:
		content.text = "Sin contenido"
