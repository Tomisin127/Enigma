extends Node

var items_in_shop = {"red_orb":2300, "godot": 4920}

var items_details ={}

var item_purchased =false


func _ready():
	
	#print(get_node("Control/ItemList").items)
	
	#for i in range(get_node("Control/ItemList").items.size()):
		
		#if $Control/ItemList.items == "red_orb":
			
	
	pass


func _process(delta):
	
	global.item_purchased = item_purchased
	
	global.item_data = items_details
	
	pass
	
func _on_red_orb_purchase_pressed():
	
	item_purchased = true
	items_details= {"name":"red_orb", "sprite":get_node("Control/VBoxContainer/red_orb").texture}
	if not is_currency_less_than_item_price():
		achievement.currency -=items_in_shop["red_orb"]
		print(achievement.currency)
		#save_game.save_achievement()	
	pass # Replace with function body.
	
	
func _on_godot_purchase_pressed():
	
	item_purchased = true
	items_details= {"name":"godot", "sprite":get_node("Control/VBoxContainer/godot").texture}
	if not is_currency_less_than_item_price():
		achievement.currency -=items_in_shop["godot"]
		print(achievement.currency)
		#save_game.save_achievement()	
	pass # Replace with function body.
	


func _on_main_screen_btn_pressed():
	
	get_tree().change_scene("res://LETTERS/main_screen.tscn")
	pass # Replace with function body.
	
	
func is_currency_less_than_item_price():
	
	for r in items_in_shop.keys():
		if achievement.currency < items_in_shop[r]:
			return true
			
	pass
	
	
	
