extends Node3D

const ENEMY = preload("uid://3kcu5rdfotc0")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func spawnEnemy() -> void:
	var new : CharacterBody3D = ENEMY.instantiate()
	new.position = Vector3(randi_range(-90,90), 0, randi_range(-90,90))
	add_child(new)


func _on_spawn_timeout() -> void:
	if get_children().size() < 15:
		spawnEnemy()
