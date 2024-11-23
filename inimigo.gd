class_name Inimigo

extends CharacterBody2D

var animationStop = "parado"
var animationMovment = "andando"
var speed: int 
var player_chace = false
var player = null
var areahit = false 
var bolAttack = false
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
func _init(id : int , nome: String , speed:int):
	self.id = id
	self.nome = nome
	self.speed = speed

func _ready():
	GameMananger.danoInimigo.connect(inimigoMorto)	

func inimigoMorto():
	
	if(areaGolpe):
		queue_free()


func AreaGolpe(aGolpe):
	areaGolpe = aGolpe
	

func areaHit():
	pass

func _physics_process(delta):
	if player_chace:
		# Movimento para o jogador
		position += (player.position - position).normalized() * speed * delta
		
		# Calculando a direção para o jogador
		var direction = player.position - position
		# Calculando o ângulo para a direção
		var angle_to_player = direction.angle()
		# Aplicando a rotação ao inimigo
		rotation = angle_to_player
		
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
		
		if !bolAttack:# Caso o inimigo não esteja perseguindo, animação de "parado"
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
		$Timer.start()
		
	
		GameMananger.golpePlayer()
	
	


func _on_hitbox_body_entered(body):
	if(body.is_in_group("jogador")):
		$reacao.start()
		areahit = true
		
		
		
	


func _on_hitbox_body_exited(body):
	areahit = false # Replace with function body.


func _on_reacao_timeout():
	animatedSprite.play("golpe")
	bolAttack = true
	attack() # Replace with function body.


func _on_timer_timeout():
	
	$AnimatedSprite2D.stop("golpe")
	bolAttack = false # Replace with function body.
