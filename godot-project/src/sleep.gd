extends Node2D

var main = preload("res://scenes/main.tscn")

func _ready() -> void:
	JavaScriptBridge.eval("window.parent.postMessage({op: \"ready\"});")

func _process(_delta: float) -> void:
	var diff = JavaScriptBridge.eval("window.lcolonqJamStart || -1.0")
	diff = diff as int if diff else -1
	if diff > -0.5:
		JavaScriptBridge.eval("window.lcolonqJamStart = -1.0")
		JavaScriptBridge.eval("window.parent.postMessage({op: \"started\"});")
		var scn = main.instantiate()
		scn.set_difficulty(diff)
		get_tree().change_scene_to_node(scn)
