class_name PawnItem extends StaticBody3D

@export var data: ItemData

@onready var mesh_instance: MeshInstance3D = $MeshInstance3D


func _ready() -> void:
	if data:
		setup(data)


func setup(new_data: ItemData) -> void:
	data = new_data
	if data and data.model_scene:
		var model = data.model_scene.instantiate()
		add_child(model)


func get_actual_value() -> int:
	if not data:
		return 0
	if data.is_fake:
		return int(data.base_value * 0.1)
	return data.base_value
