extends State

var velocity := Vector2.ZERO

func run(_delta):
	var dir = Vector2.ZERO
	if Input.is_action_pressed("right"):
		dir += Vector2.RIGHT

	if Input.is_action_pressed("left"):
		dir += Vector2.LEFT

	if Input.is_action_pressed("up"):
		dir += Vector2.UP

	if Input.is_action_pressed("down"):
		dir += Vector2.DOWN

	if dir.x and dir.y:
		dir = dir * 0.5


	var velocity = dir * obj.SPEED
	obj.velocity = obj.move_and_slide(velocity)
