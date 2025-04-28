extends Control

@onready var numNotes = $"../numNotes"
@onready var numEmotions = $"../numEmotions"

func _ready():
	_draw()

func _draw():
	var totalNotes := Note.get_total_notes()
	var totalEmotions := Entry.get_total_entries()
	var barWidth := 100
	var barHeight := totalNotes * 10
	var barHeightEmotions := totalEmotions * 10
	var baseY := size.y - 30
	
	var barPosition := Vector2((size.x - barWidth) / 2, baseY - barHeight)
	var barPositionEmotions := Vector2((size.x - barWidth) / 2 + barWidth + 10, baseY - barHeightEmotions)
	var barSize := Vector2(barWidth, barHeight)

	draw_rect(Rect2(barPosition, barSize), Color(0.2, 0.6, 1.0))
	draw_rect(Rect2(barPositionEmotions, Vector2(barWidth, barHeightEmotions)), Color(0.8, 0.6, 0.2))
	numNotes.text = str(totalNotes)
	numEmotions.text = str(totalEmotions)
