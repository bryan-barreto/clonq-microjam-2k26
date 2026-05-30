extends Node2D

@export
var timer = 5.0

func _ready():
	send_win_js()

func send_win_js() -> void:
	JavaScriptBridge.eval("window.parent.postMessage({op: \"done\", win: true});")

func _process(delta: float) -> void:
	timer -= delta
	if timer <= 0.0:
		get_tree().change_scene_to_file("res://scenes/sleep.tscn")
