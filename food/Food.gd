extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.connect("body_entered", self, "on_body_enter")
	$Area2D.connect("body_exited", self, "on_body_exit")
	pass # Replace with function body.

func on_body_enter(body):
	if body.is_in_group("player"):
		print(body)

func on_body_exit(body):
	if body.is_in_group("player"):
		print(body)
