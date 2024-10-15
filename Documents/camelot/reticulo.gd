extends Node2D

var mouse_position 
@onready var animated_cursor = $AnimatedSprite2D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	animated_cursor.play("default")

func _process(delta):
	
	mouse_position = get_global_mouse_position()
	animated_cursor.position = to_local(mouse_position)
