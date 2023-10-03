class_name UIController extends CanvasLayer

@onready var wave_label: Label = $WaveLabel
@onready var wave_label_fading: UIFadingCanvasItem = $WaveLabel/UIFadingCanvasItem

func _on_game_wave_ended(wave_num: int):
	wave_label.text = "Wave " + str(wave_num+1)
	wave_label_fading.fade_in(5)
