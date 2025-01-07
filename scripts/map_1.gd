extends Node3D

var PLAYER_SCENE : PackedScene = load("res://scenes/car1.tscn")
var ran={}
var cont=0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused=true
	GDSync.expose_func(start)
	GDSync.expose_func(_on_tiempo_timeout)
	GDSync.expose_func(update_cont)
	GDSync.expose_func(_on_finish_body_entered)
	ran=GDSync.get_lobby_data("ranking")
	
	start()
	
func _enter_tree():
#	Connect all relevant signals. Make sure to handle disconnects!
	GDSync.client_joined.connect(client_joined)
	GDSync.client_left.connect(client_left)
	GDSync.disconnected.connect(disconnected)
	
#	Add player models for all clients already ingame
	for id in GDSync.get_all_clients():
		client_joined(id)

func disconnected():
	get_tree().change_scene_to_file("res://scenes/start_menu.tscn")

func client_joined(client_id : int):
#	Instantiate a player
	var player : Node = PLAYER_SCENE.instantiate()
	
#	Make the ID their name for easy identification
	player.name = str(client_id)
	player.position = $StartLocation.position
	player.rotation.y=180
	add_child(player)
	
#	Make sure to make the client the owner of their own player controller
	GDSync.set_gdsync_owner(player, client_id)

func client_left(client_id : int):
#	When a client leaves, delete their player controller
	var player_string : String = str(client_id)
	if has_node(player_string):
		get_node(player_string).queue_free()

func _process(delta: float) -> void:
	%Inicio.text=str(int(%Tiempo.time_left))

func start():
	%Inicio.text="Iniciando..."
	%Tiempo.start()
	
	


func _on_tiempo_timeout() -> void:
	$Control.hide();
	get_tree().paused=false

func update_cont():
	cont+=1


	


func _on_finish_body_entered(body: Node3D) -> void:
	update_cont()
	print(body)
	ran[str(cont)]=GDSync.get_player_data(body.name.to_int(), "Username", "Unknow")
	GDSync.set_lobby_data("ranking", ran)
	$Meta.show()
	
	%Positions.text=ran



	
