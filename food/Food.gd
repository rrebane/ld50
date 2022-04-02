extends Node2D
class_name Food

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var is_throwing := false
var throw_target := Vector2.ZERO
var throw_distance := 100

func _physics_process(delta):
	if is_throwing:
		if global_position < throw_target:
			global_position = lerp(global_position, throw_target, 0.2)
		else:
			is_throwing = false
	pass

func _ready():
	$Area2D.connect("body_entered", self, "on_body_enter")
	$Area2D.connect("body_exited", self, "on_body_exit")

func on_body_enter(body):
	if body.is_in_group("player"):
		body.pickup_target = self

func on_body_exit(body):
	if body.is_in_group("player"):
		body.pickup_target = null

func throw(player_position):
	throw_target = player_position + Vector2(throw_distance, 0)
	is_throwing = true
	pass
