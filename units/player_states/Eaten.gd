extends State

var tween_target : Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func initialize():
	var tween = Tween.new()
	add_child(tween)
	tween.interpolate_property(
		obj, "global_position",
		null, tween_target, 0.2,
		Tween.TRANS_QUAD, Tween.EASE_IN)
	tween.interpolate_property(
		obj, "scale",
		null, Vector2(0.5, 0.5), 0.2,
		Tween.TRANS_QUAD, Tween.EASE_IN)
	tween.start()
	tween.connect("tween_all_completed", obj, "queue_free")
