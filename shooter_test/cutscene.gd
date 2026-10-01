extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$bab.hide()
	$Sprite2D.hide()
	$Label.hide()
	animacao()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func animacao():
	await get_tree().create_timer(1.0).timeout
	$Sprite2D.show()
	$Explosao_som.play()
	await get_tree().create_timer(2.0).timeout
	$Label.show()
	$Explosao_som.play()
	await get_tree().create_timer(2.0).timeout
	$bab.show()
	$Explosao_som.play()
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file('res://menu_inicial.tscn')
