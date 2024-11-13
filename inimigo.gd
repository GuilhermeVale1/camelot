class_name Inimigo

extends CharacterBody2D

var nome : String
var id : int
var golpe = false

func _init(id : int , nome: String ):
	self.id = id
	self.nome = nome

func _ready():
	GameMananger.danoInimigo.connect(inimigoMorto)	

func inimigoMorto():
	if(golpe):
		queue_free()
