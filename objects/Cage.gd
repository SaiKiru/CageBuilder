extends Spatial
class_name Cage


func build_wall(from: Vector3, to: Vector3) -> void:
	if from.x == to.x:
		var _range: Array = Utils.min_max_range(from.z, to.z)

		for i in _range:
			_add_wall(
				Vector3(from.x, from.y, i),
				Vector3(from.x, from.y, i + 1)
			)
	elif from.z == to.z:
		var _range: Array = Utils.min_max_range(from.x, to.x)

		for i in _range:
			_add_wall(
				Vector3(i, from.y, from.z),
				Vector3(i + 1, from.y, from.z)
			)


func _add_wall(from: Vector3, to: Vector3) -> void:
	var new_panel: Wall = Wall.new(from, to)

	add_child(new_panel)
