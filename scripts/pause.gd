extends Control

	#scenes
@onready var menu_buttons = $background_pause/Menu
@onready var settings_buttons = $background_pause/Settings

	#buttons
@onready var resume = $background_pause/Menu/Resume
@onready var settings = $background_pause/Menu/Settings
@onready var exit = $background_pause/Menu/Exit
@onready var back = $background_pause/Settings/Back
@onready var OptionLanguage = $background_pause/Settings/HBoxContainer/OptionButton

	#main scenes
@onready var pause_menu = $background_pause
@onready var pause_button = $pause_button/Button

	#ani players
@onready var animation_player = $AnimationPlayer
@onready var animation_player_2 = $"AnimationPlayer 2"

	#labels
@onready var pause_text = $pause_button/pause_text
@onready var language_text = $background_pause/Settings/HBoxContainer/Language

	#lines
@onready var panel = $pause_button/Panel
@onready var panel1 = $pause_button/Panel1
@onready var panel2 = $pause_button/Panel2

	#more
@onready var white = $white


func _ready():
	SaveManager.load_game()
	if GameManager.option_language == 1:
		OptionLanguage.selected = 0
	if GameManager.option_language == 2:
		OptionLanguage.selected = 1


func _process(_delta):
	if GameManager.language == 1:
		pause_text.text = "Menu"
		panel.size.x = 117
		resume.text = "Resume"
		settings.text = "Settings"
		exit.text = "Exit"
		back.text = "Back"
		language_text.text = "Language:"
	if GameManager.language == 2:
		pause_text.text = "Меню"
		panel.size.x = 121
		resume.text = "Продолжить"
		settings.text = "Настройки"
		exit.text = "Выход"
		back.text = "Назад"
		language_text.text = "Язык: "

	if GameManager.pause_button_off == 1:
		panel.modulate.a = 0.5
		pause_button.disabled = true
	elif GameManager.pause_button_off == 0:
		panel.modulate.a = 1.0
		pause_button.disabled = false
	if GameManager.pause == 1:
		if GameManager.pause_off == 1:
			animation_player.play("pause_out")
			await get_tree().create_timer(0.5).timeout
			pause_menu.visible = false
	

func _on_resume_pressed():
	GameManager.pause = 0
	GameManager.pause_game = 0
	if GameManager.start_game == 0:
		GameManager.start_round = 1
	else: 
		GameManager.start_round = 0
	
	animation_player.play("pause_out")
	await get_tree().create_timer(0.5).timeout
	GameManager.pause_button_off = 0
	pause_menu.visible = false


func _on_settings_pressed() -> void:
	menu_buttons.visible = false
	settings_buttons.visible = true


func _on_option_button_item_selected(_index: int) -> void:
	if _index == 0:
		GameManager.language = 1
		GameManager.option_language = 1
	if _index == 1:
		GameManager.language = 2
		GameManager.option_language = 2


func _on_back_pressed() -> void:
	menu_buttons.visible = true
	settings_buttons.visible = false

	SaveManager.save_game()


func _on_exit_pressed():
	white.visible = true
	animation_player_2.play("white_in")
	await get_tree().create_timer(1.0).timeout
	GameManager.music_game = 2
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _on_button_pressed():
	GameManager.pause = 1
	GameManager.pause_game = 1
	#GameManager.start_round = 0
	#GameManager.music_game = 2
	GameManager.pause_button_off = 1
	pause_menu.visible = true
	animation_player.play("pause_in")
	await get_tree().create_timer(0.4).timeout
