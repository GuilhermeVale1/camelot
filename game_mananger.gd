extends Node2D
# Sinal para coletar o machado
signal coletarArma
signal danoInimigo

var player_is_armed: bool = false
var previous_weapon_name: String

var nameArma: String 
var idArma 
var armaColetada = "semArma"

var shapeWeapon: bool = false
func _ready():
	pass

func collectWeapon():
	if not shapeWeapon: return false
	player_is_armed = true
	previous_weapon_name = armaColetada
	armaColetada 	= nameArma
	emit_signal("coletarArma", idArma)
	return true
	
func verNome():
	return armaColetada
	  
func areaArma(id , nome):
	nameArma	= nome
	idArma		= id
	shapeWeapon = true
	print(nameArma)

func foraArma():
	shapeWeapon = false
	nameArma = "semArma"

func golpeInimigo():
	print("golpeInimigo ativo")
	emit_signal("danoInimigo")
