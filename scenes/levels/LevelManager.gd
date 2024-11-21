extends Node

@onready var camera_2d = $"../SceneObjects/Camera2D"
@onready var solve = $"../UI/Solve"
@onready var texto_1 = $"../UI/Dialogue/texto_1"
@onready var texto_2 = $"../UI/Dialogue/texto_2"
@onready var texto_3 = $"../UI/Dialogue/texto_3"
@onready var texto_4 = $"../UI/Dialogue/texto_4"
@onready var dialogue = $"../UI/Dialogue"

@export var speed:float = 1.3;
@export var volume:int = 70;

var i = 0
var j = 0
var counter = 0
var result
var pitch = 2.0
var speaker: String = DisplayServer.tts_get_voices_for_language("pt_BR")[0]
var y_margin =  0.25
var y_axis = -0.4

func _ready():
	i = 0
	y_margin =  0.25
	y_axis = -0.4
	counter = 0
	result = dialogue.result 
	AutoloadScene.previous_scene = "res://scenes/levels/level1.tscn"
	DisplayServer.tts_resume()
	AudioController._play_backmusic()
	
func _process(delta):
	var cam_y = camera_2d.get_drag_margin(SIDE_BOTTOM)
	var position = [-1.0, 0.0, 1.0]
	if Input.is_action_just_pressed("pause"):
		DisplayServer.tts_stop()
		AudioController._play_select()
		AudioController._pause_backmusic(true)
		get_tree().change_scene_to_file("res://scenes/menu/menu_pausa.tscn")
		
		
	if Input.is_action_just_pressed("left"):
		i = i-1
		if i < 0:
			i = 0
		j = i
		DisplayServer.tts_stop()
		
	if Input.is_action_just_pressed("right"):
		i = i+1
		if i > 2:
			i = 2
		j = i
		DisplayServer.tts_stop()
		
	if Input.is_action_just_pressed("up"):
		i = 1
		y_axis = -1.0
		y_margin = 1.0
		solve.grab_focus()
		DisplayServer.tts_stop()
		
	if Input.is_action_just_pressed("down"):
		i = j
		y_axis = -0.4
		y_margin = 0.25
		DisplayServer.tts_stop()
		
	if y_axis == -1:
		camera_2d.set_drag_horizontal_offset(position[1])
	else:
		camera_2d.set_drag_horizontal_offset(position[i])
	camera_2d.set_drag_vertical_offset(y_axis)
	camera_2d.set_drag_margin(SIDE_BOTTOM, y_margin)
	if position[i] == -1.0 and camera_2d.get_drag_margin(SIDE_BOTTOM) < 0.3:
		texto_1.show()
		var text1: String = $"../UI/Dialogue/texto_1/Label".get("text")
		DisplayServer.tts_speak(text1,speaker, volume, pitch, speed, 0)
		DisplayServer.tts_pause()
	else:
		texto_1.hide()
		
	if position[i] == 0 and camera_2d.get_drag_margin(SIDE_BOTTOM) < 0.3 : 
		texto_2.show()
		var text2: String = $"../UI/Dialogue/texto_2/Label".get("text")
		DisplayServer.tts_speak(text2, speaker, volume, pitch, speed, 1)
		DisplayServer.tts_pause()
	else:
		texto_2.hide()
		
	if position[i] == 1.0 and camera_2d.get_drag_margin(SIDE_BOTTOM) < 0.3:
		texto_3.show()
		var text3: String = $"../UI/Dialogue/texto_3/Label".get("text")
		DisplayServer.tts_speak(text3, speaker, volume, pitch, speed, 2)
		DisplayServer.tts_pause()
	else:
		texto_3.hide()
		
	if camera_2d.get_drag_margin(SIDE_BOTTOM) > 0.3 : 
		texto_4.show()
		var text4: String = $"../UI/Dialogue/texto_4/Label".get("text")
		DisplayServer.tts_speak(text4, speaker, volume, pitch, speed, 1)
		if counter > 2:
			DisplayServer.tts_stop()
		else:
			DisplayServer.tts_pause()
		
	else:
		texto_4.hide()

func _on_solve_text_submitted(new_text):
	if new_text == str(result):
		AudioController._play_congrats()
	else:
		counter += 1
		if counter > 2:
			AudioController._play_answer()
		else:
			AudioController._play_try()
	solve.text = ""
