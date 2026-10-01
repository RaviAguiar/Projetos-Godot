extends Node2D
@onready var cursor: Sprite2D = $CanvasLayer/cursor

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
