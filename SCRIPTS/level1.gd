

extends Node

onready var action_rotor_scene = preload("res://LETTERS/action_rotor.tscn")

signal pause_slider

signal show_gameover

signal achievement_notification

var action_rotor_position = {}

onready var savedgame_data = {}

onready var actionrotor_data = {}

onready var goal1_played =false

signal play_motivation

onready var list_of_motivation = [$motivation/ramdas_audio]

signal load_life

func _ready():
	

	
	global.f=funcref(self,"change_in_action_rotor_state")
	
	
	get_tree().paused = true
	get_viewport().gui_disable_input=true
	yield(get_tree().create_timer(1),"timeout")
	get_tree().paused = false
	get_viewport().gui_disable_input=false
	
	get_tree().set_auto_accept_quit(false)
	
	connect("load_life",self,"load_life",[],CONNECT_ONESHOT)
	
	connect("play_motivation",self,"motivation",[],CONNECT_ONESHOT)
	

	global.level1_clicked =true
	
	get_savedgame_info_from_file()
	
	
	if not savedgame_data.empty():
		save_game.load_game(true if savedgame_data["/root/level1/player"]["is_player_dead"]==false else false)
		
	if global.is_game_loaded==true:
		$player.get_node("escape_timer").start()
		print("is game loaded")
		
		if not $player.get_node("anim").is_playing():
			$player.get_node("anim").play("life")
			
	
	self.connect("show_gameover",self,"gameover",[],CONNECT_ONESHOT)
	
	self.connect("pause_slider",self, "play_pause_slider",[],CONNECT_ONESHOT)
	
	self.connect("achievement_notification",self,"achievement_notification",[],CONNECT_ONESHOT)
	

	
	reconstruct_rotor_state(true if savedgame_data['/root/level1/player']['is_player_dead']==false else false)
	
	
	pass
	
	
func _process(delta):
	
	var random_number1 = randi()%10000
	var random_number2 = randi()%10
	#print(random_number)
	
	if random_number1 == random_number2 and $player.is_player_dead==false:
		emit_signal("play_motivation")
		
		
	emit_signal("load_life")
	
	global.level1_clicked = true
	
	if achievement.is_goal1_achieved==false:
		save_game.save_achievement()
	
	save_game.save_high_score()
	
	save_game.save_game()
	
	emit_signal("achievement_notification",false)
	
	
	#change_in_action_rotor_state()
	
	#if achievement.is_goal1_achieved==true:
	
	
	if $player.is_player_dead==true:
		emit_signal("pause_slider")
		emit_signal("show_gameover")
		

func action_rotor_spawn(amount):
	
	for i in range(amount):
		var t = action_rotor_scene.instance()
		#t.add_to_group("persistent")
		$action_rotor_container.add_child(t)
		
		
	
	#return action_rotor_position
	
	pass

var list_of_rotor_pos=[]

func change_in_action_rotor_state():

	for i in range(get_node("action_rotor_container").get_child_count()):
			
			print("fight commando")
			
			action_rotor_position= {
			
				size=get_node("action_rotor_container").get_child_count(),
			
			pos = {
				x = get_node("action_rotor_container").get_children()[i].position.x,
				y = get_node("action_rotor_container").get_children()[i].position.y
			},
			
		}
			
			list_of_rotor_pos.append(action_rotor_position)
			print(list_of_rotor_pos)
	save_game.save_action_rotor_state(list_of_rotor_pos)

	
	pass

func gameover():
	if not $level1_hud/hud/gameover/anim.is_playing():
		$level1_hud/hud/gameover/anim.play("show_gameover")


	
func _on_spawn_time_timeout():
	action_rotor_spawn(2)
	pass # Replace with function body.

	
func get_savedgame_info_from_file():
	#try to load a saved file
	var save_file = File.new()
	if not save_file.file_exists(save_game.SAVE_PATH):
		return
		
	#parse the file data if it exists
	save_file.open(save_game.SAVE_PATH,File.READ)
	savedgame_data = parse_json(save_file.get_as_text())
	
	save_file.close()
	
	
func get_actionrotor_info_from_file():
	#try to load a saved file
	var save_file = File.new()
	if not save_file.file_exists(save_game.ACTION_ROTOR_PATH):
		return
		
	#parse the file data if it exists
	save_file.open(save_game.ACTION_ROTOR_PATH,File.READ)
	actionrotor_data = parse_json(save_file.get_as_text())
	
	save_file.close()
	
	pass
	
func reconstruct_rotor_state(boolean):
	if boolean == true:
		save_game.load_action_rotor_state()
		
		for i in save_game.art.size():
			
			var dict = save_game.art[i]
			var r = action_rotor_scene.instance()
			print("worked")
			r.position = Vector2(dict['pos'].x,dict['pos'].y)
			$action_rotor_container.add_child(r)
	else:
		return
		
	pass

func _on_main_pressed():
	get_tree().change_scene("res://LETTERS/main_screen.tscn")
	pass # Replace with function body.

func _notification(what):
	
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		get_tree().paused = true
		$level1_hud/hud/pause_control/pause_anim.play("pause_anim")
		
		


func _on_level1_tree_entered():
	print("tree enterend")
	pass # Replace with function body.

func load_life():
	
	if global.is_game_loaded==true:
		
		$player.get_node("escape_timer").start()
		print("is game loaded")
		
		$player.get_node("anim").play("life")
		
	pass

func play_pause_slider():
	$level1_hud/hud/pause_btn/slider.play("pause_slide")
	
	pass
	
func achievement_notification(played):
	global.achievement_played = played
	#save_game.load_game(true)
	#save_game.load_achievement()
	if achievement.is_goal1_achieved ==true:
		
		if global.achievement_played == false and savedgame_data['/root/level1/player']["goal1_played"] ==false:
			$notification.play("goal1")
			global.achievement_played=true
			goal1_played = played
			
			#save_game.save_game()

func motivation():
	var picked_motivation = randi()%list_of_motivation.size()
	
	if list_of_motivation[picked_motivation].name =="ramdas_audio":
		$motivation/anim.play("ramdas_anim")
		if not list_of_motivation[picked_motivation].playing:
#			if not achievement.get_node("main_music").volume_db <=-50:
#				print("music volume decrease")
#				achievement.get_node("main_music").volume_db -= 30 *get_process_delta_time()
			list_of_motivation[picked_motivation].play()
		
	

	

func _on_ramdas_audio_finished():
	print("finished")
	if $motivation/ramdas_audio.playing:
		$motivation/ramdas_audio.stop()
#	if not achievement.get_node("main_music").volume_db > 0:
#		achievement.get_node("main_music").volume_db+=30 *get_process_delta_time()
	pass # Replace with function body.


func _on_pause_control_change_in_action_rotor_state():
	change_in_action_rotor_state()
	print("change state saved")
	pass # Replace with function body.


func _on_save_game_pressed():
	get_node("player").is_player_dead = false
	
	save_game.save_game()
	
	save_game.save_high_score()
	
	save_game.save_achievement()
	
	change_in_action_rotor_state()
	
	yield(get_tree().create_timer(0.5),"timeout")
	#print("CLICKED UPON")
	get_tree().change_scene("res://LETTERS/themain.tscn")
	global.pause = false
	get_tree().paused = false
	pass # Replace with function body.
