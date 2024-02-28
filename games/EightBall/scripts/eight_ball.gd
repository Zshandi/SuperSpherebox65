extends Game

@export
var possible_good_fortunes: Array[String] = []
var good_fortune_to_use: String

@export
var possible_bad_fortunes: Array[String] = []
var bad_fortune_to_use: String

@export
var possible_uncertain_fortunes: Array[String] = []
var uncertain_fortune_to_use: String

@export
var possible_leaving_phrases: Array[String] = []
@export
var possible_gone_phrases: Array[String] = []
@export
var chance_to_leave: float = 0.3
@export
var min_max_leave_time: Vector2i = Vector2i(10, 50)

@export
var weird_fortunes: Array[WeirdFortune] = []
@export
var weird_fortune_chance: float = 1

@onready var background = $ScrollingBackground
@onready var color_rect = $ColorRect
@onready var eight_ball_sprite = $Sprite2D
@onready var game_over = $GameOver

var fortunes:Array[String]

var weird_fortune:WeirdFortune
var weird_fortune_num:int = Main.INT_MAX

var leave_fortune_num:int = Main.INT_MAX
var leaving_phrase:String
var gone_phrase:String

var is_gone:bool = false

var num_fortunes:int = 1

func _load_save_data(save_data:Dictionary):
	if save_data.has("num_fortunes"):
		num_fortunes = save_data["num_fortunes"]

func save_game_data():
	var save_dict := {}
	save_dict["num_fortunes"] = num_fortunes
	save_game.emit(save_dict)

func _ready():
	background.sprite.modulate = Color(randf(),randf(),randf(),1)
	background.color_rect.color = Color(randf(),randf(),randf(),1)
	
	# grab fortunes
	good_fortune_to_use = possible_good_fortunes.pick_random()
	bad_fortune_to_use = possible_bad_fortunes.pick_random()
	uncertain_fortune_to_use = possible_uncertain_fortunes.pick_random()
	
	fortunes = [good_fortune_to_use, bad_fortune_to_use, uncertain_fortune_to_use]
	
	# determine if and when we will leave, and what to say
	if randf() < chance_to_leave:
		leave_fortune_num = randi_range(min_max_leave_time[0], min_max_leave_time[1])
		leaving_phrase = possible_leaving_phrases.pick_random()
		gone_phrase = possible_gone_phrases.pick_random()
		print_debug("\nleaving fortune: ", [leaving_phrase, gone_phrase])
		print_debug("leaving fortune num: ", leave_fortune_num)
	
	# determine if we should have a weird fortune, and which one we should use
	if randf() < weird_fortune_chance:
		var total_weight:float = 0
		for fortune:WeirdFortune in weird_fortunes:
			total_weight += fortune.fortune_chance_weight
		var chance = randf_range(0, total_weight)
		total_weight = 0
		for fortune:WeirdFortune in weird_fortunes:
			if chance - total_weight <= fortune.fortune_chance_weight:
				weird_fortune = fortune
				break
			total_weight += fortune.fortune_chance_weight
		weird_fortune_num = randi_range(weird_fortune.num_fortune_min_max[0], weird_fortune.num_fortune_min_max[1])
		print_debug("\nweird fortune: ", weird_fortune.fortune_sequence)
		print_debug("weird fortune num: ", weird_fortune_num)
	
	# grab image to use
	eight_ball_sprite.texture = game_instance_data.game_image_2
	eight_ball_sprite.modulate = game_instance_data.game_image_color_2
	
	# Get the rng back to state the game was last played
	for i in range(num_fortunes):
		_randomize_fortune()
	
	if is_gone:
		# Don't play leaving animation,
		#  if already gone when started
		eight_ball_sprite.hide()
	
	_randomize_fortune()


func _process(delta):
	if Input.is_action_just_pressed("six"):
		if not game_over.is_visible():
			game_over.show()
			print_debug("num_fortunes: ", num_fortunes)
			num_fortunes += 1
			save_game_data()
		else:
			if is_gone && eight_ball_sprite.is_visible() && !$AnimationPlayer.is_playing():
				$AnimationPlayer.play("leave")
				$AnimationPlayer.animation_finished.connect( func(_n):
					eight_ball_sprite.hide() )
			game_over.hide()
			_randomize_fortune()

func _randomize_fortune():
	if generate_leaving_fortune(): return
	
	if generate_weird_fortune(): return
	
	game_over.set_fortune(fortunes.pick_random())

func generate_leaving_fortune() -> bool:
	if num_fortunes == leave_fortune_num:
		game_over.set_fortune(leaving_phrase)
		is_gone = true
		return true
	
	if num_fortunes > leave_fortune_num:
		is_gone = true
		game_over.set_fortune(gone_phrase)
		return true
	
	return false

func generate_weird_fortune() -> bool:
	var index = num_fortunes - weird_fortune_num
	
	if index >= 0:
		var fortune_seq = weird_fortune.fortune_sequence
		if index < fortune_seq.size():
			game_over.set_fortune(fortune_seq[index])
			return true
	
	return false
