extends Control

@onready var month_year_label: Label = %MonthYearLabel
@onready var columns_box: HBoxContainer = %ColumnsBox
@onready var add_button: Button = $AddButton

const DATE_LABEL = preload("res://Scenes/DateLabel.tscn")
const MONTH_NAMES = ["January", "February", "March", "April", "May", 
	"June", "July", "August", "September", "October", "November", "December"]
const DAY_IN_UNIX_TIME = 86400

var selectedDate = Time.get_datetime_dict_from_system()
var selected_day_label: Node = null
var selected_date_dict: Dictionary = {}

func _ready() -> void:
	_set_calendar()

func _set_calendar():
	set_month_year_label()

	var firstOfMonthDate = _get_first_of_month(selectedDate)
	var firstOfMonthUnixTime = Time.get_unix_time_from_datetime_dict(firstOfMonthDate)

	var startWeekday = firstOfMonthDate.weekday - 1
	if startWeekday == -1: startWeekday = 6

	var startDate = Time.get_datetime_dict_from_unix_time(firstOfMonthUnixTime - DAY_IN_UNIX_TIME * startWeekday)
	var calculateDate = startDate

	for i in 5 * 7:
		_create_label(calculateDate, i % 7)
		calculateDate = _get_next_day(calculateDate)

	if calculateDate.month == selectedDate.month:
		for i in 7:
			_create_label(calculateDate, i % 7)
			calculateDate = _get_next_day(calculateDate)

func set_month_year_label():
	month_year_label.text = MONTH_NAMES[selectedDate.month - 1] + " " + str(selectedDate.year)

func _get_first_of_month(date: Dictionary):
	date.day = 1
	var selectedUnixTime = Time.get_unix_time_from_datetime_dict(date)
	return Time.get_datetime_dict_from_unix_time(selectedUnixTime)

func _create_label(date: Dictionary, index: int):
	var dateLabel = DATE_LABEL.instantiate()
	dateLabel.date = date
	dateLabel.connect("date_selected", _on_date_selected)
	columns_box.get_child(index).add_child(dateLabel)

	# Auto-selección del día actual
	var currentDate = Time.get_datetime_dict_from_system()
	if date.day == currentDate.day and date.month == currentDate.month and date.year == currentDate.year:
		_on_date_selected(date, dateLabel)

func _get_next_day(date: Dictionary):
	var nextDayUnixTime = Time.get_unix_time_from_datetime_dict(date) + DAY_IN_UNIX_TIME
	return Time.get_datetime_dict_from_unix_time(nextDayUnixTime)

func _on_previous_month_button_pressed() -> void:
	selectedDate.month -= 1
	_refresh_calendar()

func _on_next_month_button_pressed() -> void:
	selectedDate.month += 1
	_refresh_calendar()

func _refresh_calendar():
	if selectedDate.month > 12:
		selectedDate.month = 1
		selectedDate.year += 1
	elif selectedDate.month < 1:
		selectedDate.month = 12
		selectedDate.year -= 1

	for column in columns_box.get_children():
		for node in column.get_children():
			if node is Label: continue
			node.queue_free()

	_set_calendar()

func _on_date_selected(date: Dictionary, sender: Node):
	if selected_day_label and selected_day_label != sender:
		selected_day_label._set_unselected()

	selected_day_label = sender
	selected_day_label._set_selected()
	selected_date_dict = date

func _on_add_button_pressed():
	if selected_date_dict.is_empty():
		print("No se ha seleccionado ninguna fecha.")
		return

	get_tree().change_scene_to_file("res://Scenes/notes_screen.tscn")

func _on_button_notes_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/notes_list_screen.tscn")


func _on_button_stadistic_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/charts_view.tscn")
