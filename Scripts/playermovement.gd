extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -100.0

@onready var appearance = $Appearance  # Reference to the Sprite2D node

func _physics_process(delta):
	# Add gravity
	if not is_on_floor():
		velocity.y += get_gravity().y * delta

	# Handle jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle movement
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		appearance.flip_h = direction < 0  # Flip sprite when moving left
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
