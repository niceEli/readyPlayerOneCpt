class_name ingame_ui
extends Control
@onready var healthbar: ProgressBar = $Health

var health: float:
	get:
		return healthbar.value
	set(value):
		healthbar.value = value
