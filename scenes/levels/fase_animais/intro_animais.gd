extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$saudacoes.play()
	await get_tree().create_timer(5).timeout
	$Panel.show()
	$explicacao.play()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event: InputEvent):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ENTER:
			get_tree().change_scene_to_file("res://scenes/levels/fase_animais/level1.tscn")
		if event.keycode == KEY_R:
			$explicacao.play()
			
