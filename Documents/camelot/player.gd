extends CharacterBody2D

var speed : float = 200.0
var life : float = 300.0
var seconds = 0
var animationMovment = "andando"
var animationStop = "parado"


@onready var animatedSprite : AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	GameMananger.coletarMach.connect(sla)
	

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
		animationMovment = "andandoMach"
		animationStop = "paradoMach"
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
func sla():
	print("ola")
