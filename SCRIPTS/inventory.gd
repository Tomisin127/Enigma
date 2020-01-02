extends Node


onready var texture_rect = TextureRect.new()
onready var item_name = Label.new()
onready var btn = TextureButton.new()

onready var item_node_dict ={}

func _ready():
	actions()
	
	pass

func _process(delta):
	
	
	create_item(global.item_data)
	
	
	pass
	
	

func _on_main_screen_btn_pressed():
	get_tree().change_scene("res://LETTERS/main_screen.tscn")
	pass # Replace with function body.


func create_item(dict):
	if global.item_purchased==true:
		
		texture_rect.texture =dict['sprite']
		item_name.text = dict['name']
		
		item_name.rect_position.x += texture_rect.texture.get_size().x 
		item_name.rect_position.y = texture_rect.texture.get_height()/2
		
		btn.rect_scale = Vector2(0.03,0.03)
		btn.texture_normal = load("res://CONTROLS/buy_btn.png")
		
		$Control/inv_list.add_child(texture_rect)
		texture_rect.add_child(item_name)
		texture_rect.add_child(btn)
		
		global.item_purchased = false
		
	
	
func actions():
	btn.connect("pressed",self,"set_red_pressed")
	pass

func set_red_pressed():
	
	if global.is_player_instanced==false:
		return
	else:
		global.player_sprite.texture =global.item_data['sprite']
		
	print("get me down")
	pass