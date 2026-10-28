extends Node2D
@export var canos_scene: PackedScene
signal unfreeze
var timer_start = Timer.new()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer_start.wait_time = 3
	timer_start.one_shot = true
	timer_start.autostart = true
	timer_start.timeout.connect(_on_timer_start_timeout)
	add_child(timer_start)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timer_start.time_left > 0:
		var timer_whole = int(ceil(timer_start.time_left))
		$Countdown.text = str(timer_whole)
	else:
		$Countdown.text = ""
func _on_timer_start_timeout() -> void:
	unfreeze.emit()
	
