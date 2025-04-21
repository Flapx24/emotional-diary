class_name Entry

extends Object

enum Emotion {
	HAPPY,
	SAD,
	EXCITED,
	ANGRY,
	CALM
}

var id: int
var timestamp: int
var emotion: Emotion
var text: String

func _init(id: int = 0, date: String = "", emotion: Emotion = Emotion.HAPPY, text: String = ""):
	self.id = id
	self.date = date
	self.emotion = emotion
	self.text = text

static func from_json(data: Dictionary) -> Entry:
	return Entry.new(
		data["id"],
		data["date"],
		Emotion[data["emotion"].to_upper()],
		data["text"]
	)

func to_json() -> Dictionary:
	return {
		"id": id,
		"timestamp": timestamp,
		"emotion": Emotion.keys()[emotion],
		"text": text
	}

static func find_by_id(entry_id:int):
	for entry in Database.entries:
		if entry.id == entry_id:
			return entry
