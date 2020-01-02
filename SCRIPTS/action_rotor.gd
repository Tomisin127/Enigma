extends StaticBody2D

export var velocity = Vector2()

var changed_velocity = Vector2()

var middle

onready var level1 = get_parent().get_parent()

signal change_vel

func _ready():
	randomize()
	self.modulate= Color(rand_range(0.0,1.0),rand_range(0.0,1.0),rand_range(0.0,1.0))
	#self.connect("change_vel",self,"_on_Timer_timeout",[])
	
	
	velocity= Vector2(0,50)
	middle = get_viewport_rect().size/2
	
	
	
	pass

func _process(delta):

	randomize()
	
	rotate(PI*2*delta)

		#wrap around screen
	if position.x >=get_viewport_rect().size.x -30:
		position.x =get_viewport_rect().size.x-30

	if position.x <= 30:
		position.x = 30

	randomize()
	
	#_on_Timer_timeout()
	
	translate(velocity *delta)
	
	#emit_signal("change_vel")
		
		
	if changed_velocity.length() >=0:
		#print(changed_velocity)
		velocity =Vector2(0,0)
		translate(changed_velocity *50 *delta) 
		
	if position.y >= get_viewport_rect().size.y+50:
		queue_free()
		#position= Vector2(middle.x,-180)
			
		

func _on_Timer_timeout(extra_arg_0):
	#print("timeout")
	extra_arg_0 = Vector2(rand_range(-100,100),rand_range(0,50))
	
	changed_velocity= extra_arg_0.normalized()
	
	return extra_arg_0
	
	pass # Replace with function body.

