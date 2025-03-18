extends Node2D

@export var player_detection_radius: float = 100.0

@onready var closed_sprite = $Closed
@onready var open_sprite = $Open
@onready var open_sfx = $OpenSFX
@onready var close_sfx = $CloseSFX
@onready var area2d = $Area2D

var is_door_open = false

# Called when the node enters the scene tree for the first time.
func _ready():
	# Initially, door is closed, and the open sprite is hidden.
	open_sprite.visible = false
	closed_sprite.visible = true

	# Connect the signals to their respective handler functions
	area2d.body_entered.connect(Callable(self, "_on_body_entered"))
	area2d.body_exited.connect(Callable(self, "_on_body_exited"))

# Called when the player enters the area (within the detection range)
func _on_body_entered(body):
	if body.is_in_group("Player"): # Ensure the body is the player
		open_door()

# Called when the player leaves the area (out of the detection range)
func _on_body_exited(body):
	if body.is_in_group("Player"): # Ensure the body is the player
		close_door()

# Function to open the door and play the open sound
func open_door():
	if not is_door_open:
		is_door_open = true
		closed_sprite.visible = false
		open_sprite.visible = true
		open_sfx.play()  # Play the opening sound
		open_sfx.pitch_scale = randf_range(0.5,1.5)

# Function to close the door and play the close sound
func close_door():
	if is_door_open:
		is_door_open = false
		open_sprite.visible = false
		closed_sprite.visible = true
		close_sfx.play()  # Play the closing sound
		close_sfx.pitch_scale = randf_range(0.5,1.5)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
