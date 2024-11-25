class_name parede 

extends StaticBody2D

var id: int

# Called when the node enters the scene tree for the first time.
func _init(id : int ):
	self.id = id


func deleta(numero):
	if(numero == id):
		queue_free()
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
