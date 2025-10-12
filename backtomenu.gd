extends Button

func _ready():
	self.pressed.connect(_on_Button_pressed)

func _on_Button_pressed():
	print("Button pressed!")
	get_tree().change_scene_to_file("res://menu.tscn") # Use your menu's path
