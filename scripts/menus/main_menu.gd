extends Control
@onready var cars: PanelContainer = $Cars
@onready var foto: TextureRect = $Cars/VBoxContainer/HBoxContainer/vboxContainer/TextureRect

func _ready():
#	Make sure to handle disconnects!
	GDSync.disconnected.connect(disconnected)


func disconnected():
#	Diconnected. Jump back to main menu
	get_tree().change_scene_to_file("res://scenes/start_menu.tscn")

func _on_garage_pressed() -> void:
	cars.show()


func _on__pressed() -> void:
	foto.texture=load("res://assets/cars/images/1.png")
	GDSync.set_player_data("Car", "1")


func _on_thunder_pressed() -> void:
	foto.texture=load("res://assets/cars/images/2.png")
	GDSync.set_player_data("Car", "2")


func _on_select_pressed() -> void:
	cars.hide()


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/player_name.tscn")


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/lobby_browsing_menu.tscn")
