extends Node2D

@onready var pl_num_cubes_text = $"CanvasLayer/(Player)number of cubes"
@onready var bot_num_cubes_text = $"CanvasLayer/(Bot)number of cubes"
@onready var pl_score_text = $"CanvasLayer/Player_score/Name Player"
@onready var bot_score_text = $"CanvasLayer/bot_score/Name Bot"

@onready var pl_num_cubes = $"CanvasLayer/(Player)number of cubes/(Pl)number"
@onready var bot_num_cubes = $"CanvasLayer/(Bot)number of cubes/(Bot)number"

@onready var animation_players = $"CanvasLayer/Animation Players"
@onready var animation_scores = $"CanvasLayer/Animation scores"
@onready var animation_player_bot = $"CanvasLayer/Animation player_bot"
@onready var animation_focus_button = $"CanvasLayer/Animation focus_button"


@onready var bot_score_box = $CanvasLayer/bot_score

@onready var player_score_label = $CanvasLayer/Player_score/Score
@onready var bot_score_label = $CanvasLayer/bot_score/Score
@onready var player_vistrels_label = $"CanvasLayer/Player_vistrels/Name Player"
@onready var bot_vistrels_label = $"CanvasLayer/bot_vistrels/Name Bot"
@onready var player_vistrels_score = $CanvasLayer/Player_vistrels/Vistrels
@onready var bot_vistrels_score = $CanvasLayer/bot_vistrels/Vistrels


@onready var hand_r_blue = $"CanvasLayer/hands blue/HandBlue_r"
@onready var hand_l_blue = $"CanvasLayer/hands blue/HandBlue_l"
@onready var stakan_blue = $"CanvasLayer/stakan blue/stakan_up"

@onready var hand_r_red = $"CanvasLayer/hands red/HandRed_r"
@onready var hand_l_red = $"CanvasLayer/hands red/HandRed_l"
@onready var stakan_red = $"CanvasLayer/stakan red/stakan_up"


@onready var cubes = $"CanvasLayer/Cube 1"
@onready var cube_1 = $"CanvasLayer/Cube 1"
@onready var cube_2 = $"CanvasLayer/Cube 1/Cube 2"
@onready var gilza_pl = $CanvasLayer/gilza

@onready var pl_num = $"CanvasLayer/(Player)number of cubes/(Pl)number"
@onready var bot_num = $"CanvasLayer/(Bot)number of cubes/(Bot)number"

@onready var pl_win_green = $"CanvasLayer/player win"
@onready var bot_win_red = $"CanvasLayer/bot win"
@onready var draw_gray_up = $"CanvasLayer/No one won up"
@onready var draw_gray_down = $"CanvasLayer/No one won down"

@onready var focus_button = $CanvasLayer/FocusButton
@onready var tap_button = $"CanvasLayer/tap player"
@onready var screenshot_btn = $CanvasLayer/screenshot_btn

@onready var color_black = $CanvasLayer/black
@onready var color_white = $CanvasLayer/white

@onready var music = $music
@onready var fire_pistol = $Fire_pistol
@onready var fire_pistol_blank = $Fire_pistol_blank
@onready var pistol_reload = $Pistol_reload
@onready var padenie_gilzy = $padenie_gilzy


var cube_num1 = load("res://textures/game/cube bone/cube_num1.png")
var cube_num2 = load("res://textures/game/cube bone/cube_num2.png")
var cube_num3 = load("res://textures/game/cube bone/cube_num3.png")
var cube_num4 = load("res://textures/game/cube bone/cube_num4.png")
var cube_num5 = load("res://textures/game/cube bone/cube_num5.png")
var cube_num6 = load("res://textures/game/cube bone/cube_num6.png")


var random_pl_1 = RandomNumberGenerator.new()
var random_pl_2 = RandomNumberGenerator.new()
var random_bot_1 = RandomNumberGenerator.new()
var random_bot_2 = RandomNumberGenerator.new()

var random_live_bullets_pl = RandomNumberGenerator.new()
var random_live_bullets_bot = RandomNumberGenerator.new()

var vistrel_pl = 0
var vistrel_bot = 0

var player_score_global = 0
var bot_score_global = 0

var all_vistrels_pl = 0
var all_vistrels_bot = 0

var score = 1


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("F11"): 
		screenshot()

func screenshot(): 
	screenshot_btn.visible = false
	await  RenderingServer.frame_post_draw
	
	var _date = Time.get_date_string_from_system().replace(".","_")
	var _time :String = Time.get_time_string_from_system().replace(":","")
	
	var ss = "user://screenshots/" + "ss_" + _date+ "_" + _time + ".jpg"
	var img = get_viewport().get_texture().get_image()
	img.save_jpg(ss)
	if GameManager.screenshot_btn == 1:
		screenshot_btn.visible = true

