extends Area2D

@export var bullet_speed: float;
@export var ignore_body: CollisionObject2D;
@export var bullet_damage: float;
@onready var sfx: AudioStreamPlayer = $sfx

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sfx.play(0.1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	global_position = global_position + (Vector2.from_angle(global_rotation) * delta * bullet_speed)


func _on_timer_timeout() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if (body == ignore_body):
		return
		
	for child in body.get_children():
		if child is health_component:
			child.hurt(bullet_damage)
	queue_free()
