extends Spatial
class_name CagePanel


var grid_position: Vector3 = Vector3(0, 0, 0) # currently unused
var panel_size: Vector2

var _mesh: MeshInstance

onready var Materials = {
	"BLACK_PANEL": preload("res://assets/materials/BlackPanelMaterial.tres")
}


func _init(size: Vector2 = Vector2(1, 1)) -> void:
	panel_size = size


func _ready() -> void:
	_mesh = MeshInstance.new()
	var display_mesh = PlaneMesh.new()

	add_child(_mesh)

	display_mesh.material = Materials.BLACK_PANEL
	display_mesh.size = panel_size
	_mesh.set_mesh(display_mesh)
