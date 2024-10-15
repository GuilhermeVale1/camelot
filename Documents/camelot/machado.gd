extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	GameMananger.coletarArma.connect(coletaArma) #sinal que chama a func coletar_arma


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body): #verifica se algum obj está em contato com o machado
	if(body.is_in_group("jogador")): #detecta se o jogador está na área do machado
		GameMananger.areaMachado()
		body.z_index = 1 #faz o machado não sobrepor o jogador
	
func coletaArma(): #some o machado do cena
	queue_free()

func _on_body_exited(body): #detecta se o jogador saiu da área do machado
	if(body.is_in_group("jogador")):
		GameMananger.foraMachado()
