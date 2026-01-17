extends Node2D

@export var time := 600

var Playing := true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$UI/Seconds.position = Vector2(10,10)
	$UI/Cost.position = Vector2(10,50)
	$UI/pos.position = Vector2(10, 90)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Playing:
		var playerDistToMouse = $Player.position.distance_to(get_global_mouse_position())
		var time_used = int(playerDistToMouse / 128) + 1
	
		$UI/Seconds.text = str(time)
		$UI/Cost.text = str(time_used)
		$UI/pos.text = str($Player.position / Vector2(128,128))
	
		if Input.is_action_just_pressed("lMouse"):
			time -= time_used
			if time <= 0:
				time = 0
			else:
				$Player.position = get_global_mouse_position()
	
		if Input.is_action_just_pressed("scroll_up") and $Player/Camera.zoom < Vector2(1,1):
			$Player/Camera.zoom += Vector2(.1, .1)
	
		if Input.is_action_just_pressed("scroll_down"):
			$Player/Camera.zoom -= Vector2(.1, .1)
