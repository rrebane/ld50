extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.connect("body_entered", self, "on_body_entered")
	pass # Replace with function body.

func on_body_entered(body):
	if body.is_in_group("monster"):
		$AnimationPlayer.play("Break")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
