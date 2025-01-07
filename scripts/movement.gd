extends VehicleBody3D
@export var MAX_STEER=0.4
@export var MAX_ENGINE=700
var reloading=false
@onready var rueda:VehicleWheel3D=$left_rear
@onready var _username: Label3D = $Username
@onready var ray: RayCast3D = $RayCast3D
@onready var col: CollisionShape3D=$Collision

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	set_multiplayer_data.call_deferred()
	%Acel.pitch_scale=0.3
	%Acel.volume_db=0.0

func set_multiplayer_data():
	var client_id : int = name.to_int()
#	Give the player model the color of this client
#	Display the username of this client
	_username.text = GDSync.get_player_data(client_id, "Username", "Unkown")
#	Make sure to only display the username of OTHER players, not yourself
	_username.visible = !GDSync.is_gdsync_owner(self)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	# Comportamiento normal si no se está recargando
	steering = move_toward(steering, Input.get_axis("right", "left") * MAX_STEER, delta * 5)
	engine_force=Input.get_axis("backward", "forward")*MAX_ENGINE
	if Input.is_action_pressed("forward"):
		%Acel.pitch_scale=lerpf(%Acel.pitch_scale, 0.7, delta*0.7)
		%Acel.volume_db=lerpf(%Acel.volume_db, 80.0, delta)
	else:
		%Acel.pitch_scale=lerpf(%Acel.pitch_scale, 0.3, delta*0.3)
		%Acel.volume_db=lerpf(%Acel.volume_db, 0, delta)
	
	if linear_velocity.length()*3.6>=45:
		$Control.show()
	else:
		$Control.hide()
		
	if !ray.is_colliding() and not reloading:
		rotation.z+=Input.get_axis("rotate_l", "rotate_r")/10
	
	
