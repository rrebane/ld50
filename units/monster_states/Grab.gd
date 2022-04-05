extends State

var targets = []

func run(_delta):
	pass

func initialize():
	# This is a doozy
	# Player appropriate animations
	# Connect the Area2D in the hand, the ArmFoodDetector
	# If during the swing, a body overlaps the hand
	# # Save the target
	# When the animation is finished, if there are targets, eat the targets
	# if not, go back to follow animation
	# On state exit, disconnect the signals and reset the targets
	obj.body_anim.play("BodyRest")
	obj.hands_anim.play("HandsGrab")
	if not obj.hand_detector.is_connected("body_entered", self, "on_body_in_hand"):
		obj.hand_detector.connect("body_entered", self, "on_body_in_hand")

	if not obj.hands_anim.is_connected("animation_finished", self, "animation_finished"):
		obj.hands_anim.connect("animation_finished", self, "animation_finished")


func on_body_in_hand(body):
	if body.is_in_group("food") or body.is_in_group("player"):
		targets.append(body)

func animation_finished(name):
	if name == "HandsGrab":
		if targets.size() > 0:
			obj.STATES["Eat"].set_targets(targets)
			obj.fsm.state_next = obj.STATES["Eat"]
		else:
			obj.fsm.state_next = obj.STATES["Follow"]

func terminate():
	targets = []
	obj.hand_detector.disconnect("body_entered", self, "on_body_in_hand")
	obj.hands_anim.disconnect("animation_finished", self, "animation_finished")
