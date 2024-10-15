extends Node2D
signal coletarMach  # Sinal para coletar o machado

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func collectWeapon():
	emit_signal("coletarMach")  # Emite o sinal para notificar o player
	queue_free()  # Remove o machado da cena
