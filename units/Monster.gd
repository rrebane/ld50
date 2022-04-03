extends KinematicBody2D

var velocity = Vector2.ZERO
var target_global_position = Vector2.ZERO
var MAX_SPEED = 100

export(NodePath) var player_path

var player_node : KinematicBody2D = null

func _ready():
	if player_path:
		player_node = get_node(player_path)
		if player_node:
			target_global_position = player_node.global_position
			$BodyAnimationPlayer.play("BodyRun")
			$HandsAnimationPlayer.play("HandsRun")

func _physics_process(delta):
	target_global_position = player_node.global_position
	velocity = Steering.arrive_to(
		velocity,
		global_position,
		target_global_position,
		MAX_SPEED
	)
	velocity = move_and_slide(velocity)
	if target_global_position.x > global_position.x:
		$Rotation.scale.x = 1
	if target_global_position.x < global_position.x:
		$Rotation.scale.x = -1
