
extends Node

onready var left_slicer = preload("res://LETTERS/left_slicer.tscn")
onready var right_slicer = preload("res://LETTERS/right_slicer.tscn")

signal pause_slider

signal show_gameover

var left_slicer_position = {}

var right_slicer_position = {}

onready var savedgame_data = {}

onready var left_slicer_data = {}

onready var right_slicer_data= {}

signal load_life

func _ready():
	
	connect("load_life",self,"load_life",[],CONNECT_ONESHOT)
	
	global.watchout_clicked =true
	
	left_slicer_spawn()
	right_slicer_spawn()
	
	get_tree().set_auto_accept_quit(false)
	
	get_savedgame_info_from_file()
	
	get_left_slicer_info_from_file()
	
	get_right_slicer_info_from_file()
	
#	save_game.load_watchout_game(true if savedgame_data['/root/watch_out/player']['is_player_dead']==false else false)
	if not savedgame_data.empty():
		save_game.load_watchout_game(true if savedgame_data['/root/watch_out/bubble']['is_player_dead']==false else false)
	
	self.connect("show_gameover",self,"gameover",[],CONNECT_ONESHOT)
	
	self.connect("pause_slider",self, "play_pause_slider",[],CONNECT_ONESHOT)
	
	get_tree().paused = true
	get_viewport().gui_disable_input=true
	yield(get_tree().create_timer(2),"timeout")
	get_tree().paused = false
	get_viewport().gui_disable_input=false
	
	emit_signal("load_life",self, "load_life")
	
#	reconstruct_left_n_right_slicer_state(true if savedgame_data['/root/watch_out/player']['is_player_dead']==false else false)
	#reconstruct_left_n_right_slicer_state(true if savedgame_data['/root/watch_out/bubble']['is_player_dead']==false else false)
	
	pass
	

func load_life():
	
	if global.is_game_loaded==true:
		$bubble.get_node("escape_timer").start()
		#print("is game loaded")
		
		
		$bubble.get_node("anim").play("life")
			
	pass
func _process(delta):
	
	global.watchout_clicked = true
	save_game.save_achievement()
	
	save_game.save_watchout_game()
	
	
	#if achievement.is_goal1_achieved==true:
	
	
#	if $player.is_player_dead==true:
#		emit_signal("pause_slider")
#		emit_signal("show_gameover")
	
	if $bubble.is_player_dead==true:
		emit_signal("pause_slider")
		emit_signal("show_gameover")

func left_slicer_spawn():

	var l = left_slicer.instance()
		
		#t.add_to_group("persistent")
	$left_container.add_child(l)
		
func right_slicer_spawn():

	
	var r = right_slicer.instance()
		
	$right_container.add_child(r)
	
	#return action_rotor_position
	
	pass

var list_of_left_slicer_pos=[]

func change_in_left_slicer_state():
	for i in range(get_node("left_container").get_child_count()):
			
			#print(i)
			left_slicer_position= {
				size=get_node("left_container").get_child_count(),
			
			pos = {
				x = get_node("left_container").get_children()[i].position.x,
				y = get_node("left_container").get_children()[i].position.y
			},
			
		}
			
			list_of_left_slicer_pos.append(left_slicer_position)
	save_game.save_left_slicer_state(list_of_left_slicer_pos)


var list_of_right_slicer_pos=[]

func change_in_right_slicer_state():
	for i in range(get_node("right_container").get_child_count()):
			
			#print(i)
			right_slicer_position= {
				size=get_node("right_container").get_child_count(),
			
			pos = {
				x = get_node("right_container").get_children()[i].position.x,
				y = get_node("right_container").get_children()[i].position.y
			},
			
		}
			
			list_of_right_slicer_pos.append(right_slicer_position)
	save_game.save_right_slicer_state(list_of_right_slicer_pos)

func gameover():
	if not $watchout_hud/hud/gameover/anim.is_playing():
		$watchout_hud/hud/gameover/anim.play("show_gameover")


	
func get_savedgame_info_from_file():
	#try to load a saved file
	var save_file = File.new()
	if not save_file.file_exists(save_game.SAVE_WATCHOUT_PATH):
		return
		
	#parse the file data if it exists
	save_file.open(save_game.SAVE_WATCHOUT_PATH,File.READ)
	savedgame_data = parse_json(save_file.get_as_text())
	
	save_file.close()
	
	
func get_left_slicer_info_from_file():
	#try to load a saved file
	var save_file = File.new()
	if not save_file.file_exists(save_game.LEFT_SLICER_PATH):
		return
		
	#parse the file data if it exists
	save_file.open(save_game.LEFT_SLICER_PATH,File.READ)
	left_slicer_data = parse_json(save_file.get_as_text())
	
	
	save_file.close()
	
	pass


func get_right_slicer_info_from_file():
	#try to load a saved file
	var save_file = File.new()
	if not save_file.file_exists(save_game.RIGHT_SLICER_PATH):
		return
		
	#parse the file data if it exists
	save_file.open(save_game.RIGHT_SLICER_PATH,File.READ)
	right_slicer_data = parse_json(save_file.get_as_text())
	
	save_file.close()
	
	pass
func reconstruct_left_n_right_slicer_state(boolean):
	if boolean == true:
		
			for i in left_slicer_data.size():
				
				if left_slicer_data[i]:
					var dict = left_slicer_data[i]
					var l = left_slicer.instance()
					
					#print("worked")
					l.position = Vector2(dict['pos'].x,dict['pos'].y)
					$left_container.add_child(l)
					
			for i in right_slicer_data.size():
				
				if right_slicer_data[i]:
					var dict = right_slicer_data[i]
					var r = right_slicer.instance()
					
					#print("worked")
					r.position = Vector2(dict['pos'].x,dict['pos'].y)
					$right_container.add_child(r)


	else:
		return
		
	pass

func _on_main_pressed():
	get_tree().change_scene("res://LETTERS/main_screen.tscn")
	pass # Replace with function body.

func _notification(what):
	
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		
		get_tree().paused = true
		
		change_in_left_slicer_state()
		change_in_right_slicer_state()
		
		print(left_slicer_data)
		
		yield(get_tree().create_timer(0.1),"timeout")
		
		get_tree().set_auto_accept_quit(false)
		


func _on_level1_tree_entered():
	print("tree enterend")
	pass # Replace with function body.


func play_pause_slider():
	$watchout_hud/hud/pause_btn/slider.play("pause_slide")
	
	pass
	
	
