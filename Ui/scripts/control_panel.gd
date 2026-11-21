extends Control

@onready var money_label = $MarginContainer/VBoxContainer/HSlider/HBoxContainer/Label2
@onready var money_slider = $MarginContainer/VBoxContainer/HSlider
@onready var v1_button = $MarginContainer/VBoxContainer/HBoxContainer2/Button
@onready var v2_button = $MarginContainer/VBoxContainer/HBoxContainer2/Button2
@onready var is_pressed1 = false
@onready var is_pressed2 = false
@onready var start_style = v1_button.modulate

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	money_slider.max_value = Game.money

func _on_h_slider_value_changed(value: float) -> void:
	money_label.text = str(money_slider.value) + " ₽"


func _on_button_2_pressed() -> void:
	v2_button.modulate = Color.GREEN
	v1_button.modulate = start_style
	is_pressed2 = true
	is_pressed1 = false


func _on_button_pressed() -> void:
	v1_button.modulate = Color.GREEN
	v2_button.modulate = start_style
	is_pressed1 = true
	is_pressed2 = false
