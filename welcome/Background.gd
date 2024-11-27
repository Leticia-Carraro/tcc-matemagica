extends Node2D

#@onready var SceneTransitionAnimation = $"../SceneTransitionAnimation/AnimationPlayer"
@onready var SceneTransitionAnimation = $"../SceneTransitionAnimation/AnimationPlayer"
@onready var InitialText = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	SceneTransitionAnimation.play("fade_in")
	wait(0.5)
	SceneTransitionAnimation.play("fade_out")
	wait(0.5)	
	InitialText.play("fade_in_introduction")
	wait(10)	
	await get_tree().create_timer(8).timeout
	$"../AudioStreamPlayer2".play()
	await get_tree().create_timer(8).timeout
	SceneTransitionAnimation.play("fade_in")
	wait(0.5)	
	get_tree().change_scene_to_file("res://welcome/story.tscn")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"): 
		get_tree().change_scene_to_file("res://welcome/story.tscn")
	else: 
		pass

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
