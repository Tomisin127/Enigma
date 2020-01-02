extends Control

onready var level1 = get_parent().get_parent().get_parent()

signal change_in_action_rotor_state

onready var f

func _ready():
	f = funcref(level1,"change_in_action_rotor_state")
	
	pass
	
func _process(delta):

	pass


func _on_pause_resume_pressed():
	print("play pressed")
	global.pause = false
	get_tree().paused = false
	$pause_anim.play_backwards("pause_anim")

	pass # Replace with function body.


func _on_pause_restart_pressed():
	
	#$pause_anim.play_backwards("pause_anim")
	
	level1.get_node("player").is_player_dead = true
	save_game.save_game()
	get_tree().change_scene("res://LETTERS/level1.tscn")
	#level1.get_node("player").reset_state()
	
	global.pause = false
	get_tree().paused = false
	pass # Replace with function body.


func _on_save_game_pressed():
	
	f.call_func()
	print("at this point: ",f.call_func())

	#emit_signal("change_in_action_rotor_state")

	level1.get_node("player").is_player_dead = false

	save_game.save_game()

	save_game.save_high_score()

	save_game.save_achievement()


	yield(get_tree().create_timer(1),"timeout")

	get_tree().change_scene("res://LETTERS/themain.tscn")
	global.pause = false
	get_tree().paused = false

	pass # Replace with function body.
