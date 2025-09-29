extends Control

var nextscene = preload("res://FinalScenes/new_timing_scene.tscn")
@onready var animation_player: AnimationPlayer = $AnimationPlayer



func _on_button_pressed() -> void:
	animation_player.play("fadeout")
	await animation_player.animation_finished
	get_tree().change_scene_to_packed(nextscene)
