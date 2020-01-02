extends Control

onready var level1 = get_parent().get_parent()

func _ready():
	
	pass

func _on_restart_pressed():
	
	print("restart pressed")
	
	
	#player.reset_state()
	#get_tree().change_scene("res://LETTERS/level1.tscn")
	get_tree().change_scene("res://LETTERS/level1.tscn")
	save_game.load_game(false)
	global.pause = false
	get_tree().paused = false
	pass # Replace with function body.


func _on_exit_pressed():

	get_tree().change_scene("res://LETTERS/themain.tscn")
	
	global.pause = false
	get_tree().paused = false
	pass # Replace with function body.
	

func _on_anim_animation_finished(anim_name):
	
	if anim_name == "show_gameover":
		#$gameover/anim
		print("animation finished")
		#$restart.disabled = false
		#$exit.disabled = false
	pass # Replace with function body.
	
	
	
	