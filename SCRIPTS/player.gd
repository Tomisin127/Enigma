extends KinematicBody2D

var speed = 10

var is_player_dead =false

var normal_player_score = 0

var timer =1

onready var level1_hud = get_parent().get_node("level1_hud")

func _ready():
	
	if global.is_game_loaded:
		$player_area/collision.disabled =true
	
	pass

func _process(delta):
	
	
	
	#set_process_input(true)
	update_score(delta)
	
	pass

func _input(event):
	
	if event is InputEventScreenDrag or event is InputEventScreenTouch or event is InputEventGesture or event is InputEventMouseMotion:
		var dirx = (get_global_mouse_position().x - self.position.x)*0.2
		var diry = (get_global_mouse_position().y -self.position.y)*0.2
		translate(Vector2(dirx,diry) *speed *0.2)
	pass
	
func _physics_process(delta):
	
	#increase currency as player plays
	
	
	if is_player_dead==true:
		$player_area/collision.disabled=true
	
	
	pass

func _on_player_area_area_entered(area):
	
	if area.is_in_group("action_rotor_area"):
		player_died()
	
	if area.is_in_group("left_slicer"):
		player_died()
		
	if area.is_in_group("right_slicer"):
		player_died()
		
		
	pass # Replace with function body.

func player_died():
	
	#print("player is dead",is_player_dead)
	is_player_dead = true
	$anim.play("fade")

func update_score(change):
	if is_player_dead==false:
		#update score
		normal_player_score +=1
		
		global.player_score = normal_player_score
		
		timer +=change
		
		global.timer = timer
		
		
	pass
	

func save():
	var save_dict = {
		pos ={
			x = position.x,
			y = position.y
			},
			
		
		is_player_dead= is_player_dead,
		
		normal_player_score = normal_player_score,
		
		timer = timer,
		
		currency = achievement.currency,

		goal1_played = level1_hud.get_parent().goal1_played
		}
		
	return save_dict
	pass
	
func reset_state():
	
	is_player_dead = false
	normal_player_score = 0
	timer =1
	
	pass
	

func _on_escape_timer_timeout():
	if global.is_game_loaded ==true:
		$player_area/collision.disabled=false
	pass # Replace with function body.


func _on_anim_animation_finished(anim_name):
	if anim_name == "life":
		$anim.stop()
	pass # Replace with function body.
