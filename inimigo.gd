class_name Inimigo

extends CharacterBody2D

var animationStop = "parado"
var animationMovment = "andando"
var speed: int 
var player_chace = false
var player = null
var areahit = false
var morto = false
var gambiarra = [false]
var tenta  = false
var bala = "qualquer coisa"

var bolAttack = false
var calc = 0.0

@onready var animatedSprite: AnimatedSprite2D = $AnimatedSprite2D

var dictArma = {
	"machado":	["andandoMach",	"paradoMach",	"golpeMach"], 
	"martelo":	["andandoMat",	"paradoMat",	"golpeMat"], 
	"espada":	["andandoEsp",	"paradoEsp",	"golpeEsp"], 
	"semArma":	["andando",		"parado",		"golpe"]
}


	


var nome : String
var id : int

var areaGolpe = false
func _init(id : int , nome: String , speed:int ):
	self.id = id
	self.nome = nome
	self.speed = speed
	

func _ready():
	GameMananger.danoInimigo.connect(inimigoMorto)	

func inimigoMorto():
	
	if(areaGolpe and !morto):
		morto = true
		animatedSprite.play("morrendo")
		self.collision_layer = 0  # Remove a camada de colisão
		self.collision_mask = 0 
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
	var move_duration = 1.0  # O tempo que ele vai se mover na direção oposta (ajuste conforme necessário)

	# Um simples movimento contínuo para a direção oposta
	var movement = direction * move_speed * $morrendo.wait_time
	 # Multiplica pela velocidade e o tempo do Timer

	# Realizar o movimento (pode usar `position += movement` ou `move_and_slide()` se for necessário)
	position += movement

func AreaGolpe(aGolpe):
	areaGolpe = aGolpe
	

func areaHit():
	pass

func _physics_process(delta):
	if(!morto):
		
		if bolAttack and animatedSprite.frame == 2:
			
			attack()
		
		
				
		
		if player_chace:
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
				animatedSprite.play("andando")
			for enemy in get_tree().get_nodes_in_group("inimigo"):
				if enemy != self:
					var distance = position.distance_to(enemy.position)
					# Se estiver muito perto, empurra o inimigo para longe
					if distance < 10:  # Ajuste esse valor conforme necessário
						direction = (position - enemy.position).normalized()
						position += direction * 100 * delta
		else:
			
			if !bolAttack and !morto:# Caso o inimigo não esteja perseguindo, animação de "parado"
				animatedSprite.play("parado")
	

func _on_detection_area_body_entered(body):
		if(body.is_in_group("jogador")):
			player_chace = true
			player = body
	


func _on_detection_area_body_exited(body):
	if(body.is_in_group("jogador")):
			player_chace = false
			player = null
	print("saiu da zona inimiga")
	
func attack():
	
	if areahit:
		
		
		
		
		GameMananger.golpePlayer()
	
	
		
	
	


func _on_hitbox_body_entered(body):
	
	if(body.is_in_group("jogador")):
		areahit = true
		if !bolAttack and !morto:
			
			animatedSprite.play("golpe")
			bolAttack = true
			$Timer.start()
		
			
		
		elif  player_chace and !morto:
			animatedSprite.play("andando")
		elif !player_chace and !morto :
			animatedSprite.play("parado")
	
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
		animatedSprite.play("andando")
	elif !morto:
		animatedSprite.play("parado")
	$Timer.stop()

	
	




func _on_morrendo_timeout():
	self.collision_layer = 0  # Remove a camada de colisão
	self.collision_mask = 0 
	
	animatedSprite.play("morto") # Replace with function body.
	$morrendo.stop()


		
		 # Replace with function body.
