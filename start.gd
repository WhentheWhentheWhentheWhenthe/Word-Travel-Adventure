extends Node2D

func _ready():
	$StartGame.pressed.connect(_on_start_game_pressed)

func _on_start_game_pressed():
	get_tree().change_scene_to_file("res://forest.tscn")
