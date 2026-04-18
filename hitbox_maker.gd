extends Node

const HITBOX = preload("uid://b87u8xmpkbail")

@onready var game_stuff: Node3D = $"../../../GameStuff"
@onready var character: Node3D = $"../../Character"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func spawnHitbox() -> void:
	var new : Area3D = HITBOX.instantiate()
	character.add_child(new)
	
