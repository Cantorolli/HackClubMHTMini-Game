extends RichTextLabel
@onready var timer: Timer = $"../Timer"
@onready var v_slider: VSlider = $"../../VSlider"
@onready var circle_moving: Sprite2D = $"../../CircleMoving"

func _ready() -> void:
	circle_moving.material.set_shader_parameter("coloradditive",Color("cc001d"))

func _physics_process(_delta: float) -> void:
	self.add_theme_color_override("default_color", Color.RED)
	var tl:float = timer.time_left
	var seconds = v_slider.value
	if  tl >= (seconds/2): 
		self.add_theme_color_override("default_color", Color.RED)
		circle_moving.material.set_shader_parameter("coloradditive",Color("cc001d"))
	elif tl >= (seconds/3) and tl <= (seconds/2): 
		self.add_theme_color_override("default_color", Color.LIME)
		circle_moving.material.set_shader_parameter("coloradditive",Color("92c62f"))
	elif tl >= (seconds/4) and tl <= (seconds/3): 
		self.add_theme_color_override("default_color", Color.SEA_GREEN)
		circle_moving.material.set_shader_parameter("coloradditive",Color("009563"))
	elif tl <= (seconds/4) and tl >= (seconds/8): 
		self.add_theme_color_override("default_color", Color.YELLOW)
		circle_moving.material.set_shader_parameter("coloradditive",Color("cca100"))
	else: 
		self.add_theme_color_override("default_color", Color.DARK_MAGENTA)
		circle_moving.material.set_shader_parameter("coloradditive",Color("3c003e"))
