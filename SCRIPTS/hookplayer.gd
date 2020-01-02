extends KinematicBody2D

var speed =0.2

var velocity = Vector2()

func _ready():
	
	
	pass

func _physics_process(delta):
	
	look_at(get_global_mouse_position())
	
	var dirx = get_global_mouse_position().x - $hook_area_1/hook_1_pos.global_position.x
	var diry = get_global_mouse_position().y - $hook_area_1/hook_1_pos.global_position.y
	
	velocity = Vector2(dirx,diry)
	translate(velocity*speed *delta)
	pass

