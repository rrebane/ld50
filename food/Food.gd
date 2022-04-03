extends KinematicBody2D
class_name Food

var THROW_SPEED := Vector2(100, 0)
var DRAG := Vector2(2, 0)
var velocity := Vector2.ZERO
var is_being_eaten := false

func _physics_process(delta):
	if abs(velocity.x) < 5:
		velocity = Vector2.ZERO
	else:
		var drag_direction = -1 if velocity.x > 0 else 1
		velocity += DRAG * drag_direction
	velocity = move_and_slide(velocity)

func throw(player_position, dir):
	if is_being_eaten:
		return
	velocity = THROW_SPEED * dir
	pass

func get_eaten(mouth_global_position):
	is_being_eaten = true
	var tween = Tween.new()
	add_child(tween)
	tween.interpolate_property(
		self, "global_position",
		global_position, mouth_global_position, 0.2,
		Tween.TRANS_QUAD, Tween.EASE_IN)
	tween.interpolate_property(
		self, "scale",
		null, Vector2(0.5, 0.5), 0.2,
		Tween.TRANS_QUAD, Tween.EASE_IN)
	tween.start()
	tween.connect("tween_all_completed", self, "queue_free")
