extends StaticBody2D

export var velocity = Vector2()

var middle


func _ready():
	
	middle = get_viewport_rect().size/2
	
	pass

func _process(delta):
	translate(velocity *delta)
	
	
	if position.y >= get_viewport_rect().size.y+50:
		position= Vector2(middle.x,-180)