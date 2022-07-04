extends Node


var _mouse_is_pressed: bool = false
var _mouse_initial_position: Vector2 = Vector2(0, 0)

onready var _camera_helper: Spatial = get_node("CameraHelper")
onready var _camera: Camera = get_node("CameraHelper/Camera")


func _input(event) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			_mouse_is_pressed = true
			_mouse_initial_position = event.position
		else:
			_mouse_is_pressed = false
			_mouse_initial_position = Vector2(0, 0)

	if event is InputEventMouseMotion and _mouse_is_pressed:
		var rotation_value = deg2rad(event.position.x - _mouse_initial_position.x) / -200
		_rotate_camera(rotation_value)


func _rotate_camera(value) -> void:
	_camera_helper.rotate_y(value)
