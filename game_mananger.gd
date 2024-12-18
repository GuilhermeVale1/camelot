extends Node2D
# Sinal para coletar o machado
signal coletarArma
signal danoInimigo
signal danoPlayer
signal lancamentoDeArma
signal destroiparede
signal contaMorte

var player_is_armed: bool = false
var previous_weapon_name: String


var nameArma: String 
var idArma 
var armaColetada = "semArma"
@onready var audio = $golpes


var shapeWeapon: bool = false
func desarma():
	armaColetada = "semArma"
	
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

func golpeInimigo(dandoArmaSound):
	if(dandoArmaSound != null):
		audio = dandoArmaSound
		audio.play()
	emit_signal("danoInimigo")
	

	
func golpePlayer():
	emit_signal("danoPlayer")
func destroiParede():
	emit_signal("destroiparede")
func reniciaCena():
	get_tree().reload_current_scene()
func contaMorte2():
	emit_signal("contaMorte")
