extends Node2D

var weapon_name = GameMananger.armaColetada
var weapon_scene: PackedScene = load("res://" + weapon_name + ".tscn")

var speed: 		float = 600.0
var spin_speed: float = randi_range(30, 50)
var direction:  Vector2

var timer: Timer

func _ready():
	var sprite_name: String

	if		weapon_name == "machado":
		sprite_name = "Axe"
	elif	weapon_name == "espada":
		sprite_name = "Sword"
	else:
		sprite_name = "Hammer"
	
	$Sprite2D.texture = load("res://assets/weapons/spr" + sprite_name + ".png")
	timer = Timer.new()
	add_child(timer)

	timer.wait_time = 0.4 # distância
	timer.one_shot  = true

	timer.connect("timeout", Callable(self, "projectile_stopped"))
	timer.start()
	
	set_process(true)

func _process(delta: float) -> void:
	position += direction	* speed * delta
	rotation += spin_speed	* delta

func projectile_stopped() -> void:
	var dropped_weapon		= weapon_scene.instantiate() as Node2D
	dropped_weapon.position = position
	dropped_weapon.rotation = rotation
	get_tree().current_scene.add_child(dropped_weapon)
	
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if(body.is_in_group("inimigo")):
		if(body.has_method("lancamentoDeArma")):
			body.lancamentoDeArma()
	projectile_stopped()
