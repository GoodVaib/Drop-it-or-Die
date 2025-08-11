extends CanvasLayer

#main menu
@onready var start_settings = $Start_settings
@onready var VBox = $VBoxContainer
@onready var menu_panel = $CenterContainer
@onready var leaderboard = $LeaderboardUI

@onready var choose_game_mode = $Choose_game_mode
@onready var choose_game_mode_container = $Choose_game_mode/PanelContainer/MarginContainer/VBoxContainer
@onready var multiplayer_node = $Choose_game_mode/PanelContainer/MarginContainer/multiplayer_node

#stats
@onready var matches_played = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/matches_played
@onready var matches_wins = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/matches_wins
@onready var matches_loses = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/matches_loses

#menu
	#buttons
@onready var menu_button = $VBoxContainer/menu
@onready var quit_button = $VBoxContainer/quit

@onready var screenshot_btn = $screenshot_btn

@onready var start_game = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/start_game
@onready var single = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/single
#@onready var single = $Choose_game_mode/PanelContainer/MarginContainer/VBoxContainer/single
@onready var multi = $Choose_game_mode/PanelContainer/MarginContainer/VBoxContainer/multi

@onready var leaderboard_b = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/Leaderboard
@onready var statistics = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/statistics
@onready var setting = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/Settings

	#label
@onready var drop_it_or_die_label =  $"VBoxContainer/Drop it or die"
@onready var menu_label =  $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/menu
@onready var settings_text = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/settings_text
@onready var warn_name = $Start_settings/PanelContainer/MarginContainer/VBoxContainer/settings_warn_HBoxCont/warn

	#start settings
@onready var save_name = $Start_settings/PanelContainer/MarginContainer/VBoxContainer/SaveName
@onready var next_btn = $Start_settings/PanelContainer/MarginContainer/VBoxContainer2/next

	#settings
@onready var language_HBox = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/settings_lang_HBoxCont
@onready var language_text = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/settings_lang_HBoxCont/Language
@onready var OptionLanguage = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/settings_lang_HBoxCont/OptionLanguage

@onready var fullscreen_HBox = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/settings_fullscreen_HBoxCont
@onready var FullScreen_CheckButton = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/settings_fullscreen_HBoxCont/FullScreen_CheckButton

@onready var screenshots_HBox = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/settings_screenshots_HBoxCont2
@onready var screenshots_CheckButton = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/settings_screenshots_HBoxCont2/Screenshots_CheckButton

@onready var language_text_start = $Start_settings/PanelContainer/MarginContainer/VBoxContainer/settings_lang_HBoxCont/Language

	#leaderboard
@onready var leaderboard_text = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/Leaderboard
@onready var lb_close = $LeaderboardUI/Close
@onready var lb_save_name = $LeaderboardUI/HBoxContainer/SaveName
@onready var ur_nickname = $LeaderboardUI/HBoxContainer/ur_nickname

	#lineEdit
@onready var name_edit_score = $LeaderboardUI/HBoxContainer/LineEdit

	#Panel
@onready var PanelCont_menu = $CenterContainer/PanelContainer

	#lines
@onready var line2 = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/HSeparator2
@onready var line3 = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/HSeparator3
@onready var line4 = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/HSeparator4

	#more
@onready var back = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer2/back
@onready var back_menu = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer2/back_menu

@onready var back_choose_mode = $Choose_game_mode/PanelContainer/MarginContainer/VBox_back/back
@onready var back_multiplayer = $Choose_game_mode/PanelContainer/MarginContainer/VBox_back/back_multiplayer

@onready var white = $White

	#animation
