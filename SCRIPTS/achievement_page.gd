extends Node

onready var achievement_data

func _ready():
	#save_game.save_achievement()
	save_game.load_achievement()
	get_achievement_info_from_file()
	
	print( achievement_data)
	
	goal1_info()
	
	set_currency()
	
	pass
	
func _process(delta):
	

	
	pass


func _on_main_screen_pressed():
	
	get_tree().change_scene("res://LETTERS/main_screen.tscn")
	
	pass # Replace with function body.


func set_currency():
	$star_point/amount.text = str(achievement.get_latest_currency())
	pass
	
func get_achievement_info_from_file():
	#try to load a saved file
	var save_file = File.new()
		
	#parse the file data if it exists
	save_file.open(save_game.ACHIEVEMENT_PATH,File.READ)
	achievement_data = parse_json(save_file.get_as_text())
	
	save_file.close()
	
	pass
	
func goal1_info():
	$scroll_h/achievement_box/first/goal_info/goal_text.text = achievement.goal1_text
	$scroll_h/achievement_box/first/is_goal_achieved/goal_achieved.text = str(achievement_data["/root/achievement"]['is_goal1_achieved'])
	$scroll_h/achievement_box/first/goal_reward/reward.text = str(achievement_data["/root/achievement"]['rewards'])
	$scroll_h/achievement_box/first/goal_mult/reward_mult.text = str(achievement_data["/root/achievement"]['reward_multiplier'])
	pass
	
func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		return
		
		