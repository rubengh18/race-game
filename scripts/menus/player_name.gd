extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
#	Make sure to handle disconnects!
	GDSync.disconnected.connect(disconnected)


func disconnected():
#	Diconnected. Jump back to main menu
	get_tree().change_scene_to_file("res://scenes/start_menu.tscn")

func _on_continue_pressed():
	if %Username.text.length() == 0: return
	
#	Set the player's username so it may be displayed in lobbies and games.
	GDSync.set_player_username(%Username.text)
	
	
	get_tree().change_scene_to_file("res://scenes/lobby_browsing_menu.tscn")


func _on_back_pressed() -> void:
	GDSync.stop_multiplayer()
