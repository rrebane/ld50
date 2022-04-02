extends KinematicBody2D

export (float) var SPEED = 200.0

var velocity := Vector2.ZERO

var pickup_target : Food = null
var held_item : Food = null

onready var STATES = {
	"Move": $States/Move,
}
onready var fsm = FSM.new(self, $States, STATES["Move"], true)
onready var item_holder = $RotationParent/ItemPosition

func _physics_process(delta):
	fsm.run_machine(delta)
	# Pick and throw logic
	if Input.is_action_just_pressed("pick_up"):
		if pickup_target:
			if not held_item:
				held_item = pickup_target
			else:
				held_item.throw(global_position)
				held_item = null
				pickup_target = null

	if held_item:
		held_item.global_position = item_holder.global_position



# Mouse movement
# Works in a scene without a camera,
# With a camera there is some strange offset
#func _unhandled_input(event):
#	if event is InputEventMouseButton and event.button_index == BUTTON_RIGHT:
#		mouse_down = event.is_pressed()
#
#func _physics_process(_delta):
#	var target = get_global_mouse_position() - position
#	velocity = position.direction_to(target) * SPEED
#
#	velocity = move_and_slide(velocity)
#
#	maybe_stop()
#
#func maybe_stop():
#	if position.distance_to(target) < 10.0:
#		velocity = Vector2.ZERO
#		target = position
