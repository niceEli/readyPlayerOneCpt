extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if (body is player):
		for child in body.get_children():
			if child is health_component:
				child.heal(20)
				queue_free()
