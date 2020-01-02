extends StaticBody2D

export var velocity = Vector2()

var middle


func _ready():
	
	middle = get_viewport_rect().size/2
	
	pass

func _process(delta):
	translate(velocity *delta)
	
	randomize()
	if position.x >= get_viewport_rect().size.x+50:
		position= Vector2(-90,rand_range(0,get_viewport_rect().size.y))