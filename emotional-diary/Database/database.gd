extends Node

var entries:Array=[]
var notes:Array=[]

func _ready():
	_load_database()

func _load_database():
	var file=FileAccess.open("res://database/database.json",FileAccess.READ)
	if file:
		var text=file.get_as_text()
		var database=JSON.parse_string(text)
		_read_json(database)
	else:
		assert(false,"Error loading database")
		get_tree().quit(1)

func _read_json(json):
	entries=_read_json_array(json["entries"], Entry)
	notes=_read_json_array(json["notes"], Note)

func _read_json_array(json,type):
	var array=[]
	for element in json:
		array.append(type.new())
		array.back().from_json(element)
	return array

func update_database():
	var json_database = {}
	
	json_database["entries"] = array_to_json(entries)
	json_database["notes"] = array_to_json(notes)
	
	var file = FileAccess.open("res://database/database.json", FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(json_database, "\t", false))
	else:
		push_error("Error saving database")

func array_to_json(array):
	var json_array = []
	for element in array:
		json_array.append(element.to_json())
	return json_array

func add(element):
	if element is Entry:
		element.id=entries.back().id+1
		element.timestamp = Time.get_unix_time_from_system()
		entries.append(element)
	elif element is Note:
		element.id=notes.back().id+1
		element.timestamp = Time.get_unix_time_from_system()
		notes.append(element)
	update_database()
	
func update_element(element):
	if element is Entry:
		var entry:Entry = Entry.find_by_id(element.id)
		entry.text = element.text
		entry.emotion = element.emotion
		update_database()
	elif element is Note:
		var note:Note = Note.find_by_id(element.id)
		note.text = element.text
		note.timestamp = Time.get_unix_time_from_system()
		update_database()
		
func remove(type,element_id:int) -> bool:
	if type==Entry:
		return _remove_database_array_element_by_id(entries,element_id)
	elif type==Note:
		return _remove_database_array_element_by_id(notes,element_id)
	else:
		return false

func _remove_database_array_element_by_id(array:Array,id:int) -> bool:
	var index:=-1
	for i in array.size():
		if array[i].id==id:
			index=i
			break
	if index!=-1:
		array.remove_at(index)
		update_database()
		return true
	else:
		return false