@onready var ani_player = $AnimationPlayer



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
	
	if GameManager.option_language == 1:
		OptionLanguage.selected = 0
	if GameManager.option_language == 2:
		OptionLanguage.selected = 1
	
	
	if GameManager.screenshot_btn == 1:
		screenshots_CheckButton.button_pressed = true
		screenshot_btn.visible = true
	if GameManager.screenshot_btn == 0:
		screenshots_CheckButton.button_pressed = false
		screenshot_btn.visible = false
	
	if GameManager.android_pc == 0:
		VBox.size.x = 185.755
		VBox.position.x = 419.122
		PanelCont_menu.custom_minimum_size.x = 325.535
		drop_it_or_die_label.add_theme_font_size_override("font_size", 30)
		menu_button.add_theme_font_size_override("font_size", 27)
		quit_button.add_theme_font_size_override("font_size", 27)
	if GameManager.android_pc == 1:
		VBox.size.x = 131
		VBox.position.x = 446.5
		PanelCont_menu.custom_minimum_size.x = 268.725
		drop_it_or_die_label.add_theme_font_size_override("font_size", 22)
		menu_button.add_theme_font_size_override("font_size", 22)
		quit_button.add_theme_font_size_override("font_size", 22)
	
	
	if GameManager.on_lb == 1:
		leaderboard.show()
		
		if GameManager.android_pc == 0:
			screenshots_HBox.visible = false
			fullscreen_HBox.visible = false
		VBox.visible = false
		start_settings.visible = false
		settings_text.visible = false
		menu_panel.visible = false
		start_game.visible = false
		choose_game_mode.visible = false
		choose_game_mode_container.visible = true
		multiplayer_node.visible = false
		back_multiplayer.visible = false
	else:
		if GameManager.android_pc == 0:
			screenshots_HBox.visible = false
			fullscreen_HBox.visible = false
		VBox.visible = true
		start_settings.visible = false
		settings_text.visible = false
		menu_panel.visible = false
		start_game.visible = false
		choose_game_mode.visible = false
		choose_game_mode_container.visible = true
		multiplayer_node.visible = false
		back_multiplayer.visible = false
		leaderboard.hide()
		white.visible = true
		await get_tree().create_timer(0.3).timeout
		white.visible = false


func _process(_delta: float) -> void:

	if GameManager.language == 1:
		menu_button.text = "Menu"
		quit_button.text = "Quit"
		single.text = "Singleplayer"
		line2.custom_minimum_size.x = 225.97
		statistics.text = "Statistics"
		setting.text = "Settings"
		language_text.text = "Language:"
		FullScreen_CheckButton.text = "FullScreen:"
		screenshots_CheckButton.text = "Screenshots:"
		settings_text.text = "Settings"
		back_menu.text = "Back"
		back.text = "Back"
		
		save_name.text = "Save name"
		next_btn.text = "Next"
		
		leaderboard_text.text = "Leaderboard"
		lb_close.text = "Close"
		lb_save_name.text = "Save name"
		ur_nickname.text = "You're nickname: "
		
		warn_name.text = "Attention: limit is 15 characters"
		language_text_start.text = "Language:"
	
	if GameManager.language == 2:
		menu_button.text = "Меню"
		quit_button.text = "Выход"
		single.text = "Одиночная игра"
		line2.custom_minimum_size.x = 247.355
		statistics.text = "Статистика"
		setting.text = "Настройки"
		language_text.text = "Язык:"
		FullScreen_CheckButton.text = "Полный экран:"
		screenshots_CheckButton.text = "Скриншоты:"
		settings_text.text = "Настройки"
		back_menu.text = "Назад"
		back.text = "Назад"
		
		save_name.text = "Сохранить имя"
		next_btn.text = "Далее"
		
		leaderboard_text.text = "Таблица лидеров"
		lb_close.text = "Закрыть"
		lb_save_name.text = "Сохранить имя"
		ur_nickname.text = "Ваш ник: "
		
		warn_name.text = "Внимание: лимит 15 символов"
		language_text_start.text = "Язык:"


func _on_next_pressed() -> void:
	if GameManager.option_language == 1:
		OptionLanguage.selected = 0
	if GameManager.option_language == 2:
		OptionLanguage.selected = 1
	GameManager.start_settings = 1
	SaveManager.save_game()
	name_edit_score.text = GameManager.player_name
	start_settings.visible = false
	menu_panel.visible = true


func _on_start_game_pressed() -> void:
	if GameManager.start_settings == 0:
		start_settings.visible = true
		VBox.visible = false

	if GameManager.start_settings == 1:
		if GameManager.language == 1:
			menu_label.text = "Menu"
		if GameManager.language == 2:
			menu_label.text = "Меню"
		
		name_edit_score.text = GameManager.player_name
		setting.visible = true
		single.visible = true
		leaderboard_b.visible = true
		line2.visible = true
		line3.visible = true
		back.visible = true
		
		language_HBox.visible = false
		back_menu.visible = false
		
		VBox.visible = false
		menu_panel.visible = true
		
		GameManager.on_start_settings = 1





