extends KinematicBody2D

var velocity = Vector2.ZERO
var target_global_position = Vector2.ZERO

export(NodePath) var player_path

var player_node : KinematicBody2D = null

onready var STATES = {
	"Follow": $States/Follow,
	"Eat": $States/Eat
}

onready var fsm = FSM.new(self, $States, STATES["Follow"], true)
onready var rotation_container = $Rotation
onready var body_anim = $BodyAnimationPlayer
onready var hands_anim = $HandsAnimationPlayer
onready var food_detector = $Rotation/FoodDetector
onready var eating_timer = $EatingTimer

func _ready():
	food_detector.connect("body_entered", self, "body_entered_fooddetector")
	if player_path:
		player_node = get_node(player_path)


func _physics_process(delta):
	fsm.run_machine(delta)

func body_entered_fooddetector(body):

	if body.is_in_group("food"):
		if body.is_in_group("player"):
			STATES["Eat"].has_eaten_player = true
		eat()
		body.get_eaten($Rotation/MonsterBody/MonsterMouth.global_position)

func eat():
	var targets = food_detector.get_overlapping_bodies()
	if targets.size() > 0:
		fsm.state_next = STATES["Eat"]
		if targets.size() > 1:
			targets.remove(0)
			for t in targets:
				if t != self:
					t.queue_free()
