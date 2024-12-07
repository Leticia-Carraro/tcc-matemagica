extends Node


var voices = DisplayServer.tts_get_voices_for_language("pt_BR")
var speaker: String = voices[Global.selected_voice_id]
var speed = 1.2



func _ready():
	DisplayServer.tts_speak("Utilize as setas direita e esquerda para ajustar o volume da voz.", speaker,  AudioController.volume, 1.2, 1.0)
	$Voz.value = AudioController.volume
	
func _input(event: InputEvent):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ESCAPE:
			AudioController._play_exit()
			get_tree().change_scene_to_file("res://scenes/menu/menu_pausa.tscn")
		elif event.keycode == KEY_ENTER or event.keycode == KEY_KP_ENTER:
			AudioController._play_select()
			get_tree().change_scene_to_file("res://scenes/menu/menu_pausa.tscn")
		if event.keycode == KEY_RIGHT:
			AudioController.volume += 1
			$Voz.value =  AudioController.volume
		if event.keycode == KEY_LEFT:
			AudioController.volume -= 1
			$Voz.value =  AudioController.volume

func _on_voz_value_changed(value):
	if int(value) % 5 == 0:
		DisplayServer.tts_speak("testando", speaker,  AudioController.volume, 1.2, 1.0)
	AudioController._play_cursor()
	
	
