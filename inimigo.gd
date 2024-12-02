class_name Inimigo

extends CharacterBody2D

var animationStop = "parado"

var animationMovment = "andando"
var arma = "faca"
var weapon_scene: PackedScene = load("res://" + arma + ".tscn")
var speed: int
var player_chace = false
var player = null
var collet = 0
var positionArma = null
var areahit = false
var morto = false
var armaArea = false
var dictArma = {
	"machado":	["andandoMach",	"paradoMach",	"golpeMach" , 4],
	"martelo":	["andandoMat",	"paradoMat",	"golpeMat" , 7],
	"espada":	["andandoEsp",	"paradoEsp",	"golpeEsp" ,4 ],
	
	"sMartelo":	["andandoSMat", "paradpSMat", "golpeSMat" , 6],
	"smallSmace": ["andandoSmSmace" , "paradoSmSmace", "golpeSmSmace" , 6 ],
	"faca":	["andando",		"parado",		"golpe" , 2]
}


var tenta  = false


var bolAttack = false
var calc = 0.0

@onready var animatedSprite: AnimatedSprite2D = $AnimatedSprite2D



	


var nome : String
var id : int

var areaGolpe = false
func _init(id : int , nome: String , speed:int ):
	self.id = id
	self.nome = nome
	self.speed = speed
	

func _ready():
	GameMananger.danoInimigo.connect(inimigoMorto)

func detectArma(position , boolArma):
	positionArma = position
	armaArea = boolArma
	
	
func lancamentoDeArma():
	morto = true
	animatedSprite.play("morto")
	self.collision_layer = 0  # Remove a camada de colisão
	self.collision_mask = 0
	self.z_index = 0
	$morrendo.start()
	print("arma acertou")

func inimigoMorto():
	
	if(areaGolpe and !morto):
		morto = true
		animatedSprite.play("morto")
		self.collision_layer = 0  # Remove a camada de colisão
		self.collision_mask = 0
		self.z_index = 0
		var dropped_weapon = load("res://" + arma + ".tscn").instantiate() as Node2D
		get_tree().current_scene.add_child(dropped_weapon)
		
		dropped_weapon.position = position
		dropped_weapon.rotation = randf_range(0, 2 * PI)
	
		$morrendo.start()
		print("Ele está morrendo")
		if player:
			# Calcular a direção do jogador em relação ao inimigo
			var direction_to_player = player.position - position
			
			# A direção oposta seria a inversão desse vetor
			var opposite_direction = -direction_to_player.normalized()
			rotation = opposite_direction.angle()
			
			# Mover o inimigo na direção oposta
			move_in_opposite_direction(opposite_direction)
			
func move_in_opposite_direction(direction: Vector2):
	# Mover o inimigo na direção oposta por um tempo (ajuste conforme necessário)
	var move_speed = 30  # Ajuste a velocidade do movimento (dependendo da sua necessidade)
	var move_duration = 3.0  # O tempo que ele vai se mover na direção oposta (ajuste conforme necessário)

	# Um simples movimento contínuo para a direção oposta
	var movement = direction * move_speed * $morrendo.wait_time
	 # Multiplica pela velocidade e o tempo do Timer

	# Realizar o movimento (pode usar `position += movement` ou `move_and_slide()` se for necessário)
	position += movement
	move_and_slide()

func AreaGolpe(aGolpe):
	areaGolpe = aGolpe
	

func areaHit():
	pass

