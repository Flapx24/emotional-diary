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

func _init(id: int = 0, timestamp: int = 0, emotion: Emotion = Emotion.HAPPY, text: String = ""):
	self.id = id
	self.timestamp = timestamp
	self.emotion = emotion
	self.text = text

static func from_json(data: Dictionary) -> Entry:
	return Entry.new(
		data["id"],
		int(data["timestamp"]),
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
			
static func filter_by_emotion(emotion_type: Emotion) -> Array:
	var filtered_entries = []
	for entry in Database.entries:
		if entry.emotion == emotion_type:
			filtered_entries.append(entry)
	return filtered_entries
	
# Filters entries within a date range
# date_format: "YYYY-MM-DD" (e.g. "2025-04-22")
# If end_date is empty, it will only search for entries on start_date
static func filter_by_date(start_date: String, end_date: String = "") -> Array:
	var filtered_entries = []
	
	var start_timestamp = Time.get_unix_time_from_datetime_string(start_date + " 00:00:00")
	
	var end_timestamp = start_timestamp + 86400  # Default: end of start_date (24 hours later)
	
	if end_date != "":
		end_timestamp = Time.get_unix_time_from_datetime_string(end_date + " 23:59:59")
	
	for entry in Database.entries:
		if entry.timestamp >= start_timestamp and entry.timestamp < end_timestamp:
			filtered_entries.append(entry)
	
	return filtered_entries
