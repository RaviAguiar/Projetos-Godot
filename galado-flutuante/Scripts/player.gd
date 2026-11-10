extends CharacterBody2D
var freeze = true
signal game_over_process


const SPEED = 300.0
const JUMP_VELOCITY = -150.0

func _physics_process(delta: float) -> void:
	if freeze:
		return
		
	if not is_on_floor():
			velocity += get_gravity() * delta
		
	if Input.is_action_just_pressed("ui_accept"):
			velocity.y = JUMP_VELOCITY
	move_and_slide()


func _on_game_unfreeze() -> void:
	freeze = false
	

func _on_floor_body_entered(body: Node2D) -> void:
	set_physics_process(false)
	game_over_process.emit()
	$Sprite_Player.texture = load("res://icon_death.svg")
	
