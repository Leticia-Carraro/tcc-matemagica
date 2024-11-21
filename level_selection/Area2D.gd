extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_mouse_entered():
	$"../../AnimationPlayer".play("new_animation") # Replace with function body. # Replace with function body.


func _on_mouse_exited():
	$"../../AnimationPlayer".play("RESET") # Replace with function body.# Replace with function body.


func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		get_tree().change_scene_to_file("res://node_2d.tscn") # Replace with function body.