func _on_choose_game_mode_pressed() -> void:
	choose_game_mode.visible = true
	menu_panel.visible = false

func _on_single_pressed() -> void:
	white.visible = true
	ani_player.play("White 2")
	await get_tree().create_timer(0.3).timeout
	white.visible = false
	get_tree().change_scene_to_file("res://scenes/game_new.tscn")

func _on_multi_pressed() -> void:
	multiplayer_node.visible = true
	choose_game_mode_container.visible = false
	
	back_choose_mode.visible = false
	back_multiplayer.visible = true


func _on_backmulti_pressed() -> void:
	multiplayer_node.visible = false
	choose_game_mode_container.visible = true
	
	back_choose_mode.visible = true
	back_multiplayer.visible = false

func _on_backmenu_pressed() -> void:
	choose_game_mode.visible = false
	menu_panel.visible = true






func _on_leaderboard_pressed() -> void:
	leaderboard.show()
	menu_panel.visible = false
	GameManager.on_lb = 1

func _on_refresh_pressed() -> void:
	get_tree().reload_current_scene()

func _on_close_pressed() -> void:
	leaderboard.hide()
	menu_panel.visible = true
	GameManager.on_lb = 0


func _on_statistics_pressed():
	statistics.visible = false
	setting.visible = false
	single.visible = false
	leaderboard_b.visible = false
	line2.visible = false
	line3.visible = false
	line4.visible = false
	back.visible = false
	
	matches_played.visible = true
	matches_wins.visible = true
	matches_loses.visible = true
	back_menu.visible = true

	if GameManager.language == 1:
		menu_label.text = "Stats"
	if GameManager.language == 2:
		menu_label.text = "Статистика"


func _on_settings_pressed() -> void:
	setting.visible = false
	statistics.visible = false
	single.visible = false
	leaderboard_b.visible = false
	line2.visible = false
	line3.visible = false
	line4.visible = false
	back.visible = false
	
	language_HBox.visible = true
	
	screenshots_HBox.visible = true
	
	if GameManager.android_pc == 1:
		fullscreen_HBox.visible = true
		screenshots_CheckButton.visible = true
	else:
		fullscreen_HBox.visible = false
		screenshots_CheckButton.visible = false
	back_menu.visible = true
	
	menu_label.visible = false
	settings_text.visible = true


func _on_option_language_item_selected(_index) -> void:
	if _index == 0:
		GameManager.language = 1
		GameManager.option_language = 1
	if _index == 1:
		GameManager.language = 2
		GameManager.option_language = 2

func _on_check_button_toggled(_toggled_on: bool) -> void:
	if GameManager.android_pc == 1:
		if _toggled_on == true:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			GameManager.fullscreen = 1
		if _toggled_on == false:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			GameManager.fullscreen = 0

func _on_screenshots_check_button_toggled(_toggled_on: bool) -> void:
	if _toggled_on == true:
		GameManager.screenshot_btn = 1
		screenshot_btn.visible = true
	if _toggled_on == false:
		GameManager.screenshot_btn = 0
		screenshot_btn.visible = false



func _on_back_menu_pressed() -> void:
	setting.visible = true
	statistics.visible = true
	single.visible = true
	leaderboard_b.visible = true
	line2.visible = true
	line3.visible = true
	line4.visible = true
	back.visible = true

	matches_played.visible = false
	matches_wins.visible = false
	matches_loses.visible = false
	language_HBox.visible = false
	screenshots_HBox.visible = false
	if GameManager.android_pc == 1:
		fullscreen_HBox.visible = false
		screenshots_CheckButton.visible = false
	back_menu.visible = false
	
	menu_label.visible = true
	settings_text.visible = false
	SaveManager.save_game()


	if GameManager.language == 1:
		menu_label.text = "Menu"
	if GameManager.language == 2:
		menu_label.text = "Меню"


func _on_back_pressed() -> void:
	back.visible = false
	VBox.visible = true
	menu_panel.visible = false


func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_telegram_pressed() -> void:
	OS.shell_open("https://t.me/crufix_x")
