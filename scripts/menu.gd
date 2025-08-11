extends Node2D

@onready var matches_played = $CanvasLayer/CenterContainer/PanelContainer/MarginContainer/VBoxContainer/matches_played
@onready var matches_wins = $CanvasLayer/CenterContainer/PanelContainer/MarginContainer/VBoxContainer/matches_wins
@onready var matches_loses = $CanvasLayer/CenterContainer/PanelContainer/MarginContainer/VBoxContainer/matches_loses

@onready var LineEdit_name = $CanvasLayer/Start_settings/PanelContainer/MarginContainer/VBoxContainer/LineEdit
@onready var save_btn = $CanvasLayer/Start_settings/PanelContainer/MarginContainer/VBoxContainer/SaveName
@onready var next_btn = $CanvasLayer/Start_settings/PanelContainer/MarginContainer/VBoxContainer2/next

@onready var LineEdit_lb_name = $CanvasLayer/LeaderboardUI/HBoxContainer/LineEdit
@onready var save_lb_btn = $CanvasLayer/LeaderboardUI/HBoxContainer/SaveName

@onready var u_name = $CanvasLayer/LeaderboardUI/HBoxContainer/name

func _ready():
	SaveManager.load_game()
	SaveManager.load_name()
	LineEdit_lb_name.text = GameManager.player_name
	#u_name.text = GameManager.player_name
	GameManager.start_game = 0

func _process(_delta: float) -> void:
	if LineEdit_name.text == "":
		GameManager.save_name = 0
	else:
		GameManager.save_name = 1
	
	if GameManager.save_name == 0:
		save_btn.disabled = true
	if GameManager.save_name == 1:
		save_btn.disabled = false

	if GameManager.save_name_btn == 0:
		next_btn.disabled = true
	elif GameManager.save_name_btn == 1:
		next_btn.disabled = false


	if LineEdit_lb_name.text == "":
		GameManager.save_name = 0
	else:
		GameManager.save_name = 1
	
	if GameManager.save_name == 0:
		save_lb_btn.disabled = true
	if GameManager.save_name == 1:
		save_lb_btn.disabled = false


	if GameManager.language == 1:
		matches_played.text = "Games played: %d" % GameManager.all_games
		matches_wins.text = "Games wins: %d" % GameManager.stat_win
		matches_loses.text = "Games loses: %d" % GameManager.stat_lose
	if GameManager.language == 2:
		matches_played.text = "Игр сыграно: %d" % GameManager.all_games
		matches_wins.text = "Игр выиграно: %d" % GameManager.stat_win
		matches_loses.text = "Игр проиграно: %d" % GameManager.stat_lose


func _on_save_name_pressed() -> void:
	if LineEdit_name.text == "":
		GameManager.save_name_btn = 0

	if !LineEdit_name.text == "":
		GameManager.save_name_btn = 1
		GameManager.player_name = LineEdit_name.text
		u_name.text = GameManager.player_name
		SaveManager.save_name()
		await Leaderboards.post_guest_score(GameManager.lb_id, -1, GameManager.player_name)
		await Leaderboards.post_guest_score(GameManager.lb_id, 1, GameManager.player_name)
		print(GameManager.player_name)


func _on_save_name_lb_pressed() -> void:
	if LineEdit_lb_name.text == "":
		GameManager.save_name_lb_btn = 0

	if !LineEdit_lb_name.text == "":
		GameManager.save_name_lb_btn = 1
		GameManager.player_name = LineEdit_lb_name.text
		SaveManager.save_name()
		await Leaderboards.post_guest_score(GameManager.lb_id, -1, GameManager.player_name)
		await Leaderboards.post_guest_score(GameManager.lb_id, 1, GameManager.player_name)
		get_tree().reload_current_scene()
		print(GameManager.player_name)


#func _on_LineEdit_lb_text_changed(_new_text: String) -> void:
