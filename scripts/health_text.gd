class_name health_text;
extends Node2D;

@export var amount: float;

@onready var label: Label = $Label

@export var heal_color: Color;
@export var zero_color: Color;
@export var hurt_color: Color;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.label_settings = label.label_settings.duplicate()
	
	if roundi(amount) > 0:
		label.label_settings.font_color = heal_color
	if roundi(amount) < 0:
		label.label_settings.font_color = hurt_color
		amount = -amount
	if roundi(amount) == 0:
		label.label_settings.font_color = zero_color

	label.text = str(roundi(amount))
