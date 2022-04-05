extends State

var has_eaten_player := false
var targets = [] setget set_targets

func run(_delta):
	pass

func initialize():
	obj.body_anim.play("BodyEat")
	obj.hands_anim.play("HandsEat")
	if targets.size() > 0:
		for t in targets:
			var path = obj.remote_transform.get_path_to(t)
			obj.remote_transform.remote_path = path
			print(path)

	if not obj.eating_timer.is_connected("timeout", self, "on_timeout"):
		obj.eating_timer.connect("timeout", self, "on_timeout")
	obj.eating_timer.start()

func on_timeout():
	if has_eaten_player:
		print("Game over")
	else:
		obj.fsm.state_next = obj.STATES["Follow"]

func set_targets(t):
	targets = t

func terminate():
	obj.eating_timer.disconnect("timeout", self, "on_timeout")
