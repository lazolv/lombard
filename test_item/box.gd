extends CSGBox3D

@onready var rotation_x = 0
@onready var rotation_y = 0
@onready var rotation_z = 0
@onready var is_taken = false


func _process(_delta: float) -> void:
    if Input.is_action_just_pressed('PickUp'):
        is_taken = !is_taken


func _input(event: InputEvent) -> void:
    if event is InputEventMouseMotion and is_taken:
        rotation_degrees.x -= event.relative.y * 0.1
        rotation_degrees.y -= event.relative.x * 0.1
