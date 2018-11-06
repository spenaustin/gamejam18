extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	if Input.is_action_just_pressed("trigger_dialogue"):
		var scene = load("res://assets/testing/popup-dialogue.tscn")
		var scene_instance = scene.instance()
		scene_instance.set_name("dialogue")
		
		add_child(scene_instance)
		scene_instance.init("Spencer","Eat my shorts!", "res://assets/testing/spen_avi.jpeg")