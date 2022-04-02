extends KinematicBody2D

export (float) var SPEED = 200.0

var velocity := Vector2.ZERO

onready var STATES = {
	"Move": $States/Move,
}
onready var fsm = FSM.new(self, $States, STATES["Move"], true)

func _physics_process(delta):
	fsm.run_machine(delta)


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
