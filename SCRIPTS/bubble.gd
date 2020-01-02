extends Node2D

var speed =0.2

var is_player_dead =false

var normal_player_score = 0

var timer =1

onready var watchout= get_parent().get_node("watchout")

onready var player = preload("res://LETTERS/player.tscn")

func _ready():
	
	pass
	
func _process(delta):
	update_score(delta)
	pass

func _physics_process(delta):
	
	var ballx = $bubble1.global_position.x - $bubble2.global_position.x
	var bally = $bubble1.global_position.y - $bubble2.global_position.y
	
	translate(Vector2(ballx,bally)*speed*delta)
	#$bubble2.linear_velocity = Vector2(ballx,bally).normalized()*100*delta
	#$bubble2.look_at(get_global_mouse_position())
	
	var dirx = get_global_mouse_position().x - $bubble1.global_position.x
	var diry = get_global_mouse_position().y - $bubble1.global_position.y
	
	translate(Vector2(dirx,diry) *10 *delta)
	
	if is_player_dead==true:
		$bubble2/bubble2_area/collision.disabled=true
	

	
	pass

func _on_bubble2_area_area_entered(area):
	
	if area.is_in_group("left_slicer"):
		player_died()
		
	if area.is_in_group("right_slicer"):
		player_died()
		
	pass # Replace with function body.

func player_died():
	
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
		
		}
		
	return save_dict
	pass
	
func reset_state():
	
	is_player_dead = false
	normal_player_score = 0
	timer =1
	
	pass
	
func _on_anim_animation_finished(anim_name):
	if anim_name == "life":
		$anim.stop() 
	pass # Replace with function body.