class_name Earth extends StaticBody2D

signal earth_exploded

@onready var health: Health = $Health
@onready var sprite: Sprite2D = $Sprite2D

func _ready():
	health.died.connect(on_earth_died)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# reflect health state
	var frame = int((1.0 - health.health / health.max_health) * (sprite.hframes - 1))
	sprite.frame = frame

func on_earth_died():
	earth_exploded.emit()
