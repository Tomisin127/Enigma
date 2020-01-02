extends StaticBody2D

export var velocity = Vector2()

var middle


func _ready():
	
	self.modulate= Color(rand_range(0.0,1.0),rand_range(0.0,1.0),rand_range(0.0,1.0))
	middle = get_viewport_rect().size/2

	pass

func _process(delta):
	translate(-velocity *delta)
	randomize()
	
	if position.x <= -50:
		position= Vector2(270,rand_range(0,get_viewport_rect().size.y))
		

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	pass # Replace with function body.