func _on_screenshot_btn_pressed() -> void:
	screenshot()



func _ready():
	var dir = DirAccess.open("user://")
	dir.make_dir("screenshots")
	dir = DirAccess.open("user://screenshots")


	SaveManager.load_game()
	tap_button.disabled = true
	color_black.visible = true
	GameManager.pause = 0
	GameManager.pause_game = 0
	GameManager.pause_button_off = 1
	GameManager.start_game = 0
	GameManager.start_round = 1
	GameManager.music_game = 2

	player_score_label.text = str(player_score_global)
	bot_score_label.text = str(bot_score_global)
	player_vistrels_score.text = str(all_vistrels_pl)
	bot_vistrels_score.text = str(all_vistrels_bot)

	tap_button.visible = true
	color_white.visible = true
	animation_players.play("white_out")
	await get_tree().create_timer(0.7).timeout
	color_white.visible = false
	GameManager.music_game = 2
	cubes.visible = false
	GameManager.start_round = 0
	
	if GameManager.screenshot_btn == 1:
		screenshot_btn.visible = true
	if GameManager.screenshot_btn == 0:
		screenshot_btn.visible = false
	
	if GameManager.android_pc == 0:
		animation_players.play("start_anim_HandsOnTable")
	if GameManager.android_pc == 1:
		animation_players.play("start_anim_HandsOnTable_pc")
	color_black.visible = false
	await get_tree().create_timer(2.1).timeout
	
	
	random_live_bullets_pl = randi_range(1,3)
	random_live_bullets_bot = randi_range(1,3)
	print("------------------------")
	print("random_live_bullets_pl = %d" % random_live_bullets_pl)
	print("random_live_bullets_bot = %d" % random_live_bullets_bot)
	print("------------------------")
	
	random_bot_1 = randi_range(1,6)
	random_bot_2 = randi_range(1,6)
	
	random_num_cubes_bot()
	
	cubes.visible = true
	await get_tree().create_timer(1.8).timeout
	GameManager.pause_button_off = 0
	GameManager.start_round = 1
	GameManager.music_game = 1
	tap_button.disabled = false


func _process(_delta):
	if GameManager.music_game == 1:
		music.play()
		GameManager.music_game = 0
	elif GameManager.music_game == 2:
		music.stop()
	if GameManager.start_game == 1:
		pl_num.text = str(random_pl_1 + random_pl_2)
		bot_num.text = str(random_bot_1 + random_bot_2)
	else:
		if GameManager.start_game == 0:
			if GameManager.start_round == 1:
				animation_focus_button.play("focus_button_yellow")
			else:
				animation_focus_button.stop()
	if GameManager.start_round == 1:
		animation_focus_button.play("focus_button_yellow")
	elif GameManager.start_round == 0:
		animation_focus_button.stop()



	if GameManager.language == 1:
		pl_num_cubes_text.text = "(Player) Number of cubes:"
		pl_num_cubes.position.x = 201
		bot_num_cubes_text.text = "(Bot) Number of cubes:"
		bot_num_cubes.position.x = 180
		pl_score_text.text = "(Player) score:"
		bot_score_text.text = "(Bot) score:"
		player_vistrels_label.text = "(Player) gunshots:"
		bot_vistrels_label.text = "(Bot) gunshots:"
		bot_score_box.position.x = 865
		pl_win_green.text = " Player win"
		bot_win_red.text = "Bot win"
		draw_gray_up.text = "    Draw"
		draw_gray_down.text = "  Draw"
		pl_win_green.add_theme_font_size_override("font_size", 45)
		bot_win_red.add_theme_font_size_override("font_size", 45)


	elif GameManager.language == 2:
		pl_num_cubes_text.text = "(Игрок) Число очков:"
		pl_num_cubes.position.x = 165
		bot_num_cubes_text.text = "(Бот) Число очков:"
		bot_num_cubes.position.x = 147
		pl_score_text.text = "(Игрок) счёт:"
		bot_score_text.text = "(Бот) счёт:"
		player_vistrels_label.text = "(Игрок) выстрелы:"
		bot_vistrels_label.text = "(Бот) выстрелы:"
		bot_score_box.position.x = 855
		pl_win_green.text = "Игрок выиграл"
		bot_win_red.text = "Бот выиграл"
		draw_gray_up.text = "  Ничья"
		draw_gray_down.text = "Ничья"
		pl_win_green.add_theme_font_size_override("font_size", 26)
		bot_win_red.add_theme_font_size_override("font_size", 22)



