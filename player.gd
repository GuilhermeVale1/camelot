extends CharacterBody2D

var speed : float = 200.0
var life : float = 300.0
var seconds = 0
var animationMovment = "andando"
var animationStop = "parado"
var atack = false
var dictArma = {
"machado":["andandoMach" ,"paradoMach" , "golpeMach"] , 
"martelo":["andandoMat" , "paradoMat" , "golpeMat"] , 
"espada":["andandoEsp" , "paradoEsp", "golpeEsp"], 
"semArma":["andando" , "parado", "golpe"] }


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
			var nomeArma = GameMananger.verNome()	
			animationMovment = dictArma[nomeArma][0]
			animationStop = dictArma[nomeArma][1]
	
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

	
	if (velocity.length() > 0 and !atack ):
		animatedSprite.play(animationMovment)
	
	elif(velocity.x == 0 and velocity.y == 0 and !atack):
		animatedSprite.play(animationStop)
	



func attack():
	if Input.is_action_just_pressed("golpe"):
		var nome = GameMananger.verNome()
		 	
		if(!atack):
			atack = true
			animatedSprite.play(dictArma[nome][2])
				
			$deal_attack.start()
	
func _on_hitbox_area_entered(area):
	pass # Replace with function body.


func _on_hitbox_area_exited(area):
	pass # Replace with function body.


func _on_deal_attack_timeout():
	$deal_attack.stop()
	atack = false
