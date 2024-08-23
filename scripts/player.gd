extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jumping = false

@onready var animated_sprite_2d = $AnimatedSprite2D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		jumping = false

	# Handle jump.
	if Input.is_action_pressed("jump") and not jumping:
		jumping = true
		velocity.y = JUMP_VELOCITY

	# Get direction
	var direction = Input.get_axis("move_left", "move_right")
	
	# Flip sprite
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true
		
	# Play animations
	if not is_on_floor():
		animated_sprite_2d.play("jump")
	else:
		if direction == 0:
			animated_sprite_2d.play("idle")
		else: 
			animated_sprite_2d.play("run")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
