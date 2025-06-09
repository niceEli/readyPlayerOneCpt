class_name health_component
extends Node2D

@onready var ht: PackedScene = load("res://scenes/prefabs/health_text.tscn");

@export var max_health: float = 20;

@export var delete_node: bool = true;

var m_health: float = 20;

@export var health: float = 20:
	get: 
		return m_health
	set(value):
		m_health = clampf(value, 0, max_health);
		
		if (m_health == 0): 
			if (delete_node):
				var parent = get_parent();
				if (parent):
					parent.queue_free();
			await get_tree().process_frame
			on_die.emit()

func heal(amount: float = 1) -> float:
	return hurt(-amount)

func hurt(amount: float = 1) -> float:
	
	var health_tex: health_text = ht.instantiate();
	health_tex.amount = -amount
	health_tex.global_position = global_position
	
	get_tree().current_scene.add_child(health_tex)
	
	health -= amount;

	return health;
	
signal on_die()
