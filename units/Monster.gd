extends KinematicBody2D

var velocity = Vector2.ZERO
var target_global_position = Vector2.ZERO

export(NodePath) var player_path

var player_node : KinematicBody2D = null

onready var STATES = {
	"Follow": $States/Follow,
	"Eat": $States/Eat,
	"Grab": $States/Grab
}

onready var fsm = FSM.new(self, $States, STATES["Follow"], true)
onready var rotation_container = $Rotation
onready var body_anim = $BodyAnimationPlayer
onready var hands_anim = $HandsAnimationPlayer
onready var proximity_detector = $Rotation/FoodDetector
onready var eating_timer = $EatingTimer
onready var hand_detector = $Rotation/MonsterArmFront/ArmFoodDetector
onready var monster_hand_node = $Rotation/MonsterArmFront/FrontArmFoodHolder
onready var remote_transform = $Rotation/MonsterArmFront/RemoteTransform2D

func _ready():
	proximity_detector.connect("body_entered", self, "body_entered_proximity")
	if player_path:
		player_node = get_node(player_path)


func _physics_process(delta):
	fsm.run_machine(delta)

func body_entered_proximity(body):
	if body.is_in_group("food") or body.is_in_group("player"):
		fsm.state_next = STATES["Grab"]


