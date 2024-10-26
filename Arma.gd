
class_name Arma
extends Area2D



var id : int
var nome: String
var arma = false

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
		
		body.z_index = 1
	
func coletaArma(armaId):
	if(armaId == id and arma):
		queue_free()
	

func _on_body_exited(body):
	if(body.is_in_group("jogador")):
		GameMananger.foraArma()
		arma = false
