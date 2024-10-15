extends Node2D

@onready var animated_cursor = $AnimatedSprite2D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	animated_cursor.play("default")

func _process(delta):
  
	animated_cursor.position = get_global_mouse_position()
