extends Node2D
 # Sinal para coletar o machado
signal coletarArma  # Sinal para coletar o machado
signal areaArma
# Called when the node enters the scene tree for the first time.
var shapeWeapon : bool = false
func _ready():
	pass



func collectWeapon():
	if(shapeWeapon == true):
		emit_signal("coletarArma")
		return true
	else:
		return false
	
	 
	  
func areaMachado():
	
	shapeWeapon = true

func foraMachado():
	shapeWeapon = false
	
	
	
