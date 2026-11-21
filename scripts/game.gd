extends Node

var client_scene: PackedScene = preload("res://scenes/client.tscn")
var client_spawn_point: Marker3D

var current_client: Node3D = null

signal money_changed(new_amount: int)


func _ready() -> void:
	await get_tree().process_frame
	spawn_client()


func spawn_client() -> void:
	assert(not current_client)
	current_client = client_scene.instantiate()
	add_child(current_client)
	current_client.global_position = client_spawn_point.global_position
	current_client.global_rotation = client_spawn_point.global_rotation


func dismiss_client() -> void:
	assert(current_client)
	current_client.queue_free()
	current_client = null

	await get_tree().create_timer(1.5).timeout
	spawn_client()


var money: int = 500:
	set(value):
		money = value
		money_changed.emit(money)


func add_money(amount: int) -> void:
	money += amount


func spend_money(amount: int) -> bool:
	if money >= amount:
		money -= amount
		return true
	return false
