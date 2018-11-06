extends Control

var time_counter = 0
const TIME_PER_LETTER = .03
const FULL_MESSAGE_SCREEN_TIME = 6

var message_is_complete = false

var dialogue_holder = "|||PLACEHOLDER|||"

var char_name_node
var dialogue_node
var img_node

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	char_name_node = $main_panel/char_name_panel/char_name
	dialogue_node = $main_panel/char_dialogue
	img_node = $Character_Image

func init(name, dialogue, img_path):
	char_name_node.text = name
	dialogue_holder = dialogue
	img_node.set_texture(ResourceLoader.load(img_path))

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	time_counter += delta
	if message_is_complete == false:
		if time_counter > TIME_PER_LETTER:
			if dialogue_holder != "":
				dialogue_node.text = dialogue_node.text + dialogue_holder.left(1)
				dialogue_holder = dialogue_holder.right(1)
			else:
				message_is_complete = true
			time_counter = 0
	else:
		if time_counter > FULL_MESSAGE_SCREEN_TIME:
			queue_free()
		
		
