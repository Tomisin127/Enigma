extends Node

func _ready():
	get_tree().set_auto_accept_quit(false)
	randomize()
	$rantor_tween.interpolate_property($rantor_pos/rantor,"modulate",Color(rand_range(0,1),rand_range(0,1),rand_range(0,1)),Color(rand_range(0,1),rand_range(0,1),rand_range(0,1)),1,Tween.TRANS_SINE,Tween.EASE_OUT)
	$rantor_tween.start()
	
	$watchout_tween.interpolate_property($watch_pos/watch_out,"modulate",Color(rand_range(0,1),rand_range(0,1),rand_range(0,1)),Color(rand_range(0,1),rand_range(0,1),rand_range(0,1)),1,Tween.TRANS_SINE,Tween.EASE_OUT)
	$watchout_tween.start()
	
	pass


func _on_rantor_anim_animation_finished(anim_name):
	$rantor_pos/rantor/rantor_anim.stop()
	pass # Replace with function body.



func _on_easy_pressed():
	get_tree().change_scene("res://LETTERS/level1.tscn")
	pass # Replace with function body.


func _on_exit_pressed():
	get_tree().change_scene("res://LETTERS/themain.tscn")
	pass # Replace with function body.


func _on_watch_out_toggled(button_pressed):
	
	if button_pressed ==true:
		$watch_pos/watch_out/watchout_anim.play("watchout_anim")
		
	else:
		$watch_pos/watch_out/watchout_anim.play_backwards("watchout_anim")
	pass # Replace with function body.


func _on_rantor_toggled(button_pressed):
	if button_pressed==true:
		$rantor_pos/rantor/rantor_anim.play("rantor_anim")
		
	else:
		$rantor_pos/rantor/rantor_anim.play_backwards("rantor_anim")
	pass # Replace with function body.
	


func _on_rantor_tween_tween_completed(object, key):
	randomize()
	$rantor_tween.interpolate_property($rantor_pos/rantor,"modulate",Color(rand_range(0,1),rand_range(0,1),rand_range(0,1)),Color(rand_range(0,1),rand_range(0,1),rand_range(0,1)),1,Tween.TRANS_SINE,Tween.EASE_OUT)
	pass # Replace with function body.
	
func _on_watchout_tween_tween_completed(object, key):
	randomize()
	$watchout_tween.interpolate_property($watch_pos/watch_out,"modulate",Color(rand_range(0,1),rand_range(0,1),rand_range(0,1)),Color(rand_range(0,1),rand_range(0,1),rand_range(0,1)),1,Tween.TRANS_SINE,Tween.EASE_OUT)
	pass # Replace with function body.


func _on_w_easy_pressed():
	get_tree().change_scene("res://LETTERS/watch_out.tscn")
	pass # Replace with function body
	
func _notification(what):
	
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		get_tree().set_auto_accept_quit(false)
		
		


func _on_w_hard_pressed():
	$notyet.show()
	yield(get_tree().create_timer(2.0),"timeout")
	$notyet.hide()
	pass # Replace with function body.


func _on_hard_pressed():
	$notyet.show()
	yield(get_tree().create_timer(2.0),"timeout")
	$notyet.hide()
	pass # Replace with function body.


func _on_w_info_pressed():
	$no_info.show()
	yield(get_tree().create_timer(2.0),"timeout")
	$no_info.hide()
	pass # Replace with function body.


func _on_info_pressed():
	$no_info.show()
	yield(get_tree().create_timer(2.0),"timeout")
	$no_info.hide()
	pass # Replace with function body.
