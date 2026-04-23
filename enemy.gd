extends CharacterBody3D

var direction : Vector3
var input_dir : Vector2
const SPEED = 5.0
const SSPEED = 10.0
const JUMP_VELOCITY = 9

@onready var camPiv = $CamPivot
@onready var model = $Character
@onready var mesh: MeshInstance3D = $Character/MeshInstance3D

@onready var player: CharacterBody3D = $"../../Player"


var dt : float
var targetRot = 0
@export var health = randf_range(3,5)
@export var score : int = 0


var camForw : Vector3

enum States {IDLE, MOVE, FALLING, STOMPING}

var state = States.MOVE

@onready var hitbox_maker: Node = $Scripts/HitboxMaker

const COIN = preload("uid://bv70mfmja1pjf")

var toPlr : Vector3

var canMove = false

@onready var animTree: AnimationTree = $AnimationTree


func flatten(vector: Vector3) -> Vector3:
	return Vector3( vector.x, 0, vector.z)

func move() -> void:
	model.rotation.y = lerp_angle(model.rotation.y, targetRot, .5)
	if direction:
		velocity.x = lerp(velocity.x, direction.x * SPEED, dt * 8)
		velocity.z = lerp(velocity.z, direction.z * SPEED, dt * 8)
		targetRot = atan2(-direction.x, -direction.z)
	else:
		if is_on_floor():
			velocity = lerp(velocity, Vector3.ZERO + Vector3(0,velocity.y,0), 8 * dt)
	animTree.set("parameters/Run/blend_position", flatten(velocity).length()/SPEED)
	
func _physics_process(delta: float) -> void:
	dt = delta
	
	toPlr =  position - player.position
	
	if not canMove:
		canMove = (toPlr.length() < 19)

	if not is_on_floor():
		velocity += get_gravity() * delta

	input_dir = Input.get_vector("Left", "Right", "Up", "Down")
	#direction = flatten($CamPivot.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	direction = flatten(toPlr.normalized())
	
	if canMove == true:
		move()
	move_and_slide()
	
	isDead()
	
	
	
func jump() -> void:
	velocity.y = JUMP_VELOCITY


func isDead() -> void:
	if health <= 0:
		spawnCoin()
		queue_free()


func spawnCoin() -> void:
	var new : Area3D = COIN.instantiate()
	$"../../GameStuff".add_child(new)
	new.position = position

func knockBack() -> void:
	velocity = flatten(toPlr).normalized() * 30
