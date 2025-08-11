extends Node2D

@onready var ani_pl = $AnimationPlayer

func _ready():
	ani_pl.play("crufix")
	await get_tree().create_timer(3.0).timeout
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
