extends Control

onready var watchout = get_parent().get_parent().get_parent()

func _ready():
	
	
	pass


func _on_pause_resume_pressed():
	print("play pressed")
	global.pause = false
	get_tree().paused = false
	$pause_anim.play_backwards("pause_anim")

	pass # Replace with function body.


func _on_pause_restart_pressed():
	
	#$pause_anim.play_backwards("pause_anim")
	watchout.get_node("player").reset_state()
	get_tree().change_scene("res://LETTERS/watch_out.tscn")
	
	save_game.load_watchout_game(false)
	global.pause = false
	get_tree().paused = false
	pass # Replace with function body.


func _on_save_game_pressed():
	
	watchout.change_in_left_slicer_state()
	watchout.change_in_right_slicer_state()
	save_game.save_watchout_game()
	
	save_game.save_high_score()
	
	save_game.save_achievement()
	
	
	
	#level1.reconstruct_rotor_state(true if level1.savedgame_data['/root/level1/player']['is_player_dead']==false else false)
	
	
	yield(get_tree().create_timer(0.1),"timeout")
	
	get_tree().change_scene("res://LETTERS/themain.tscn")
	global.pause = false
	get_tree().paused = false
	
	pass # Replace with function body.
