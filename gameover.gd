extends Area2D

func _on_Area2D_body_entered(body):
	print("Triggered by: ", body.name)
	if body.is_in_group("player"):
		print("Player triggered game over!")
		var error = get_tree().change_scene_to_file("res://gameover.tscn") # Adjust path as needed
		print("Scene change result: ", error)


func _on_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
