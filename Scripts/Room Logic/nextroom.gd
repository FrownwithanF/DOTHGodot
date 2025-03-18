extends Area2D

@export var room_scenes: Array = [
	"res://Scenes/Room Types/Generic.tscn"
]

func _ready():
	# Connect the body_entered signal to the handler function
	self.connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):  # Ensure the body is the player
		call("transport_player_to_random_room")  # Defer the room change to avoid collision issue

func transport_player_to_random_room():
	var new_room_index: int = randi() % room_scenes.size()  # Get a random index within room_scenes size
	
	var next_scene_path = room_scenes[new_room_index]
	GVar.current_room_index = new_room_index  # Update the global room index

	# Transition to the selected room scene
	await get_tree().process_frame
	await get_tree().physics_frame
	get_tree().change_scene_to_file(next_scene_path)
