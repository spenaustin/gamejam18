extends KinematicBody

var gravity = -9.8
var velocity = Vector3()
var camera

const JUMP_SPEED = 5
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
	# ----------------------------------------
	# ---- Movin' yer lil' munchkin around ---
	var dir = Vector3()
	
	for i in MOVEMENT_MAPPINGS.keys():
		if(Input.is_action_pressed(i)):
			dir += MOVEMENT_MAPPINGS[i]
	
	dir.y = 0
	
	dir = dir.normalized()
	
	var new_pos = dir * SPEED
	
	# -----------------------------------------
	
	# -----------------------------------------
	# ---------- Dealing with gravity ---------
	
	# Set y velocity to time delta times gravity...
	velocity.y += delta * gravity
	
	# Set hv == velocity
	var hv = velocity
	
	# HV contains the horizontal components of velocity
	# (HV == "Horizontal Velocity")
	# We take this so that the y vector doesn't fuck
	# up our dot product calculation a few lines down
	# where we check to see if the character is moving 
	# horizontally.
	hv.y = 0
	
	# By default, have the character decelerating.
	var accel = DECELERATION
	
	# If your character is moving horizontally, set
	# horizontal acceleration.
	if (dir.dot(hv) > 0):
		accel = ACCELERATION
		
	
	hv = hv.linear_interpolate(new_pos, accel * delta)
	
	velocity.x = hv.x
	velocity.z = hv.z
	
	# ----------------------------------------
	
	# ----------------------------------------
	# --------------- Jumping ----------------
	
	# is_on_floor is a built in function, apparently.
	if is_on_floor():
		if Input.is_action_just_pressed("movement_jump"):
			velocity.y = JUMP_SPEED
	# ----------------------------------------
	
	velocity = move_and_slide(velocity, Vector3(0,1,0))
	