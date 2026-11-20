class_name FreeLookCamera extends Camera3D

@export_range(0.0, 1.0) var sensitivity: float = 0.25

var last_mouse_movement_offset = Vector2(0.0, 0.0)


func _input(event):
    if event is InputEventMouseMotion:
        last_mouse_movement_offset = event.relative
    if event is InputEventMouseButton:
        match event.button_index:
            MOUSE_BUTTON_RIGHT:
                Input.set_mouse_mode(
                    Input.MOUSE_MODE_CAPTURED if event.pressed else Input.MOUSE_MODE_VISIBLE
                )


func _process(_delta):
    update_mouse_look()


func update_mouse_look():
    if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
        last_mouse_movement_offset *= sensitivity
        var yaw = last_mouse_movement_offset.x
        var pitch = last_mouse_movement_offset.y
        last_mouse_movement_offset = Vector2(0, 0)

        rotate_y(deg_to_rad(-yaw))
        rotate_object_local(Vector3(1, 0, 0), deg_to_rad(-pitch))
