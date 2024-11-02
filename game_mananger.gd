extends Node2D
 # Sinal para coletar o machado
signal coletarArma
signal danoInimigo
var nameArma: String 
var idArma 
var armaColetada = "semArma"
# Called when the node enters the scene tree for the first time.
var shapeWeapon: bool = false
func _ready():
	pass

func collectWeapon():
	if (!shapeWeapon): return false
	armaColetada = nameArma
	emit_signal("coletarArma" , idArma)
	return true
	
func verNome():
	return armaColetada
	  
func areaArma(id , nome):
	nameArma = nome
	idArma = id
	shapeWeapon = true
	print(nameArma)

func foraArma(): # não funciona
	shapeWeapon = false
	nameArma = "semArma"
