extends Node

@export var client_scene: PackedScene
@export var spawn_point: Marker3D

var current_client: Node3D = null


func _ready() -> void:
	spawn_client()


func spawn_client() -> void:
	if current_client != null:
		return

	if client_scene and spawn_point:
		current_client = client_scene.instantiate()

		add_child(current_client)

		current_client.global_position = spawn_point.global_position
		current_client.global_rotation = spawn_point.global_rotation


func dismiss_client() -> void:
	if current_client != null:
		current_client.queue_free()
		current_client = null

		await get_tree().create_timer(1.5).timeout
		spawn_client()
