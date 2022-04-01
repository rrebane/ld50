extends Unit

onready var line = load("res://ui/Line.tscn").instance()

func _ready():
	get_parent().call_deferred("add_child", line)
	set_process(false)

func _process(delta: float):
	if !move_towards_target_position(delta):
		set_process(false)
	line.points = _path

func set_target_position(target_position):
	.set_target_position(target_position)
	line.points = _path
	set_process(true)
