class_name Inimigo

extends CharacterBody2D

var animationStop = "parado"
var animationMovment = "andando"
var speed: int 
var player_chace = false
var player = null


	


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
	


func _physics_process(delta):
	if player_chace:
		position += (player.position - position)/ speed
		$AnimatedSprite2D.play("andando")
	else:
		$AnimatedSprite2D.play("parado")
	

func _on_detection_area_body_entered(body):
		if(body.is_in_group("jogador")):
			player_chace = true
			player = body
	


func _on_detection_area_body_exited(body):
	if(body.is_in_group("jogador")):
			player_chace = false
			player = null
	print("saiu da zona inimiga")
