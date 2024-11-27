extends Node

@onready var level_manager = %LevelManager
@onready var continuar = $Backend/VBoxContainer/Continuar
@onready var audio = $Backend/VBoxContainer/Audio


var speaker: String = DisplayServer.tts_get_voices_for_language("pt_BR")[0]
var speed = 1.2
var volume = 70

func _ready():
	DisplayServer.tts_stop()
	continuar.grab_focus()
	
func _process(delta):
	pass
	
	
func _on_continuar_pressed():
	DisplayServer.tts_stop()
	get_tree().change_scene_to_file(AutoloadScene.previous_scene)
	AudioController._play_exit()
	AudioController._pause_backmusic(false)
	
	
func _on_audio_pressed():
	pass


func _on_sair_pressed():
	DisplayServer.tts_stop() # Replace with function body.
	AudioController._play_select()
	get_tree().change_scene_to_file("res://level_selection/level_selection.tscn")

func _on_audio_focus_entered():
	DisplayServer.tts_speak("Áudio", speaker, volume, 1.0, speed, 1)
	
	
func _on_continuar_focus_entered():
	DisplayServer.tts_speak("Continuar", speaker, volume, 1.0, speed, 1)
	
	
func _on_sair_focus_entered():
	DisplayServer.tts_speak("Sair", speaker, volume, 1.0, speed, 1)
	
	
func _on_continuar_focus_exited():
	if  Input.is_action_just_pressed("up") or  Input.is_action_just_pressed("down"):
		AudioController._play_cursor()


func _on_audio_focus_exited():
	AudioController._play_cursor()


func _on_sair_focus_exited():
	AudioController._play_cursor()
