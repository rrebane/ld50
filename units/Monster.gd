extends KinematicBody2D

var velocity = Vector2.ZERO
var target_global_position = Vector2.ZERO

export(NodePath) var player_path

var player_node : KinematicBody2D = null

onready var STATES = {
	"Follow": $States/Follow,
}

onready var fsm = FSM.new(self, $States, STATES["Follow"], true)
onready var rotation_container = $Rotation
onready var body_anim = $BodyAnimationPlayer
onready var hands_anim = $HandsAnimationPlayer

func _ready():
	$Rotation/FoodDetector.connect("body_entered", self, "body_entered_fooddetector")
	if player_path:
		player_node = get_node(player_path)


func _physics_process(delta):
	fsm.run_machine(delta)

func body_entered_fooddetector(body):
	print(body)
	if body.is_in_group("food"):
		print(body)
