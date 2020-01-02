 extends Node

var currency = 0

var goal1_text = "reach 25 seconds"
var goal1_boolean = false
var is_goal1_achieved = false


var rewards = 10
onready var reward_multiplier:int


var timer =1 

signal music_start
signal music_stop

func _ready():
	#save_game.save_achievement()
	connect("music_start",self,"music_play")
	connect("music_stop",self,"music_end")
	
	
	#if global.settings_is_loaded==true:
		#save_game.load_settings()
		#get_node("/root/settings/Control/music_box").pressed = save_game.settings_data["/root/settings"]["music_autoplay"]
		#print( save_game.settings_data["/root/settings"]["music_autoplay"])
		
	pass


func _process(delta):

	
	#if global.settings_is_loaded==true:
		#get_node("/root/settings/Control/music_box").pressed = save_game.settings_data["/root/settings"]["music_start"]
		#print( save_game.settings_data["/root/settings"]["music_stop"])
		
	randomize()
	
	emit_signal("music_start",global.music_start) 
	emit_signal("music_stop",global.music_stop)
	
	goal1()
	
	pass
	
func goal1():
	
	if global.timer > 25.0 and is_goal1_achieved==false:
		reward_multiplier = round(rand_range(1,5))
		is_goal1_achieved = true
		print("ps timer greater than 5")
		goal1_boolean = true
		currency = rewards * int(reward_multiplier)
	pass
	
func save():
	
	var save_dict = {
		
		goal1_text = goal1_text,
		
		goal1_boolean = goal1_boolean,
		
		rewards = rewards,
		
		reward_multiplier = reward_multiplier,
		
		is_goal1_achieved = is_goal1_achieved,
		
		currency = currency
		
		}
		
	return save_dict
	
	pass
	
func get_latest_currency():
	return currency
	pass
	
func music_play(boolean):
	if boolean ==true:
		if achievement.get_node("main_music").volume_db <0:
			
			achievement.get_node("main_music").volume_db +=get_process_delta_time()*8
				
			print(achievement.get_node("main_music").volume_db)
					
			if achievement.get_node("main_music").volume_db > 0:
				return
					
func music_end(boolean):
	
	if boolean==true:
		if not achievement.get_node("main_music").volume_db < -80:
			
			achievement.get_node("main_music").volume_db -=get_process_delta_time()*8
			
			print(achievement.get_node("main_music").volume_db)