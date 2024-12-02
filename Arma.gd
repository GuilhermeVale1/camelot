
class_name Arma
extends Area2D



var id : int
var nome: String
var arma = false
var player = false
var enemy = false

func _init(id : int , nome: String ):
	self.id = id
	self.nome = nome
	
# Called when the node enters the scene tree for the first time.
func _ready():
	GameMananger.coletarArma.connect(coletaArma)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if(body.is_in_group("jogador")):
		GameMananger.areaArma(id, self.nome)
		arma = true
		player = true
		print(arma)
		body.z_index = 1
	elif(body.is_in_group("inimigo") ):
		var VerArma = body.verArma()
		var collet = body.verCollect()
		print("inimigo na area")
		if(body.has_method("coletaArma") and VerArma == "faca" and nome != "faca"):
			print("olá")
			body.coletaArma(nome)
			
			
			queue_free()
		
		
		
		body.z_index = 1
		
func coletaArma(armaId):
	if (armaId == id and arma and player): queue_free()

func enemyColeta(armaId):
	if (armaId == id and arma and enemy): queue_free()
	
	

func _on_body_exited(body):
	if(body.is_in_group("jogador")):
		GameMananger.foraArma()
		arma = false
		print(arma)


func _on_hitbox_body_entered(body):
	if(body.is_in_group("inimigo")):
		
		if body.has_method("detectArma"):
			body.detectArma(self.position , true)

func _on_hitbox_body_exited(body):
	if(body.is_in_group("inimigo")):
		if body.has_method("detectArma"):
			body.detectArma(null , false)
