extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GDSync.connected.connect(connected)
	GDSync.connection_failed.connect(connection_failed)
	
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func connected():
#	Connected! Continue on to the customization screen
	%Connect.disabled = true
	get_tree().change_scene_to_file("res://scenes/player_name.tscn")

func _on_connect_pressed() -> void:
	%Connect.disabled = true
	
#	Start the multiplayer plugin
	GDSync.start_multiplayer()
	
	
func connection_failed(error : int):
#	Connection failed. Display the possible error messages
	%Connect.disabled = false
	%Message.modulate = Color.INDIAN_RED
	match(error):
		ENUMS.CONNECTION_FAILED.INVALID_PUBLIC_KEY:
			%Message.text = "The public or private key you entered were invalid."
		ENUMS.CONNECTION_FAILED.TIMEOUT:
			%Message.text = "Unable to connect, please check your internet connection."
