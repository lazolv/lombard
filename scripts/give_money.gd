extends Button


func _pressed() -> void:
    if Game.current_client:
        Game.dismiss_client()
