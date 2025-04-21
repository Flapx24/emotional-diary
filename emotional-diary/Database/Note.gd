class_name Note

extends Object

var id: int
var timestamp: int
var text: String

func _init(id: int = 0, dateTime: String = "", text: String =""):
	self.id = id
	self.dateTime = dateTime
	self.text = text

static func from_json(data: Dictionary) -> Note:
	return Note.new(
		data["id"],
		data["dateTime"],
		data["text"]
	)

func to_json() -> Dictionary:
	return {
		"id": id,
		"timestamp": timestamp,
		"text": text
	}
	
static func find_by_id(note_id:int):
	for note in Database.notes:
		if note.id == note_id:
			return note
