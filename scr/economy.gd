extends Node

signal money_changed(new_amount: int)

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
