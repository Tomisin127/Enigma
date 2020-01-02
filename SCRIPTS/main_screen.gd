extends Node

onready var box_anim_scene = preload("res://LETTERS/box_anim.tscn")

onready var background_anim_container= Node.new()


func _ready():
	
	save_game.load_high_score()
	
	randomize()
	get_tree().set_auto_accept_quit(false)
	$achievement_tween.interpolate_property($Control/achievement,"modulate",Color(rand_range(0,1),rand_range(0,1),rand_range(0,1)),Color(rand_range(0,1),rand_range(0,1),rand_range(0,1)),1,Tween.TRANS_SINE,Tween.EASE_OUT)
	$achievement_tween.start()
	
	$game_name_tween.interpolate_property($Control/game_name,"modulate",Color(rand_range(0,1),rand_range(0,1),rand_range(0,1)),Color(rand_range(0,1),rand_range(0,1),rand_range(0,1)),1,Tween.TRANS_SINE,Tween.EASE_OUT)
	$game_name_tween.start()
	
	$settings_tween.interpolate_property($Control/settings,"modulate",Color(rand_range(0,1),rand_range(0,1),rand_range(0,1)),Color(rand_range(0,1),rand_range(0,1),rand_range(0,1)),1,Tween.TRANS_SINE,Tween.EASE_OUT)
	$settings_tween.start()
	
	$play_tween.interpolate_property($Control/rand_play,"modulate",Color(rand_range(0,1),rand_range(0,1),rand_range(0,1)),Color(rand_range(0,1),rand_range(0,1),rand_range(0,1)),1,Tween.TRANS_SINE,Tween.EASE_OUT)
	$play_tween.start()
	

	
	

	$Control/best_score.text = "Your Best Score is " + str(save_game.hs['score'])  
	
	add_child(background_anim_container)
	
	if global.settings_is_loaded==true:
		save_game.load_settings()
		
	else:
		return
	
	
	
	
	
	pass
	
func _process(delta):
	
	if global.settings_is_loaded==true:
		if save_game.settings_data['/root/settings']['username'] != "":
			save_game.load_settings()
			$Control/best_score.get_font("font").size = 12
			$Control/best_score.text = "Dear " + save_game.settings_data['/root/settings']['username'] + "," +" Your Best Score is " +str(save_game.hs['score'])
			#save_game.save_settings()
	
	pass

func _on_rand_play_pressed():
	#interactive_loader.goto_scene("res://LETTERS/level1.tscn")
	get_tree().change_scene("res://LETTERS/stages.tscn")
	pass # Replace with function body.



func _on_achievement_pressed():
	get_tree().change_scene("res://LETTERS/achievement_page.tscn")
	pass # Replace with function body.


func _on_settings_pressed():
	get_tree().change_scene("res://LETTERS/settings.tscn")
	pass # Replace with function body.
	
func background_animation(amount):
	
	for i in range(amount):
		var t = box_anim_scene.instance()
		
		t.position.x =rand_range(0 ,get_viewport().get_visible_rect().size.x)
		t.position.y =rand_range(0 ,get_viewport().get_visible_rect().size.y)
		
		background_anim_container.add_child(t)
		
		t.modulate = Color(rand_range(0,1),rand_range(0,1),(rand_range(0,1)),0.5)

		
	pass

func _on_background_timer_timeout():
	background_animation(1)
	pass # Replace with function body.
	
	pass


func _on_game_name_tween_tween_completed(object, key):
	randomize()
	$game_name_tween.interpolate_property($Control/game_name,"modulate",Color(rand_range(0,1),rand_range(0,1),rand_range(0,1)),Color(rand_range(0,1),rand_range(0,1),rand_range(0,1)),1,Tween.TRANS_BOUNCE,Tween.EASE_OUT)
	pass # Replace with function body.


func _on_play_tween_tween_completed(object, key):
	$play_tween.interpolate_property($Control/rand_play,"modulate",Color(rand_range(0,1),rand_range(0,1),rand_range(0,1)),Color(rand_range(0,1),rand_range(0,1),rand_range(0,1)),1,Tween.TRANS_SINE,Tween.EASE_OUT)
	pass # Replace with function body.


func _on_settings_tween_tween_completed(object, key):
	$settings_tween.interpolate_property($Control/settings,"modulate",Color(rand_range(0,1),rand_range(0,1),rand_range(0,1)),Color(rand_range(0,1),rand_range(0,1),rand_range(0,1)),1,Tween.TRANS_SINE,Tween.EASE_OUT)
	pass # Replace with function body.


func _on_achievement_tween_tween_completed(object, key):
	$achievement_tween.interpolate_property($Control/achievement,"modulate",Color(rand_range(0,1),rand_range(0,1),rand_range(0,1)),Color(rand_range(0,1),rand_range(0,1),rand_range(0,1)),1,Tween.TRANS_SINE,Tween.EASE_OUT)
	pass # Replace with function body.
	
func _notification(what):
	
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		get_tree().set_auto_accept_quit(false)
		
		
