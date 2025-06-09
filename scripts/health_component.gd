class_name health_component
extends Node2D

@onready var ht: PackedScene = load("res://scenes/prefabs/health_text.tscn");

@export var max_health: float = 20;

var m_health: float = 20;

@export var health: float = 20:
	get: 
		return m_health
	set(value):
		m_health = clampf(value, 0, max_health);
		
		if (m_health == 0): 
			var parent = get_parent();
			if (parent):
				parent.queue_free();

func heal(amount: float = 1) -> float:
	health += amount;

	return health;

func hurt(amount: float = 1) -> float:
	health -= amount;
	
	var health_tex: health_text = ht.instantiate();
	health_tex.amount = -amount
	health_tex.global_position = global_position
	
	get_tree().root.get_child(0).add_child(health_tex)

	return health;
	
