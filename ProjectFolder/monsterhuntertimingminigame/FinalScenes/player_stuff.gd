extends Node2D
var poses: Dictionary = {"DFault":0,"UP":-51,"Fail":25}
@onready var arm_hinge: Node2D = $ArmHinge
var particlemanager = null

func UPDATE(ynb):                                                                                                                
	if ynb == "good":
		arm_hinge.rotation = deg_to_rad(-51.0)
		if particlemanager != null: particlemanager.emitting = true
		await get_tree().create_timer(.5).timeout
		arm_hinge.rotation = deg_to_rad(0)
		
	elif ynb == "bad":
		arm_hinge.rotation = deg_to_rad(25)
		await get_tree().create_timer(.5).timeout
		arm_hinge.rotation = deg_to_rad(0)
	else:
		pass

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
