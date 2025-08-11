extends Node

var save_path = "user://dev0.7b-280525-game.dat"
var savename_path = "user://dev0.7b-280525-name.dat"

#"user://dev0.7b-1217-stats.dat"

func save_name():
	var file = FileAccess.open(savename_path, FileAccess.WRITE)
	file.store_line(GameManager.player_name)

func load_name():
	if FileAccess.file_exists(savename_path):
		var file = FileAccess.open(savename_path, FileAccess.READ)
		GameManager.player_name = file.get_line()
		print(GameManager.player_name)
	else:
		print("name not found")
		GameManager.player_name = ""


func save_game():
	print("save main_file")
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(GameManager.all_games)
	file.store_var(GameManager.stat_win)
	file.store_var(GameManager.stat_lose)
	
	file.store_var(GameManager.language)
	file.store_var(GameManager.option_language)
	file.store_var(GameManager.fullscreen)
	file.store_var(GameManager.screenshot_btn)
	file.store_var(GameManager.start_settings)


func load_game():
	if FileAccess.file_exists(save_path):
		print("save found")
		var file = FileAccess.open(save_path, FileAccess.READ)
		GameManager.all_games = file.get_var()
		GameManager.stat_win = file.get_var()
		GameManager.stat_lose = file.get_var()
		
		GameManager.language = file.get_var()
		GameManager.option_language = file.get_var()
		GameManager.fullscreen = file.get_var()
		GameManager.screenshot_btn = file.get_var()
		GameManager.start_settings = file.get_var()

	else:
		print("save not found")
		GameManager.all_games = 0
		GameManager.stat_win = 0
		GameManager.stat_lose = 0
		
		GameManager.language = 1
		GameManager.option_language = 1
		GameManager.fullscreen = 0
		GameManager.screenshot_btn = 0
		GameManager.start_settings = 0
