extends Area3D

var foundAreas = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Lifetime.timeout.connect(queue_free)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_entered(area: Area3D) -> void:
	for i : int in foundAreas.size():
		if is_instance_valid(foundAreas[i]):
			if area == foundAreas[i]:
				
				return
	
	#if not hit already:
	if not area.is_queued_for_deletion():
	
		if area.has_method("damage"):
			area.damage(GlobalData.PlayerDamage)
		foundAreas.append(area)
