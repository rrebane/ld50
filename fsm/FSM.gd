extends Node
class_name FSM

var debug = false
var states = {}
var state_cur = null
var state_next = null
var state_lst = null
var obj = null

func _init(_obj, states_parent_node, initial_state, _debug = false):
	self.obj = _obj
	self.debug = _debug
	_set_states_parent_node( states_parent_node )
	state_next = initial_state
	pass

func _set_states_parent_node( parent ):
	if debug: print( "Found ", parent.get_child_count(), " states" )
	if parent.get_child_count() == 0:
		return
	var state_nodes = parent.get_children()
	for state_node in state_nodes:
		var name = state_node.name.to_lower();
		if debug: print( "adding state: ", name )
		states[name] = state_node
		state_node.fsm = self
		state_node.obj = self.obj


func run_machine( delta ):
	if state_next != state_cur:
		if state_cur != null:
			if debug:
				print( obj.name, ": changing from state ", state_cur.name, " to ", state_next.name )
			state_cur.terminate()
		elif debug:
			print( obj.name, ": starting with state ", state_next.name )
		state_lst = state_cur
		state_cur = state_next
		state_cur.initialize()
	# run state

	state_cur.run(delta)

