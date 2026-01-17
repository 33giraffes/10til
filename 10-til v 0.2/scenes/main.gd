extends Node2D

@export var time := 600

var Playing := true

func _ready() -> void:
	$UI/Seconds.position = Vector2(10,10)
	$UI/Cost.position = Vector2(10,50)
	$UI/pos.position = Vector2(10, 90)

func _process(_delta: float) -> void:
	var og = Vector2(get_window().size)/Vector2(2,2)

	if Playing:
		var playerDistToMouse = $Player.position.distance_to(get_global_mouse_position())
		var time_used = int(playerDistToMouse / 128)
	
		$UI/Seconds.text = str(time)
		$UI/Cost.text = str(time_used)
		$UI/pos.text = str($Player.position / Vector2(128,128))
		
		$Floor/WalkPath.clear_points()
		$Floor/WalkPath.add_point(og)
		$Floor/WalkPath.add_point(get_window().get_mouse_position())
		
		if time < time_used:
			$Floor/WalkPath.default_color = Color(1.0, 0.0, 0.0, 0.5)
		else:
			$Floor/WalkPath.default_color = Color(1.0, 1.0, 1.0, 0.5)
	
		if Input.is_action_just_pressed("lMouse") and time > 0 and time >= time_used and time_used > 0:
			$Player.position = get_global_mouse_position()
			time -= time_used
			if time <= 0:
				time = 0
	
		if Input.is_action_just_pressed("scroll_up") and $Player/Camera.zoom < Vector2(1,1):
			$Player/Camera.zoom += Vector2(.1, .1)
	
		if Input.is_action_just_pressed("scroll_down") and $Player/Camera.zoom > Vector2(0.1,0.1):
			$Player/Camera.zoom -= Vector2(.1, .1)
