class_name player_move_component
extends Node
var input_vector: Vector2;

@onready var parent: CharacterBody2D = $"..";

@export var moveSpeed: float = 300;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	parent.velocity = input_vector * ( moveSpeed * 120 ) * delta
	
	parent.move_and_slide()
