extends Node2D

@export var mute: bool = false

func _ready():
	pass

func _play_select():
	$SelectButton.play()
		
func _play_cursor():
	$Cursor.play()
		
func _play_exit():
	$ExitMenu.play()
	
func _play_try():
	$Wrong.play()
	await $Wrong.finished
	$TryAgain.play()

func _pause_backmusic(opt):
	$BackgroundMusic.set_stream_paused(opt)
	
func _play_answer():
	$Wrong.play()
	await $Wrong.finished
	$Answer1.play()
	await $Answer1.finished
	AutoloadScene._random(AutoloadScene.random_number)
	get_tree().reload_current_scene()

func _play_answer2():
	$Wrong.play()
	await $Wrong.finished
	$Answer2.play()
	await $Answer2.finished
	AutoloadScene._random(AutoloadScene.random_number)
	get_tree().reload_current_scene()
	
func _play_congrats():
	$Congrats1.play()
	await get_tree().create_timer(16).timeout
	get_tree().change_scene_to_file("res://scenes/levels/level2.tscn")
		
func _play_congrats2():
	$Congrats2.play()
	
func _play_backmusic():
	if not mute and AutoloadScene.previous_scene == "res://scenes/levels/level1.tscn":
		$BackgroundMusic.play()
	else: 
		$BackgroundMusic.stop()

func _play_backmusic2():
	if not mute and AutoloadScene.previous_scene == "res://scenes/levels/level2.tscn":
		$BackgroundMusic2.play()