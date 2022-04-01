extends Node2D

var unit_movable = []

func _input(event):
	if event.is_action_pressed("activate"):
		if unit_movable:
			_circle_formation(unit_movable, get_global_mouse_position())

func select_unit(unit, is_selected):
	if !unit in unit_movable:
		unit.get_node("Sprite").material.set_shader_param("visible", is_selected)
		unit.get_node("Sprite").material.set_shader_param("outline_color", Color("1fa0ff"))

func selection_ended(units_selected):
	reset_selection()
	unit_movable = units_selected
	for unit in units_selected:
		unit.get_node("Sprite").material.set_shader_param("visible", true)
		unit.get_node("Sprite").material.set_shader_param("outline_color", Color("70cb71"))

func reset_selection():
	for unit in unit_movable:
		unit.get_node("Sprite").material.set_shader_param("visible", false)
	unit_movable = []

func _circle_formation(unit_array, mousepos):
	var unit_pos = mousepos
	var space_between_units = 20
	var circle_size = 0
	var unit_total_count_in_circle = 6 * circle_size
	var unit_count_in_circle = 0
	var current_angle = 0
	for unit in unit_array:
		unit.set_target_position(unit_pos)
		unit_count_in_circle += 1
		if unit_count_in_circle >= unit_total_count_in_circle:
			unit_count_in_circle = 0
			current_angle = 0
			circle_size += 1
			unit_total_count_in_circle = 6 * circle_size
			unit_pos.x = mousepos.x + space_between_units * circle_size
			unit_pos.y = mousepos.y
		else:
			current_angle += (PI/3) / circle_size
			unit_pos.x = mousepos.x + (space_between_units * circle_size) * cos(current_angle)
			unit_pos.y = mousepos.y + (space_between_units * circle_size) * sin(current_angle)
