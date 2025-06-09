class_name player_shoot_component
extends Node
var shoot_vector: Vector2;
var shoot_now: bool;

@onready var line_2d: Line2D = $Line2D
@onready var parent: Node2D = $".."

@onready var bullet: PackedScene = load("res://scenes/prefabs/Bullet.tscn");
@export var bullet_speed = 100;

@export var damage: float = 2;

@export var self_body: CollisionObject2D;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	line_2d.points = [
		parent.global_position + (shoot_vector * 10),
		parent.global_position + (shoot_vector * 14)
	]
	
	
	if (Input.is_action_just_pressed("shoot_now")):
		if (shoot_vector != Vector2.ZERO):
			var scn = bullet.instantiate()
			scn.global_rotation = shoot_vector.angle()
			scn.global_position = parent.global_position + (shoot_vector * 10)
			scn.bullet_speed = bullet_speed
			scn.ignore_body = self_body
			scn.bullet_damage = damage
			get_tree().root.get_child(0).add_child(scn)