func _physics_process(delta):
	
		
	
	if(!morto):
		
	
		
		if bolAttack and animatedSprite.frame == dictArma[arma][3]:
			
			attack()
		
		
		if((arma == "faca" or arma == "semArma") and armaArea):
			# Garantir que positionArma seja um Vector2
			var direction = positionArma - position
			position += direction / speed   # Movimento em direção à arma

			# Calcular o ângulo para a arma
			var angle_to_weapon = direction.angle()
			rotation = angle_to_weapon
			if(!bolAttack):  # Rotacionar o inimigo para a direção da arma
				animatedSprite.play(animationMovment)
			move_and_slide()
			
		
		if player_chace and !armaArea:
			# Movimento para o jogador
			position += (player.position - position)/speed
			
			# Calculando a direção para o jogador
			var direction = player.position - position
			# Calculando o ângulo para a direção
			var angle_to_player = direction.angle()
			# Aplicando a rotação ao inimigo
			rotation = angle_to_player
			move_and_slide()
			
			if !bolAttack:
				animatedSprite.play(animationMovment)
			for enemy in get_tree().get_nodes_in_group("inimigo"):
				if enemy != self:
					var distance = position.distance_to(enemy.position)
					# Se estiver muito perto, empurra o inimigo para longe
					if distance < 10:  # Ajuste esse valor conforme necessário
						direction = (position - enemy.position).normalized()
						position += direction * 100 * delta
		else:
			
			if !bolAttack and !morto and !armaArea:# Caso o inimigo não esteja perseguindo, animação de "parado"
				animatedSprite.play(animationStop)
func coletaArma(armaC):
	
	if morto: return
	 # Não faz nada se o inimigo estiver morto
	if(arma == "faca" and arma != armaC):
		
	# Deixa a arma atual no chão antes de pegar a nova arma
		drop_equipped_weapon(arma)
		
	# Agora troca para a nova arma
		arma = armaC
		animationStop = dictArma[arma][1]
		animationMovment = dictArma[arma][0]
		collet += 1
	
func verArma():
	return arma
func verCollect():
	return collet
	
func drop_equipped_weapon(weapon_name):
	var dropped_weapon = load("res://" + weapon_name + ".tscn").instantiate() as Node2D
	get_tree().current_scene.add_child(dropped_weapon)
		
	dropped_weapon.position = position
	dropped_weapon.rotation = randf_range(0, 2 * PI)

func _on_detection_area_body_entered(body):
	
	
	if(body.is_in_group("jogador")):
		player_chace = true
		player = body
	elif(body.is_in_group("espada")):
	
		positionArma = body
		armaArea = true
		print("entrei aqui")
	
	
		
	   
			
			
	


func _on_detection_area_body_exited(body):
	if(body.is_in_group("jogador")):
		player_chace = false
		player = null
	
	elif(body.is_in_group("arma")):
		positionArma = null
		armaArea = false
		
	
func attack():
	
	if areahit:
		
		
		
		
		GameMananger.golpePlayer()
	
	
		
	
	


func _on_hitbox_body_entered(body):
	
	if(body.is_in_group("jogador")):
		areahit = true
		if !bolAttack and !morto:
			
			animatedSprite.play(dictArma[arma][2])
			bolAttack = true
			$Timer.start()
		
			
		
		elif  player_chace and !morto:
			animatedSprite.play(animationMovment)
		elif !player_chace and !morto :
			animatedSprite.play(animationStop)
	
		 # Replace with function body.
		
		
		
		
	


func _on_hitbox_body_exited(body):
	if(body.is_in_group("jogador")):
		areahit = false



func _on_reacao_timeout():
	pass



func _on_timer_timeout():
	
	animatedSprite.stop()
	
	  # Para a animação do AnimationPlayer
	bolAttack = false
	if player_chace and !morto:
		animatedSprite.play(animationMovment)
	elif !morto:
		animatedSprite.play(animationStop)
	$Timer.stop()

	
	




func _on_morrendo_timeout():
	self.collision_layer = 0  # Remove a camada de colisão
	self.collision_mask = 0
	self.z_index = 0
	
	animatedSprite.play("morto") # Replace with function body.
	$morrendo.stop()


		
		 # Replace with function body.


func _on_tentativ_area_body_entered(body):
	if(body.is_in_group("jogador")):
		if !bolAttack and !morto:
				
			animatedSprite.play(dictArma[arma][2])
			bolAttack = true
			$Timer.start()
				
	 		


func _on_tentativ_area_body_exited(body):
	pass # Replace with function body.
