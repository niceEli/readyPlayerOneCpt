extends CanvasLayer

@onready var label: Label = $Label

var do_quit = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.modulate.a = do_quit
	if (Input.is_action_pressed("quit")):
		do_quit += delta
	else:
		do_quit -= delta * 2
	
	do_quit = clampf(do_quit, 0, 1)
	
	if (do_quit == 1):
		get_tree().quit(0)
