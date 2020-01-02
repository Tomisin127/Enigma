extends Node

onready var player  = get_parent().get_node("player")

var score = 0 setget set_score

signal pause_anim



func _ready():
	
	randomize()
	
	$hud/score_tween.interpolate_property($hud/score,"modulate",Color(rand_range(0,1),rand_range(0,1),rand_range(0,1)),Color(rand_range(0,1),rand_range(0,1),rand_range(0,1)),1,Tween.TRANS_SINE,Tween.EASE_OUT)
	$hud/score_tween.start()
	
	$hud/timer_tween.interpolate_property($hud/timer,"modulate",Color(rand_range(0,1),rand_range(0,1),rand_range(0,1)),Color(rand_range(0,1),rand_range(0,1),rand_range(0,1)),1,Tween.TRANS_SINE,Tween.EASE_OUT)
	$hud/timer_tween.start()
	
	connect("pause_anim",self,"pause",[],CONNECT_PERSIST)
	
	pass

func _process(delta):
	
	#set time left
	$hud/time_label.text = str(int(player.timer))
	
	#set player score on screen
	$hud/player_score.text =  str(player.normal_player_score)
	
	set_score(player.normal_player_score)
	
	#print(player.normal_player_score)
	
	
	pass


func set_score(new_value):
	score = new_value
	$hud/player_score.text = str(score)
		
	if score > save_game.highscore:
		save_game.highscore = score




func _on_pause_btn_pressed():
	
	emit_signal("pause_anim")
	global.pause = false
		#$pause_anim.play("pause_anim")
	pass # Replace with function body.


func _on_pause_anim_animation_finished(anim_name):
	#if anim_name=="pause_anim":
		#$pause_control/pause_resume.disabled =false
		#$pause_control/pause_restart.disabled = false
		#$pause_control/pause_menu.disabled = false
	pass # Replace with function body.

func pause():
	global.pause = not global.pause
	
	get_tree().paused = global.pause
	#show panel and its buttons
	if global.pause == true:
		print("paused pressed")
		if not $hud/pause_control/pause_anim.is_playing():
			$hud/pause_control/pause_anim.play("pause_anim")
			print("isPLaying?")
			$hud/pause_btn.pause_mode = PAUSE_MODE_STOP
			
			
	if global.pause == false:
		$hud/pause_btn.pause_mode =Node.PAUSE_MODE_PROCESS
			
			
	

	pass




func _on_score_tween_tween_completed(object, key):
	randomize()
	$hud/score_tween.interpolate_property($hud/score,"modulate",Color(rand_range(0,1),rand_range(0,1),rand_range(0,1)),Color(rand_range(0,1),rand_range(0,1),rand_range(0,1)),1,Tween.TRANS_SINE,Tween.EASE_OUT)
	pass # Replace with function body.


func _on_timer_tween_tween_completed(object, key):
	$hud/timer_tween.interpolate_property($hud/timer,"modulate",Color(rand_range(0,1),rand_range(0,1),rand_range(0,1)),Color(rand_range(0,1),rand_range(0,1),rand_range(0,1)),1,Tween.TRANS_SINE,Tween.EASE_OUT)
	pass # Replace with function body.


