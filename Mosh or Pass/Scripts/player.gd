extends CharacterBody2D


@export var SPEED = 70.0
@export var JUMP_VELOCITY = 200.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var wall_detect = $Rays/WallDetect
@onready var graphics = $Graphics
@onready var rays = $Rays


func _physics_process(delta):
	
	var direction = Input.get_axis("move_L", "move_R")
	if direction:
		velocity.x = move_toward(0, SPEED * direction, 50)
		
		if direction < 0:
			graphics.flip_h = true
			rays.scale.x = -1
		elif direction > 0:
			graphics.flip_h = false
			rays.scale.x = 1
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if Input.is_action_just_pressed("jump") and (is_on_floor() or wall_detect.is_colliding()):
		velocity.y = -JUMP_VELOCITY
		if wall_detect.is_colliding():
			velocity.x = 70 * -direction
	
	move_and_slide()
