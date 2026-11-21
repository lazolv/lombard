extends Label


func _ready() -> void:
	update_display(Game.money)
	Game.money_changed.connect(update_display)


func update_display(new_amount: int) -> void:
	text = "₽" + str(new_amount)
