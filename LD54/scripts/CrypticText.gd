class_name CrypticText extends Label

@export var original_text = ""
@export var change_speed = 0.25
@export var flash_original_text_probability = 0.01

var cryptic_characters = "Σ#Æ&λ?Ø$∞¢@%"
var cryptic_text = ""
var crypt_char_timer = 0.0
var temp_change_speed = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	calculate_cryptic_text()
	text = cryptic_text
	temp_change_speed = change_speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	crypt_char_timer += delta
	if crypt_char_timer >= temp_change_speed:
		if randf() > flash_original_text_probability:
			calculate_random_character()
			text = cryptic_text
			temp_change_speed = change_speed
		else:
			text = original_text
			temp_change_speed = 0.5
		crypt_char_timer = 0.0
	
func calculate_cryptic_text():
	cryptic_text = ""
	for c in original_text:
		cryptic_text += cryptic_characters[randi() % cryptic_characters.length()]
		
func calculate_random_character():
	var random_character_index = randi() % cryptic_text.length()
	cryptic_text[random_character_index] = cryptic_characters[randi() % cryptic_characters.length()]