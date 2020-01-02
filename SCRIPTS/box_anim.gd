extends Node2D

onready var velocity

func _ready():
	
	randomize()
	velocity = Vector2(rand_range(-50,50),rand_range(-50,50))
	
#	self.modulate = Color(rand_range(0,1),rand_range(0,1),(rand_range(0,1)))
	pass
	
func _process(delta):
	
	if position.x >=get_viewport_rect().size.x -30:
		position.x =get_viewport_rect().size.x-30
		
	if position.x <= 30:
		position.x = 30
		
	translate(velocity *delta)
	
	
	pass


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	pass # Replace with function body.
