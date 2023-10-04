class_name Earth extends StaticBody2D

@onready var health: Health = $Health
@onready var sprite: Sprite2D = $Sprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var frame = int((1.0 - health.health / health.max_health) * (sprite.hframes - 1))
	sprite.frame = frame