func _on_tap_player_pressed():
	GameManager.start_game = 1
	GameManager.start_round = 0
	GameManager.pause_off = 1
	GameManager.pause_button_off = 1
	tap_button.disabled = true

	random_pl_1 = randi_range(1,6)
	random_pl_2 = randi_range(1,6)
	random_bot_1 = randi_range(1,6)
	random_bot_2 = randi_range(1,6)

	print("random_pl = %d" % (random_pl_1 + random_pl_2))
	print("random_bot = %d" % (random_bot_1 + random_bot_2))
	print("------------------------")

	animation_players.play("blue_brosok")
	await get_tree().create_timer(0.6).timeout
	cubes.visible = false
	await get_tree().create_timer(4.7).timeout
	
	random_num_cubes_pl()
	
	cubes.visible = true

	await get_tree().create_timer(0.5).timeout
	animation_scores.play("anim_number_pl")

	await get_tree().create_timer(2.2).timeout
	animation_players.play("red_brosok")
	animation_players.speed_scale += 0.5
	await get_tree().create_timer(0.7).timeout
	cubes.visible = false
	
	random_num_cubes_bot()
	
	await get_tree().create_timer(3.8).timeout
	cubes.visible = true
	
	await get_tree().create_timer(0.5).timeout
	animation_players.speed_scale -= 0.5
	animation_scores.play("anim_number_bot")
	await get_tree().create_timer(0.5).timeout

	#игрок +1 очко
	if (random_pl_1 + random_pl_2) > (random_bot_1 + random_bot_2):
		animation_scores.play("razdvig_nums_player>")
		await get_tree().create_timer(3.0).timeout
		vistrel_pl += 1
		print("vistrel_pl = %d" % vistrel_pl)
		print("------------------------")
		animation_player_bot.play("+1 player")
		player_score_global += 1
		player_score_label.text = str(player_score_global)
	#бот +1 очко
	elif (random_pl_1 + random_pl_2) < (random_bot_1 + random_bot_2):
		animation_scores.play("razdvig_nums_bot>")
		await get_tree().create_timer(3.0).timeout
		vistrel_bot += 1
		print("vistrel_bot = %d" % vistrel_bot)
		print("------------------------")
		animation_player_bot.play("+1 bot")
		bot_score_global += 1
		bot_score_label.text = str(bot_score_global)
	#ничья
	elif (random_pl_1 + random_pl_2) == (random_bot_1 + random_bot_2):
		animation_scores.play("razdvig_nums_back<")
		await get_tree().create_timer(3.0).timeout
		animation_player_bot.play("+0 all")

	await get_tree().create_timer(3.0).timeout
	animation_player_bot.play("anim_numbers_back")
	GameManager.pause_off = 0
	GameManager.pause_button_off = 0
	GameManager.start_game = 0
	GameManager.start_round = 1
	if vistrel_pl != 2:
		tap_button.disabled = false
	if vistrel_bot != 2:
		tap_button.disabled = false



	if vistrel_pl == 2:
		tap_button.disabled = true
		GameManager.pause = 0
		GameManager.pause_off = 0
		GameManager.pause_button_off = 1
		GameManager.start_round = 0
		all_vistrels_pl += 1
		print("all_vistrels_pl = %d" % all_vistrels_pl)
		print("------------------------")
		if all_vistrels_pl == random_live_bullets_pl:
			GameManager.pause = 1
			GameManager.pause_game = 1
			GameManager.pause_button_off = 1
			animation_scores.play("pl_vistrel_pistol")
			await get_tree().create_timer(2.5).timeout
			fire_pistol.play()
			await get_tree().create_timer(0.2).timeout
			gilza_pl.visible = true
			await get_tree().create_timer(0.6).timeout

			color_black.visible = true
			color_white.visible = true


			if GameManager.language == 1:
				$"CanvasLayer/who Win text end".text = "Player Win"
				$"CanvasLayer/who Win text end".pivot_offset.x = 641.5
			if GameManager.language == 2:
				$"CanvasLayer/who Win text end".text = "Игрок выигрывает"
				$"CanvasLayer/who Win text end".pivot_offset.x = 1206.5
			GameManager.pause = 0
			GameManager.pause_off = 0
			GameManager.pause_button_off = 0
			GameManager.start_round = 1
			
			GameManager.music_game = 2
			GameManager.stat_win += 1
			GameManager.all_games += 1
			SaveManager.save_game()
			await Leaderboards.post_guest_score(GameManager.lb_id, score, GameManager.player_name)#leaderboard-for-drop-v07-q6pP
			animation_player_bot.play("anim_win_end")
			await get_tree().create_timer(3.8).timeout
			get_tree().change_scene_to_file("res://scenes/menu.tscn")

		if all_vistrels_pl != random_live_bullets_pl:
			animation_players.play("pl_vistrel_pistol_blank")
			await get_tree().create_timer(2.5).timeout
			fire_pistol_blank.play()
			player_vistrels_score.text = str(all_vistrels_pl)
			await get_tree().create_timer(0.8).timeout
			pistol_reload.play()
			await get_tree().create_timer(0.6).timeout
			padenie_gilzy.play()
			await get_tree().create_timer(2.9).timeout
			vistrel_pl = 0
			GameManager.pause = 0
			GameManager.pause_off = 0
			GameManager.pause_button_off = 0
			GameManager.start_round = 1
			tap_button.disabled = false


	if vistrel_bot == 2:
		tap_button.disabled = true
		GameManager.pause = 0
		GameManager.pause_off = 1
		GameManager.pause_button_off = 1
		GameManager.start_round = 0
		all_vistrels_bot += 1
		print("all_vistrels_bot %d" % all_vistrels_bot)
		print("------------------------")
		if all_vistrels_bot == random_live_bullets_bot:
			animation_players.play("bot_vistrel_pistol")
			await get_tree().create_timer(2.5).timeout
			
			color_black.visible = true
			color_white.visible = true
			fire_pistol.play()
			
			await get_tree().create_timer(1.3).timeout
			if GameManager.language == 1:
				$"CanvasLayer/who Win text end".text = "Player Lose"
				$"CanvasLayer/who Win text end".pivot_offset.x = 715.5
			if GameManager.language == 2:
				$"CanvasLayer/who Win text end".text = "Игрок проигрывает"
				$"CanvasLayer/who Win text end".pivot_offset.x = 1206.5
			animation_player_bot.play("anim_win_end")
			await get_tree().create_timer(3.8).timeout
			GameManager.pause = 0
			GameManager.pause_off = 0
			GameManager.pause_button_off = 0
			GameManager.start_round = 1
			
			GameManager.music_game = 2
			GameManager.stat_lose += 1
			GameManager.all_games += 1
			SaveManager.save_game()
			get_tree().change_scene_to_file("res://scenes/menu.tscn")

		if all_vistrels_bot != random_live_bullets_bot:
			animation_players.play("bot_vistrel_pistol_blank")
			await get_tree().create_timer(2.5).timeout
			fire_pistol_blank.play()
			bot_vistrels_score.text = str(all_vistrels_bot)
			await get_tree().create_timer(0.8).timeout
			pistol_reload.play()
			await get_tree().create_timer(0.6).timeout
			padenie_gilzy.play()
			await get_tree().create_timer(2.9).timeout
			vistrel_bot = 0
			GameManager.pause = 0
			GameManager.pause_off = 0
			GameManager.pause_button_off = 0
			GameManager.start_round = 1
			tap_button.disabled = false



