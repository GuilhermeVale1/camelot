extends Node2D

var weapon_name = GameMananger.armaColetada
var weapon_scene: PackedScene = load("res://" + weapon_name + ".tscn")

var speed: 		float = 600.0
var spin_speed: float = 30.0
var direction:  Vector2

var timer: Timer

func _ready():
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
	get_tree().current_scene.add_child(dropped_weapon)
	
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	projectile_stopped()
