extends Node3D
@onready var carro: VehicleBody3D=$".."
@onready var cam: Camera3D=$SpringArm3D/Camera3D
var look_at


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	look_at=global_position
	multiplayer_update.call_deferred()
func multiplayer_update():
#	Only enable the camera for YOUR player model
	cam.current = GDSync.is_gdsync_owner(self)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	cam.global_position=cam.global_position.lerp(carro.global_position, delta)
	#transform=transform.interpolate_with(carro.transform, delta*5)
	look_at=look_at.lerp(carro.global_position, 1)
	cam.look_at(look_at)
	
