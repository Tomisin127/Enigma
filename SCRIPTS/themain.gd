extends Node

var anim
var time



func _ready():
	
	save_game.load_achievement()
	
	get_tree().set_auto_accept_quit(false)
	
	# get animation node
	anim = get_node("containobject/main")
	
	#play animation node
	anim.play("main")
	
	#get time node
	time = get_node("containobject/timer")
	time.set_wait_time(2.5)
	time.start()
	
	pass

# on time out switch scene to the next one
func _on_timer_timeout():
	
	# change to the next scene
	#interactive_loader.goto_scene("res://LETTERS/main_screen.tscn")
	
	get_tree().change_scene("res://LETTERS/main_screen.tscn")
	
	pass # replace with function body
	
