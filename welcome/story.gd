extends Node2D
@onready var SceneTransitionAnimation = $"SceneTransitionAnimation/AnimationPlayer"

# Called when the node enters the scene tree for the first time.
func _ready():
	SceneTransitionAnimation.play("fade_out")
	await get_tree().create_timer(0.5).timeout

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"): 
		get_tree().change_scene_to_file("res://voice_selection/voice_selection.tscn")
	else:
		$AnimationPlayer.play("1")
		await get_tree().create_timer(95).timeout
		SceneTransitionAnimation.play("fade_in")
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://voice_selection/voice_selection.tscn")
