extends Node3D

@onready var lt = [preload("res://models/gold_ring/source/gold_band_ring.fbx"), preload("res://TestItem/Box.tscn")]

@onready var summ = randi_range(500, 500000)
@onready var item = lt.pick_random()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
