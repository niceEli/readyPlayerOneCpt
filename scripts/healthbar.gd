class_name ingame_ui
extends Control
@onready var healthbar: ProgressBar = $Health
@onready var eggs: Label = $Eggs

var health: float:
	get:
		return healthbar.value
	set(value):
		healthbar.value = value

func _process(_delta: float) -> void:
	eggs.text = str(Global.points) + "/3 Keys"
