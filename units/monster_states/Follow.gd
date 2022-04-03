extends State

var velocity := Vector2.ZERO
var target_global_position
var MAX_SPEED = 100

func run(_delta):
	target_global_position = obj.player_node.global_position
	obj.velocity = Steering.arrive_to(
		obj.velocity,
		obj.global_position,
		target_global_position,
		MAX_SPEED
	)
	obj.velocity = obj.move_and_slide(obj.velocity)
	if target_global_position.x > obj.global_position.x:
		obj.rotation_container.scale.x = 1
	if target_global_position.x < obj.global_position.x:
		obj.rotation_container.scale.x = -1

func initialize():
	obj.body_anim.play("BodyRun")
	obj.hands_anim.play("HandsRun")
