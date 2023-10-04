class_name Generator extends RigidBody2D

@export var ring_sprite: Sprite2D
@export var ring_colors = [Color(235.0 / 255.0, 25.0 / 255.0, 25.0 / 255.0), Color(251.0 / 255.0, 242.0 / 255.0, 54.0 / 255.0), Color(153.0 / 255.0, 229.0 / 255.0, 80.0 / 255.0)]
@export var fix_speed = 2.0
@export var critical_health_percent = 0.2

var can_be_fixed: bool = false
var ring_alpha = 1.0
var ring_flicker_timer = 0.25
var player_shooting: PlayerShooting

@onready var health: Health = $Health
@onready var fix_area: Area2D = $FixingArea
@onready var fix_area_shape: CollisionShape2D = $FixingArea/CollisionShape2D
@onready var fix_marker: Sprite2D = $FixMarker
@onready var fix_bar: Sprite2D = $FixBar
@onready var fix_bar_bar: Sprite2D = $FixBar/Bar

func _ready():
	fix_area.body_entered.connect(_on_fixarea_body_entered)
	fix_area.body_exited.connect(_on_fixarea_body_exited)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if health.health > 0:
		var health_percent = health.health / health.max_health
		change_ring_color(health_percent)
		if health_percent <= critical_health_percent:
			flicker_ring(delta)
		else:
			ring_alpha = 1.0
	else:
		ring_sprite.modulate = Color("#333333")
		
	# fixing
	fix_bar.visible = false
	
	if can_be_fixed and health.health == health.max_health:
		fix_bar.visible = true
		fix_bar_bar.scale.x = health.health / health.max_health
	
	if can_be_fixed and health.health < health.max_health:
		show_fix_marker()
		
		if Input.is_action_pressed("shoot"):
			hide_fix_marker()
			do_fix(delta)
	else:
		hide_fix_marker()
	
func change_ring_color(factor: float):
	var current_color = ring_colors[0].lerp(ring_colors[1], factor)
	if factor >= 0.5:
		current_color = ring_colors[1].lerp(ring_colors[2], (factor - 0.5) * 2)
	ring_sprite.modulate = Color(current_color)
	ring_sprite.modulate.a = ring_alpha

func flicker_ring(delta):
	ring_flicker_timer -= delta
	if ring_flicker_timer <= 0:
		if ring_alpha == 1.0:
			ring_alpha = 0.3
		else:
			ring_alpha = 1.0
		ring_flicker_timer = 0.25

func show_fix_marker():
	fix_marker.visible = true
	
func hide_fix_marker():
	fix_marker.visible = false

func do_fix(delta):
	health.health += fix_speed * delta
	health.is_dead = false
	if (health.health > health.max_health):
		health.health = health.max_health
		
	fix_bar.visible = true
	fix_bar_bar.scale.x = health.health / health.max_health
	
	# TODO: some more feedback for the user

func _on_fixarea_body_entered(body: CharacterBody2D):
	if body.name == "Player": 
		can_be_fixed = true
		body.get_node("PlayerShooting").shooting_disabled = true

func _on_fixarea_body_exited(body: CharacterBody2D):
	if body.name == "Player": 
		can_be_fixed = false
		body.get_node("PlayerShooting").shooting_disabled = false
