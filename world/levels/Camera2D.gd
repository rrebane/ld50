extends Camera2D

export(NodePath) var player_path

var player_node : KinematicBody2D = null
onready var initial_position = global_position

# Called when the node enters the scene tree for the first time.
func _ready():
	assert(player_path, "Player path not set in Camera!")
	player_node = get_node(player_path)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not player_node:
		return
	global_position.x = initial_position.x - player_node.global_position.x
	pass
