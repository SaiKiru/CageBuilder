extends CagePanel
class_name Wall


var _from: Vector3
var _to: Vector3


func _init(from: Vector3, to: Vector3) -> void: 
	_from = from
	_to = to


func _ready():
	_mesh.rotate_x(deg2rad(90))
	
	if _from.x == _to.x:
		_mesh.rotate_y(deg2rad(90))
		
	translation = (_from + _to) / 2
	_mesh.translation = Vector3(0, 0.5, 0)