func random_num_cubes_pl():
	if random_pl_1 == 1:
		cube_1.texture = cube_num1
	elif random_pl_1 == 2:
		cube_1.texture = cube_num2
	elif random_pl_1 == 3:
		cube_1.texture = cube_num3
	elif random_pl_1 == 4:
		cube_1.texture = cube_num4
	elif random_pl_1 == 5:
		cube_1.texture = cube_num5
	elif random_pl_1 == 6:
		cube_1.texture = cube_num6

	if random_pl_2 == 1:
		cube_2.texture = cube_num1
	elif random_pl_2 == 2:
		cube_2.texture = cube_num2
	elif random_pl_2 == 3:
		cube_2.texture = cube_num3
	elif random_pl_2 == 4:
		cube_2.texture = cube_num4
	elif random_pl_2 == 5:
		cube_2.texture = cube_num5
	elif random_pl_2 == 6:
		cube_2.texture = cube_num6

func random_num_cubes_bot():
	if random_bot_1 == 1:
		cube_1.texture = cube_num1
	elif random_bot_1 == 2:
		cube_1.texture = cube_num2
	elif random_bot_1 == 3:
		cube_1.texture = cube_num3
	elif random_bot_1 == 4:
		cube_1.texture = cube_num4
	elif random_bot_1 == 5:
		cube_1.texture = cube_num5
	elif random_bot_1 == 6:
		cube_1.texture = cube_num6

	if random_bot_2 == 1:
		cube_2.texture = cube_num1
	elif random_bot_2 == 2:
		cube_2.texture = cube_num2
	elif random_bot_2 == 3:
		cube_2.texture = cube_num3
	elif random_bot_2 == 4:
		cube_2.texture = cube_num4
	elif random_bot_2 == 5:
		cube_2.texture = cube_num5
	elif random_bot_2 == 6:
		cube_2.texture = cube_num6
