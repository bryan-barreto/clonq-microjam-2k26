extends Node2D

@export
var difficulty = 0

@export
var max_difficulty = 255

@export
var min_difficulty = 0

func _enter_tree():
	%Difficulty.text = "Difficulty: %d" % difficulty
	pass

func _on_win_pressed():
	get_tree().change_scene_to_file("res://scenes/win.tscn")

func _on_lose_pressed():
	get_tree().change_scene_to_file("res://scenes/lose.tscn")

func set_difficulty(request_diff: float):
	self.difficulty = clampf(request_diff, min_difficulty, max_difficulty)
