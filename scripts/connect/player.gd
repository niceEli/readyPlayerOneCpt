extends CharacterBody2D

@onready var move: player_move_component = $PlayerMoveComponent
@onready var shoot: player_shoot_component = $PlayerShootComponent
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var ui: ingame_ui = $Canvas/IngameUi
@onready var health: health_component = $HealthComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var move_vec = Input.get_vector("move_left", "move_right", "move_up", "move_down");
	move.input_vector = move_vec

	if (move_vec != Vector2.ZERO):
		sprite.animation = "walking"
	else:
		sprite.animation = "still"
		
	if (move_vec.x < 0):
		sprite.flip_h = true
	if (move_vec.x > 0):
		sprite.flip_h = false

	shoot.shoot_vector = Input.get_vector("shoot_left", "shoot_right", "shoot_up", "shoot_down");
	
	shoot.shoot_now = Input.is_action_just_pressed("shoot_now")
	
	if (health.health != 0 && health.max_health != 0):
		ui.health = health.health / health.max_health
	
