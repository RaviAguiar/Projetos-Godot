extends Node2D

signal potion_made1
signal potion_made2
signal potion_none
var wait = false
var list_position = 0
@onready var anima_botoes = [$"1", $"2", $"3", $"4", $"5", $"6"]
var turns = [1, 0, 0, 0, 0, 0]
var inputs = [0, 0, 0, 0, 0, 0]
# 0 - default // 1 - up // 2 - right // 3 - down // 4 - left

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if wait == true or list_position >= 6:
		return
	
	var click = false
	var tween = create_tween()
	
	if Input.is_action_pressed('ui_up'):
		inputs[list_position] = 1
		click = true
	if Input.is_action_pressed('ui_right'):
		inputs[list_position] = 2
		click = true
	if Input.is_action_pressed('ui_down'):
		inputs[list_position] = 3
		click = true
	if Input.is_action_pressed('ui_left'):
		inputs[list_position] = 4
		click = true
	
	if click == true:
		var current_button = anima_botoes[list_position]
		tween.tween_property(current_button, 'scale', Vector2(1.3, 1.3), 0.05)
		tween.tween_property(current_button, 'scale', Vector2(1.2, 1.2), 0.05)
		update_anima()
		list_position += 1
		
	if inputs[5] != 0:
		if inputs == [1, 1, 3, 3, 4, 2]:
			potion_made1.emit()
			for i in range(6):
				var sprite = anima_botoes[i]
				tween.tween_property(sprite, 'scale', Vector2(1.6, 1.6), 0.04)
				tween.tween_callback(func(): sprite.frame = 1)
				tween.tween_property(sprite, 'scale', Vector2(1.2, 1.2), 0.04)
				
		elif inputs == [1, 4, 2, 4, 4, 3]:
			potion_made2.emit()
			for i in range(6):
				var sprite = anima_botoes[i]
				tween.tween_property(sprite, 'scale', Vector2(1.6, 1.6), 0.04)
				tween.tween_callback(func(): sprite.frame = 1)
				tween.tween_property(sprite, 'scale', Vector2(1.2, 1.2), 0.04)
		elif inputs[5] != 0:
			potion_none.emit()
			for i in range(6):
				var sprite = anima_botoes[i]
				tween.tween_property(sprite, 'scale', Vector2(1.6, 1.6), 0.04)
				tween.tween_callback(func(): sprite.frame = 2)
				tween.tween_property(sprite, 'scale', Vector2(1.2, 1.2), 0.04)

func update_anima() -> void:
	for i in range(6):
			if inputs[i] == 0:
				anima_botoes[i].play('default')
			elif inputs[i] == 1:
				anima_botoes[i].play('up')
			elif inputs[i] == 2:
				anima_botoes[i].play('right')
			elif inputs[i] == 3:
				anima_botoes[i].play('down')
			elif inputs[i] == 4:
				anima_botoes[i].play('left')


func _on_restart_pressed() -> void:
	inputs = [0, 0, 0, 0, 0, 0]
	turns = [1, 0, 0, 0, 0, 0]
	list_position = 0
	$"../potion 1".hide()
	$"../potion 2".hide()
	for botao in anima_botoes:
		var tween = create_tween()
		tween.tween_property(botao, "scale", Vector2(1, 1), 0.1)
	update_anima()
