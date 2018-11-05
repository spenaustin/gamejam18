extends KinematicBody

var gravity = -9.8
var velocity = Vector3()
var camera

const SPEED = 6
const ACCELERATION = 3
const DECELERATION = 5

var MOVEMENT_MAPPINGS 


func _ready():
	camera = get_node("../Camera").get_global_transform() 
	MOVEMENT_MAPPINGS = {
		"move_player_forward": -camera.basis[2],
		"move_player_back": camera.basis[2],
		"move_player_right": camera.basis[0],
		"move_player_left": -camera.basis[0]
	}

func _physics_process(delta):
	var dir = Vector3()
	
	for i in MOVEMENT_MAPPINGS.keys():
		if(Input.is_action_pressed(i)):
			dir += MOVEMENT_MAPPINGS[i]
	
	dir.y = 0
	
	dir = dir.normalized()
	
	velocity.y += delta * gravity
	
	var hv = velocity
	hv.y = 0
	var new_pos = dir * SPEED
	var accel = DECELERATION
	
	if (dir.dot(hv) > 0):
		accel = ACCELERATION
		
	hv = hv.linear_interpolate(new_pos, accel * delta)
	
	velocity.x = hv.x
	velocity.z = hv.z
	
	velocity = move_and_slide(velocity, Vector3(0,1,0))