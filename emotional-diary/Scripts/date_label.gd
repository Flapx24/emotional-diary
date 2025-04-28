extends MarginContainer

@export var date: Dictionary

signal date_selected(date: Dictionary, sender: Node)

@onready var panel_container: PanelContainer = %PanelContainer
@onready var label: Label = %Label

var is_selected: bool = false

func _ready() -> void:
	label.text = str(date.day)
	_set_unselected()

func _set_unselected():
	is_selected = false
	var currentDate = Time.get_datetime_dict_from_system()
	var isCurrentDate = date.day == currentDate.day and date.month == currentDate.month and date.year == currentDate.year

	if isCurrentDate:
		var highlight = StyleBoxFlat.new()
		highlight.bg_color = Color.CORNFLOWER_BLUE
		panel_container.add_theme_stylebox_override("panel", highlight)
	else:
		panel_container.add_theme_stylebox_override("panel", StyleBoxEmpty.new())

func _set_selected():
	is_selected = true
	var selected_style = StyleBoxFlat.new()
	selected_style.bg_color = Color.LIGHT_CORAL
	panel_container.add_theme_stylebox_override("panel", selected_style)

func _on_button_pressed() -> void:
	emit_signal("date_selected", date, self)
