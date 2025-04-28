extends Control

@onready var title_label = $NinePatchRect/title
@onready var content_label = $NinePatchRect/content
@onready var date_label = $NinePatchRect/date  # Asegúrate de añadir este Label en tu escena

func set_note_data(note_data: Dictionary) -> void:
	# Verificación de nodos
	if not title_label or not content_label or not date_label:
		push_error("Error: Faltan nodos Label en la escena")
		return
	
	# Procesar texto de la nota (como antes)
	var elements = note_data.text.split("\n", false)
	title_label.text = elements[0].replace("Título: ", "").strip_edges() if elements.size() > 0 else "Sin título"
	
	if elements.size() > 1:
		content_label.text = "\n".join(elements.slice(1)).strip_edges()
	else:
		content_label.text = "Sin contenido"
	
	# Mostrar fecha formateada
	date_label.text = _format_timestamp(note_data.timestamp)

func _format_timestamp(timestamp: int) -> String:
	var date_dict = Time.get_datetime_dict_from_unix_time(timestamp)
	return "%02d/%02d/%04d" % [date_dict.day, date_dict.month, date_dict.year]
