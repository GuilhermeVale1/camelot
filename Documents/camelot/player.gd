extends CharacterBody2D

var speed : float = 300.0
var life : float = 300.0
var seconds = 0
var animationMovment = "andando"
var animationStop = "parado"


@onready var animatedSprite : AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	pass
	

func _physics_process(delta):
	# Reinicia a velocidade a cada frame
	velocity = Vector2()
	
	
	

	
	# Movimentação com o teclado
	if Input.is_action_pressed("direita"):
		velocity.x += speed
	if Input.is_action_pressed("esquerda"):
		velocity.x -= speed
	if Input.is_action_pressed("cima"):
		velocity.y -= speed
	if Input.is_action_pressed("baixo"):
		velocity.y += speed

	if Input.is_action_just_pressed("pegarArma"):
		if( GameMananger.collectWeapon()):
			animationMovment = "andandoMach"
			animationStop = "paradoMach"
			
	var x_mov = Input.get_action_strength("direita") - Input.get_action_strength("esquerda")
	# x_mov = 1 - 0 = 1 mov = right 
	# x_mov = 0 - 1 = -1 mov = left 
	
	var y_mov = Input.get_action_strength("baixo") - Input.get_action_strength("cima")
	# y_mov = 1 - 0 = 1 mov = down 
	# y_mov = 0 - 1 = -1 mov = up
	 
	var mov = Vector2(x_mov, y_mov)
			
	velocity = mov.normalized()*speed			
	move_and_slide()

	
	look_at(get_global_mouse_position())

	
	if velocity.length() > 0:
		animatedSprite.play(animationMovment)
	
	elif(velocity.x == 0 and velocity.y == 0):
		animatedSprite.play(animationStop)
	
	else:
		animatedSprite.play("morrendo1")
		if( animatedSprite.frame == 2):
			get_tree().paused = true

