extends Node2D
@onready var cursor: Sprite2D = $CanvasLayer/cursor
@onready var label_score: Label = $CanvasLayer/Label_Score
@onready var label_targets: Label = $CanvasLayer/Label_Targets
@export var target_scene: PackedScene
var points: int = 0
var quantity_targets = 0
var death = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer/Label_Lose.hide()
	$CanvasLayer/Button_Retry.hide()
	$CanvasLayer/Button_quit.hide()
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

	var tween = create_tween().set_loops()
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(cursor, "rotation_degrees", 15.0, 0.9)
	tween.tween_property(cursor, "rotation_degrees", -15.0, 0.9)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	cursor.position = get_viewport().get_mouse_position()

func _exit_tree():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _on_mob_timer_timeout() -> void:
	if death == false:
		var target = target_scene.instantiate()
		target.position = Vector2(randf_range(30, 270), randf_range(20, 130))
		var target_scale = randf_range(0.1, 0.3)
		var tween = create_tween()
		tween.tween_property(target, 'scale', Vector2(target_scale + 0.05, target_scale + 0.05), 0.1)
		tween.tween_property(target, 'scale', Vector2(target_scale, target_scale), 0.2)
		target.scale = Vector2(target_scale, target_scale)
		target.clicked.connect(_on_target_clicked)
		target.add_to_group('targets')
		add_child(target)
		quantity_targets += 1
		label_targets.text = 'Alvos: ' + str(quantity_targets)
		if quantity_targets >= 10:
			death = true
			game_over()

func _on_target_clicked():
	quantity_targets -= 1
	points += 1
	label_score.text = "Pontos: " + str(points)
	label_targets.text = 'Alvos: ' + str(quantity_targets)
	
	if points % 5 == 0:
		increase_difficulty()
		
func increase_difficulty() -> void:
	$Mob_Timer.wait_time = max(0.3, $Mob_Timer.wait_time * 0.9)
	
func game_over() -> void:
	$CanvasLayer/Label_Lose.show()
	$CanvasLayer/Button_Retry.show()
	$CanvasLayer/Button_quit.show()


func _on_button_retry_pressed() -> void:
	$CanvasLayer/Button_Retry.hide()
	$CanvasLayer/Label_Lose.hide()
	$CanvasLayer/Button_quit.hide()
	quantity_targets = 0
	label_targets.text = 'Alvos: ' + str(quantity_targets)
	points = 0
	label_score.text = "Pontos: " + str(points)
	$Mob_Timer.wait_time = 1.0
	death = false
	for target in get_tree().get_nodes_in_group('targets'):
		target.queue_free()


func _on_button_quit_pressed() -> void:
	get_tree().quit()
