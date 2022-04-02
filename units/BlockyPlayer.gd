extends KinematicBody2D

export (float) var SPEED = 200.0

var velocity := Vector2.ZERO
var direction = 1

var held_item : Food = null

onready var STATES = {
	"Move": $States/Move,
}
onready var fsm = FSM.new(self, $States, STATES["Move"], true)
onready var item_holder : Position2D = $RotationParent/ItemPosition
onready var interact_range : Area2D = $RotationParent/InteractRange
onready var rotation_parent = $RotationParent
onready var anim = $AnimationPlayer

func _physics_process(delta):
	fsm.run_machine(delta)
	# Pick and throw logic
	if Input.is_action_just_pressed("pick_up"):
		if not held_item:
			var targets = interact_range.get_overlapping_bodies()
			if targets.size() > 0:
				held_item = targets[0]
				held_item.get_parent().remove_child(held_item)
				item_holder.add_child(held_item)
				held_item.global_position = item_holder.global_position
		else:
			item_holder.remove_child(held_item)
			get_parent().add_child(held_item)
			held_item.global_position = item_holder.global_position
			held_item.throw(global_position, direction)
			held_item = null


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
