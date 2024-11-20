class_name Inimigo

extends CharacterBody2D
var animationStop = "parado"
var animationMovment = "andando"
var nome : String
var id : int

var areaGolpe = false
func _init(id : int , nome: String ):
	self.id = id
	self.nome = nome

func _ready():
	GameMananger.danoInimigo.connect(inimigoMorto)	

func inimigoMorto():
	print("cheguei aqui")
	print(areaGolpe)
	if(areaGolpe):
		queue_free()


func AreaGolpe(aGolpe):
	areaGolpe = aGolpe
	




func _on_detection_area_body_entered(body):
	pass # Replace with function body.
