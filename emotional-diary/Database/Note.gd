class_name Note

extends Object

var id: int
var dateTime: String
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
		"dateTime": dateTime,
		"text": text
	}
