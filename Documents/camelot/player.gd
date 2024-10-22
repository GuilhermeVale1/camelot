extends CharacterBody2D

var speed : float = 200.0
var life : float = 300.0
var seconds = 0
var animationMovment = "andando"
var animationStop = "parado"
var atack = false


@onready var animatedSprite : AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	pass
	

func _physics_process(delta):
	# Reinicia a velocidade a cada frame
	velocity = Vector2()
	attack()
	
	
	

	
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
	move_and_slide()

	
	look_at(get_global_mouse_position())

	
	if (velocity.length() > 0 and atack == false):
		animatedSprite.play(animationMovment)
	
	elif(velocity.x == 0 and velocity.y == 0 and atack == false):
		animatedSprite.play(animationStop)
	



func attack():
	if Input.is_action_just_pressed("golpe"):
		if(animationMovment == "andandoMach" and animationStop == "paradoMach"):
			atack = true
			animatedSprite.play("golpeMach")
			$deal_attack.start()
	
func _on_hitbox_area_entered(area):
	pass # Replace with function body.


func _on_hitbox_area_exited(area):
	pass # Replace with function body.


func _on_deal_attack_timeout():
	$deal_attack.stop()
	atack = false
