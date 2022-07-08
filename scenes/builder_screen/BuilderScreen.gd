extends Node


enum Modes {
	MOVE,
	DRAW,
}

var _mode: int = Modes.MOVE

var _mouse_is_pressed: bool = false
var _mouse_initial_position: Vector2 = Vector2(0, 0)

onready var _camera_helper: Spatial = get_node("CameraHelper")
onready var _camera: Camera = get_node("CameraHelper/Camera")
onready var _cage: Cage = get_node("Cage")
onready var _build_guide_arrow: Spatial = get_node("BuildGuideArrow")


func _input(event) -> void:
	if event is InputEventMouseButton:
		var type: int = event.get_button_index()

		# set mode
		if type == BUTTON_MIDDLE:
			_mode = Modes.MOVE
		elif type == BUTTON_LEFT:
			_mode = Modes.DRAW
		elif type == BUTTON_WHEEL_UP:
			_zoom_in()
		elif type == BUTTON_WHEEL_DOWN:
			_zoom_out()

		# store event details
		if event.is_pressed():
			_mouse_is_pressed = true
			_mouse_initial_position = event.position
		else:
			if _mode == Modes.DRAW:
				var grid_target_from: Vector3 = _get_grid_target(_mouse_initial_position)
				var grid_target_to: Vector3 = _get_grid_target(event.position)

				_cage.build_wall(grid_target_from, grid_target_to)

			_reset_mouse_event()

	if event is InputEventMouseMotion:
		var grid_target: Vector3 = _get_grid_target(event.position)
		_move_guide_arrow(grid_target)

		if _mouse_is_pressed:
			if _mode == Modes.MOVE:
				var rotation_value: float = deg2rad(event.position.x - _mouse_initial_position.x) / -4
				_rotate_camera(rotation_value)

				_mouse_initial_position = event.position


func _reset_mouse_event():
	_mouse_is_pressed = false
	_mouse_initial_position = Vector2(0, 0)


func _rotate_camera(value) -> void:
	_camera_helper.rotate_y(value)


func _zoom_in() -> void:
	_camera.translate_object_local(Vector3(0, 0, -0.10))


func _zoom_out() -> void:
	_camera.translate_object_local(Vector3(0, 0, 0.10))


func _move_guide_arrow(position: Vector3) -> void:
	_build_guide_arrow.translation = position


func _get_grid_target(position) -> Vector3:
	var ray_origin = _camera.project_ray_origin(position)
	var ray_normal = _camera.project_ray_normal(position)

	var target = Vector3(
		round(ray_origin.x - ray_normal.x * ray_origin.y / ray_normal.y),
		0,
		round(ray_origin.z - ray_normal.z * ray_origin.y / ray_normal.y)
	)

	return target
