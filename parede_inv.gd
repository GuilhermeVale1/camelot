class_name parede

extends StaticBody2D

var id

# Called when the node enters the scene tree for the first time.
func _init(id : int ):
	self.id = id


func deleta():
	print("porraaaaaaaaaaa")
	var numero = GameMananger.verLocale()
	if(id == numero):
		queue_free()
func _ready():
	print("parede criadaaaa")
	if GameMananger.destroi.is_connected(deleta):
		print("Conexão do sinal 'destroi' está funcionando")
	else:
		print("Erro: Sinal 'destroi' não está conectado corretamente")
	GameMananger.destroi.connect(deleta)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print("parede criadaaaa")
