extends Camera3D

@onready var rotation_x = rotation_degrees.x
@onready var rotation_y = rotation_degrees.y
@onready var start_y = rotation_degrees.y
#@onready var rotation_z = 0.0
@onready var spawn = $SpawnPoint
@onready var is_taken = false
@onready var viewpoint = $InspectPoint

const TestItem = preload("res://TestItem/Box.tscn")
const Ring = preload("res://scenes/gold_band_ring_fbx.tscn")
@onready var item
@onready var coords
@onready var target_item_rotation_x = 0.0
@onready var target_item_rotation_y = 0.0
@onready var curr_item_rotation_x = 0.0
@onready var curr_item_rotation_y = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	await get_tree().current_scene.ready
	
	item = Ring.instantiate()
	get_tree().current_scene.add_child(item)
	item.global_transform = spawn.global_transform
	coords = item.global_transform

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("PickUp") and !is_taken:
		pick_up()
	elif Input.is_action_just_pressed("PickUp"):
		put_back()
	rotation_degrees.y = lerp(rotation_degrees.y, rotation_y, 12.0 * delta)
	rotation_degrees.x = lerp(rotation_degrees.x, rotation_x, 12.0 * delta)
	#var direction = Input.get_axis("Right", "Left")
	#rotation_x += direction * delta 
	#rotation_y += direction * delta * 90
	#rotation_y = clamp(rotation_y, 135, 225)
	#rotation_degrees.y = rotation_y
	if is_taken:
		var next_x = lerp(curr_item_rotation_x, target_item_rotation_x, 12.0 * delta)
		var next_y = lerp(curr_item_rotation_y, target_item_rotation_y, 12.0 * delta)
		item.rotate(global_transform.basis.y.normalized(), next_y - curr_item_rotation_y)
		item.rotate(global_transform.basis.x.normalized(), next_x - curr_item_rotation_x)
		curr_item_rotation_x = next_x
		curr_item_rotation_y = next_y

func pick_up():
	target_item_rotation_x = 0.0
	target_item_rotation_y = 0.0
	curr_item_rotation_x = 0.0
	curr_item_rotation_y = 0.0
	is_taken = true
	item.reparent(viewpoint)
	var tween := create_tween().set_parallel(true)
	tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	
	tween.tween_property(item, "position", Vector3.ZERO, 0.4)
	tween.tween_property(item, "rotation", Vector3.ZERO, 0.4)
	
func put_back():
	is_taken = false
	item.reparent(get_tree().current_scene)
	var tween := create_tween().set_parallel(true)
	tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(item, "global_transform", coords, 0.4)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED and is_taken == false:
		rotation_y = clamp(rotation_y - event.relative.x * 0.05, start_y - 45.0, start_y + 45.0)
		rotation_x = clamp(rotation_x - event.relative.y * 0.05, -60.0, 60.0)
	elif event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED and is_taken == true:
		target_item_rotation_x += event.relative.y * 0.003
		target_item_rotation_y += event.relative.x * 0.003
