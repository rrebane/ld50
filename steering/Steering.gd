extends Node

## This is from GDQuest video on ArriveTo
## https://youtu.be/fnkgBaWKZNU


const DEFAULT_MASS: = 2.0
const DEFAULT_SLOW_RADIUS: = 200.0
const DEFAULT_MAX_SPEED: = 400.0

func arrive_to(
		velocity: Vector2,
		global_position: Vector2,
		target_position: Vector2,
		max_speed: = DEFAULT_MAX_SPEED,
		slow_radius: = DEFAULT_SLOW_RADIUS,
		mass: = DEFAULT_MASS
	):

	var to_target: = global_position.distance_to(target_position)
	var desired_velocity: = (target_position - global_position).normalized() * max_speed
	if to_target < slow_radius:
		desired_velocity *= (to_target / slow_radius) * .75 + .25
	var steering: Vector2 = (desired_velocity - velocity) / mass
	return velocity + steering
