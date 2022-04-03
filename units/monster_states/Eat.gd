extends State

var has_eaten_player := false

func run(_delta):
	pass

func initialize():
	obj.body_anim.play("BodyEat")
	obj.hands_anim.play("HandsEat")
	if not obj.eating_timer.is_connected("timeout", self, "on_timeout"):
		obj.eating_timer.connect("timeout", self, "on_timeout")
	obj.eating_timer.start()

func on_timeout():
	if has_eaten_player:
		print("Game over")
	else:
		obj.fsm.state_next = obj.STATES["Follow"]

