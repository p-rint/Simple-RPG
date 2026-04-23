extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func _on_speed_pressed() -> void:
	if GlobalData.PlayerCoins >= 2:
		GlobalData.PlayerCoins -= 2
		GlobalData.SPEED += 2


func _on_damage_pressed() -> void:
	if GlobalData.PlayerCoins >= 20:
		GlobalData.PlayerCoins -= 20
		GlobalData.PlayerDamage += 1
