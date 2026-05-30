extends Node2D

@export
var timer = 5.0

func _ready():
	send_lose_js()

func send_lose_js() -> void:
	JavaScriptBridge.eval("window.parent.postMessage({op: \"done\", win: false});")

func _process(delta: float) -> void:
	timer -= delta
	if timer <= 0.0:
		get_tree().change_scene_to_file("res://scenes/sleep.tscn")
