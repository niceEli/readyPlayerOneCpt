class_name global
extends Node

var points: int = 0;
var scene : Node = Node.new();

func _process(_delta: float) -> void:
	if get_tree().current_scene != scene:
		scene = get_tree().current_scene
		points = 0
	
	if points == 3:
		get_tree().change_scene_to_file("uid://dxsdlfjjyprjy")
