extends Control

var unit_selected = []
var is_selecting = false

onready var units = get_tree().get_nodes_in_group("units")[0]

func _ready():
	draw_selection(PoolVector2Array([Vector2(0,0),Vector2(0,0),Vector2(0,0),Vector2(0,0)]))
	$Area2D.connect("area_entered", self, "selection", [true])
	$Area2D.connect("area_exited", self, "selection", [false])
	is_selecting = false

func _input(event):
	if event is InputEventMouseMotion && is_selecting:
		var mouse = get_global_mouse_position()
		var pos = $Area2D/CollisionShape2D.shape.get_points()[0]
		draw_selection(PoolVector2Array(
			[Vector2(pos.x,pos.y),Vector2(mouse.x,pos.y),mouse,Vector2(pos.x,mouse.y)]
		))

	if event.is_action_released("select") && is_selecting:
		units.selection_ended(unit_selected)
		end_selection()

	if event.is_action_pressed("select"):
		if not is_selecting:
			is_selecting = true
			units.reset_selection()
		else:
			end_selection()

		if is_selecting:
			draw_selection(PoolVector2Array(
				[
					get_global_mouse_position(),
					get_global_mouse_position(),
					get_global_mouse_position(),
					get_global_mouse_position()
				]
			))

func end_selection():
	is_selecting = false
	draw_selection(PoolVector2Array([Vector2(0,0),Vector2(0,0),Vector2(0,0),Vector2(0,0)]))
	unit_selected = []

func selection(area, selected):
	if area.is_in_group("unit_area"):
		var unit = area.get_parent()
		units.select_unit(unit, selected)
		if selected:
			unit_selected.append(unit)
		else:
			unit_selected.erase(unit)

func draw_selection(pos):
	$Area2D/CollisionShape2D.shape.set_points(pos)
	$SelectShape.set_begin(Vector2(min(pos[0].x,pos[2].x),min(pos[0].y,pos[2].y)))
	$SelectShape.set_end(Vector2(max(pos[0].x,pos[2].x),max(pos[0].y,pos[2].y)))
