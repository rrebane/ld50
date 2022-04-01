extends Node2D

onready var navigation = get_tree().get_nodes_in_group("navigation")[0]
onready var line = load("res://ui/Line.tscn").instance()

var _path: PoolVector2Array

func move_to_position(target_position):
	set_process(true)
	_path = _path_to_target(target_position)
	_path.insert(0, position)
	line.points = _path

func _ready():
	get_parent().call_deferred("add_child", line)
	set_process(false)

func _process(delta: float):
	if _path.size() > 1:
		var d: float = position.distance_to(_path[1])
		if d > 5:
			position = position.linear_interpolate(_path[1], (200 * delta)/d)
			look_at(_path[1])
		else:
			_path.remove(1)
		_path[0] = position
		line.points = _path
	else:
		set_process(false)

func _path_to_target(target_position):
	var path = navigation.get_simple_path(position, target_position, false)
	
	if path.size() > 1:
		var lastPoint = path[-1]
		var cellSize = 64
		lastPoint.x = floor(lastPoint.x / 64) * 64
		path[-1]

		var space_state = get_world_2d().direct_space_state
		
		var i = 0
		while i < path.size():
			var size = path.size()
			
			for j in range(i+1, size):
				var result = space_state.intersect_ray(path[i], path[size-j-1], [self])
				if result.empty():
					for k in range(i+1, size-j-1):
						path.remove(i+1)
					break
			
			i += 1
		
		path.remove(0)
	
	return path
