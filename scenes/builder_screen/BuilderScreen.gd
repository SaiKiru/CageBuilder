extends Node

var scene_camera: Spatial

var mouse_is_pressed: bool = false
var mouse_initial_position: Vector2 = Vector2(0, 0)

func _ready():
	scene_camera = get_node("CameraHelper")


func _input(event):
	if (event is InputEventMouseButton):
		if event.is_pressed():
			mouse_is_pressed = true
			mouse_initial_position = event.position
		else:
			mouse_is_pressed = false
			mouse_initial_position = Vector2(0, 0)

	if (event is InputEventMouseMotion and mouse_is_pressed):
		var distance = event.position - mouse_initial_position
		scene_camera.rotate_y(distance.x / -7000)
