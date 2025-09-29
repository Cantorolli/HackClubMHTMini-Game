extends Node2D

@onready var timingcircle = preload("res://BetaMechanics/neo_timing_core.tscn")
@onready var player_stuff: Node2D = $PlayerStuff
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D
@onready var khezu: Node2D = $Khezu
@onready var scoreL: RichTextLabel = $Control/Score
@onready var h_box_container: HBoxContainer = $Control/HBoxContainer
@onready var deadman: Control = $Deadman
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var hp = 3
var timercurrentlyout = false
var score = 0
var playerinitialized = false

func _ready() -> void:
	animation_player.play("fadein")
	player_stuff.particlemanager = cpu_particles_2d
	cla.controller_node = self

func _process(_delta: float) -> void:
	while hp > 0 and (timercurrentlyout == false and playerinitialized):
		khezu.get_child(1).play("Attack")
		_create_timecircle()
	if hp == 0:
		deadman.visible = true
		deadman.get_child(2).text = "[center]Final Score: " + str(score)

func _create_timecircle():
	if timercurrentlyout: pass
	else:
		timercurrentlyout = true
		var node_tb = timingcircle.instantiate()
		node_tb.ScaleCurve = load("res://CurveStorage/DestinationScaleCurve.tres")
		node_tb.PrimaryValue = 1.8
		node_tb.scale = Vector2(1.5,1.5)
		self.add_child(node_tb)

func _on_recieve(value):
	var scorescale:Array = ["Miss","Perfect","Good","Okay","Bad"]
	var comparison = scorescale.find(value)
	if comparison == 0 or comparison == 4:
		player_stuff.UPDATE("bad")
		hp -= 1
	elif comparison >= 1 and comparison <= 3:
		player_stuff.UPDATE("good")
		if comparison == 1: score += comparison * 1000
		elif comparison == 2: score += comparison * 400
		else: score += comparison * 200
	if hp < 3:
		h_box_container.get_child(hp).texture = load("res://Textures/HeartEmpty.png")
	khezu.get_child(1).play("Patient")
	scoreL.text = "YOUR SCORE: " + str(score)
	await get_tree().create_timer(randf_range(1.0,4.0)).timeout
	timercurrentlyout = false


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fadein": 
		await get_tree().create_timer(.5).timeout
		playerinitialized = true
