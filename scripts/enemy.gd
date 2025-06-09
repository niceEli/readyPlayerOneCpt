extends CharacterBody2D

var movement_speed: float = 20.0
var random_move_cooldown: float = 2.0
var random_move_timer: float = 0.0

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var raycast: RayCast2D = $Eyes
@onready var killzone: Area2D = $Killzone
@onready var die_mus: AudioStreamPlayer = $DieMus

var patrol_area_min: Vector2 = Vector2(-200, -200)
var patrol_area_max: Vector2 = Vector2(200, 200)

func _ready():
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0

	actor_setup.call_deferred()

func actor_setup():
	await get_tree().physics_frame
	set_movement_target(global_position)

func set_movement_target(movement_target: Vector2):
	navigation_agent.target_position = movement_target

func can_see_player(player_pos: Vector2) -> bool:
	raycast.global_position = global_position
	raycast.target_position = player_pos - global_position
	raycast.force_raycast_update()

	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider.is_in_group("Player"):
			return true
		else:
			return false
	return true

func get_random_patrol_point() -> Vector2:
	var rand_x = randf_range(patrol_area_min.x, patrol_area_max.x)
	var rand_y = randf_range(patrol_area_min.y, patrol_area_max.y)
	return global_position + Vector2(rand_x, rand_y)

func _physics_process(delta):
	var Players = get_tree().get_nodes_in_group("Player")

	if (Players):
		var Player = Players[0]
		if can_see_player(Player.global_position):
			set_movement_target(Player.global_position)
			random_move_timer = 0.0
		else:
			random_move_timer -= delta
			if random_move_timer <= 0.0 or navigation_agent.is_navigation_finished():
				var new_patrol_target = get_random_patrol_point()
				set_movement_target(new_patrol_target)
				random_move_timer = random_move_cooldown

	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	velocity = global_position.direction_to(next_path_position) * movement_speed
	move_and_slide()

func _on_killzone_body_entered(body: Node2D) -> void:
	if !body.is_in_group("Player"):
		return
	
	var Player: player = body;
	
	for child in Player.get_children():
		if child is health_component:
			child.hurt(4)
