extends Area2D




# Called when the node enters the scene tree for the first time.
func _ready():
	GameMananger.coletarArma.connect(coletaArma)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if(body.is_in_group("jogador")):
		GameMananger.areaMachado()
		body.z_index = 1
	
func coletaArma():
	queue_free()

func _on_body_exited(body):
	if(body.is_in_group("jogador")):
		GameMananger.foraMachado()
