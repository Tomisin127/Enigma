extends Node


onready var exited
func _ready():
	#save_game.save_settings()
	get_tree().set_auto_accept_quit(false)
	global.settings_is_loaded = true
	
	
	
	
	save_game.load_settings()
	self.get_node("Control/username/name").text = save_game.settings_data["/root/settings"]["username"]

	

	#if save_game.settings_data["/root/settings"]["music_autoplay"] ==true:
		#$Control/music_box.pressed = true
		#return

	#if save_game.settings_data["/root/settings"]["music_autoplay"] == false:
		#$Control/music_box.pressed = false
		#return
	pass
	
func _process(delta):
	
	

	global.settings_is_loaded = true
	
	if $Control/music_box.pressed == true:
		global.music_start = true
		global.music_stop=false
		achievement.get_node("main_music").autoplay = true
		
		
					
#		if achievement.get_node("main_music").playing == true:
#			return
#		else:
			
		
		
	if $Control/music_box.pressed == false:
		achievement.get_node("main_music").autoplay = false
		global.music_stop = true
		global.music_start = false
		
		#achievement.get_node("main_music").autoplay = false
		#achievement.get_node("main_music").playing = false
	
	if exited==true:
		save_game.load_settings()
		self.get_node("Control/username/name").text = save_game.settings_data["/root/settings"]["username"]
		
	
	pass


func _on_back_pressed():
	get_tree().change_scene("res://LETTERS/main_screen.tscn")
	if $Control/username/field.text == "":
		
		save_game.load_settings()
		$Control/username/field.text =save_game.settings_data["/root/settings"]["username"]
		
	save_game.save_settings()
	
	exited=true
	pass # Replace with function body.

func save():
	var dict = {
		
		#music_autoplay = achievement.get_node("main_music").autoplay,
		#music_playing = achievement.get_node("main_music").playing,
		username = get_node("Control/username/field").text
		
	}
	
	return dict
	
	pass
	
func _notification(what):
	
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		get_tree().set_auto_accept_quit(false)
		
		