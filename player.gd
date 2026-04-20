extends CharacterBody3D

var direction : Vector3
var input_dir : Vector2
const SPEED = 13.0
const SSPEED = 10.0
const JUMP_VELOCITY = 9

@onready var camPiv = $CamPivot
@onready var model = $Character
@onready var mesh: MeshInstance3D = $Character/MeshInstance3D


var dt : float
var targetRot = 0
@export var health = 99
@export var coins : int = 0

@onready var animPlr: AnimationPlayer = $AnimationPlayer

var camForw : Vector3

enum States {IDLE, MOVE, FALLING, STOMPING}

var state = States.MOVE

@onready var hitbox_maker: Node = $Scripts/HitboxMaker



func flatten(vector: Vector3) -> Vector3:
	return Vector3( vector.x, 0, vector.z)

func move() -> void:
	model.rotation.y = lerp_angle(model.rotation.y, targetRot, dt * 12)
	if direction:
		velocity.x = lerp(velocity.x, direction.x * SPEED, dt * 8)
		velocity.z = lerp(velocity.z, direction.z * SPEED, dt * 8)
		targetRot = atan2(-direction.x, -direction.z)
	else:
		if is_on_floor():
			velocity = lerp(velocity, Vector3.ZERO + Vector3(0,velocity.y,0), 8 * dt)

func _physics_process(delta: float) -> void:
	dt = delta
	camForw = flatten($CamPivot.basis.z)
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		jump()

	if Input.is_action_just_pressed("Attack") and is_on_floor():
		hitbox_maker.spawnHitbox()
		
	if Input.is_action_just_pressed("House") and is_on_floor():
		enterHouse()
	
	input_dir = Input.get_vector("Left", "Right", "Up", "Down")
	direction = flatten($CamPivot.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	move()
	move_and_slide()
	
func jump() -> void:
	velocity.y = JUMP_VELOCITY



func enterHouse() -> void:
	
	if GlobalData.inHouse == false:
		get_tree().change_scene_to_file("res://house.tscn")
	else:
		get_tree().change_scene_to_file("res://main.tscn")
	
	GlobalData.inHouse = not GlobalData.inHouse
