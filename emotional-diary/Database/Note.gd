class_name Note

extends Object

var id: int
var timestamp: int
var text: String

func _init(id: int = 0, timestamp: int = 0, text: String =""):
	self.id = id
	self.timestamp = timestamp
	self.text = text

static func from_json(data: Dictionary) -> Note:
	return Note.new(
		data["id"],
		int(data["timestamp"]),
		data["text"]
	)

func to_json() -> Dictionary:
	return {
		"id": id,
		"timestamp": timestamp,
		"text": text
	}

static func get_notes_sorted_by_date() -> Array:
	var sorted_notes = Database.notes.duplicate()
	sorted_notes.sort_custom(func(a, b): return a.timestamp > b.timestamp)
	return sorted_notes
