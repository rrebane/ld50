extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const HALF_TILE_LENGTH = 6

onready var apple = preload("res://food/Food.tscn")


		# add_child(bullet)
# Called when the node enters the scene tree for the first time.
func _ready():
	var id = tile_set.find_tile_by_name("apple")
	var cells = get_used_cells_by_id(id)
	print(cells)
	for c in cells:
		var apple_instance = apple.instance()
		add_child(apple_instance)
		apple_instance.position = tile_pos(c) + (Vector2(HALF_TILE_LENGTH, HALF_TILE_LENGTH))
		set_cell(c.x, c.y, 1)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func tile_pos(tile_pos):
	return map_to_world(tile_pos)
