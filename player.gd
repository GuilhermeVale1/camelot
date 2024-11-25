extends CharacterBody2D

var speed:	float = 280.0
var life = true
var seconds = 0
var animationMovment = "andando"
var animationStop = "parado"
var atack = false
var areaHit = false
var dictArma = {
	"machado":	["andandoMach",	"paradoMach",	"golpeMach"], 
	"martelo":	["andandoMat",	"paradoMat",	"golpeMat"], 
	"espada":	["andandoEsp",	"paradoEsp",	"golpeEsp"], 
	"semArma":	["andando",		"parado",		"golpe"]
}

var projectile_scene: PackedScene
var can_swap_weapons: bool = false

@onready var animatedSprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	projectile_scene = preload("res://PlayerProjectile.tscn")
	GameMananger.danoPlayer.connect(deadPlayer)		
	

func _process(delta):
	pass

func drop_equipped_weapon(weapon_name):
		var dropped_weapon = load("res://" + weapon_name + ".tscn").instantiate() as Node2D
		get_tree().current_scene.add_child(dropped_weapon)
		
		dropped_weapon.position = position
		dropped_weapon.rotation = randf_range(0, 2 * PI)

func _physics_process(delta):
	if !life:
		return 
	# Reinicia a velocidade a cada frame
	velocity = Vector2()
	attack()
	
	# Movimentação com o teclado
	if Input.is_action_pressed("direita") and life:
		velocity.x += speed
	if Input.is_action_pressed("esquerda") and life:
		velocity.x -= speed
	if Input.is_action_pressed("cima") and life:
		velocity.y -= speed
	if Input.is_action_pressed("baixo") and life:
		velocity.y += speed

	if Input.is_action_just_pressed("throw") and life: # Lançar arma com Q
		if not GameMananger.player_is_armed: return
		
		animationMovment	= "andando"
		animationStop		= "parado"
		animatedSprite.play("golpe")
		GameMananger.player_is_armed = false
		
		var player_projectile = projectile_scene.instantiate() as Node2D
		get_tree().current_scene.add_child(player_projectile)
		player_projectile.position  = position
		player_projectile.direction = Vector2.RIGHT.rotated(rotation).normalized()
		can_swap_weapons = false

	if Input.is_action_just_pressed("pegarArma") and life:
		if not GameMananger.collectWeapon(): return
		
		var weapon_name = GameMananger.verNome()	
		animationMovment	= dictArma[weapon_name][0]
		animationStop		= dictArma[weapon_name][1]
		$pegarArma.play()
		if not can_swap_weapons:
			can_swap_weapons = true
			return
		
		drop_equipped_weapon(GameMananger.previous_weapon_name)
		
		var areas = $hitbox.get_overlapping_areas()
		if areas: areas[0].queue_free()
		
	var x_mov = Input.get_action_strength("direita") -	Input.get_action_strength("esquerda")
	var y_mov = Input.get_action_strength("baixo") -	Input.get_action_strength("cima")
	# x_mov = 1 - 0 =  1 mov = right 
	# x_mov = 0 - 1 = -1 mov = left 
	
	# y_mov = 1 - 0 =  1 mov = down 
	# y_mov = 0 - 1 = -1 mov = up
	 
	var mov = Vector2(x_mov, y_mov)
			
	velocity = mov.normalized() * speed
	move_and_slide()

	look_at(get_global_mouse_position())
	
	if (velocity.length() > 0 and !atack ) and life:
		animatedSprite.play(animationMovment)
	
	elif(velocity.x == 0 and velocity.y == 0 and !atack) and life:
		animatedSprite.play(animationStop)

func attack():
	if Input.is_action_just_pressed("golpe") and life:
		var nome = GameMananger.verNome()
		
		if !GameMananger.player_is_armed: nome = "semArma"
		
		if !atack:
			atack = true
			animatedSprite.play(dictArma[nome][2])
				
			$deal_attack.start()
			if(areaHit):
				GameMananger.golpeInimigo()
				print("aqui")
				
	
func _on_hitbox_area_entered(area):
	pass # Replace with function body.

func _on_hitbox_area_exited(area):
	pass # Replace with function body.

func _on_deal_attack_timeout():
	$deal_attack.stop()
	atack = false

func _on_hitbox_body_entered(body):
	if(body.is_in_group("inimigo")):
	
		areaHit = true
		if body.has_method("AreaGolpe"):
			body.AreaGolpe(areaHit)
			
		
		if(atack):
			GameMananger.golpeInimigo()


func _on_hitbox_body_exited(body):
	if(body.is_in_group("inimigo")):
		areaHit = false
		if body.has_method("AreaGolpe"):
			body.AreaGolpe(areaHit)
		
func deadPlayer():
	var quadro_sorteado = randi_range(1, 3)
	
	# Exibe o quadro sorteado (lembre-se que os quadros são indexados de 0 a 5, então subtraímos 1)
	animatedSprite.frame = quadro_sorteado - 1
	
	# Toca a animação "morrendo" (essa animação vai ser tocada, mas o quadro mostrado será o sorteado)
	animatedSprite.play("morrendo1")
	self.collision_layer = 0  # Remove a camada de colisão
	self.collision_mask = 0 
	self.z_index = 0 
	
	# Marca a vida como falsa (o jogador morreu)
	life = false
	
