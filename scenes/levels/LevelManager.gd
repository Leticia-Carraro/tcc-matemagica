extends Node

@onready var camera_2d = $"../SceneObjects/Camera2D"
@onready var solve = $"../UI/Solve"
@onready var texto_1 = $"../UI/Dialogue/texto_1"
@onready var texto_2 = $"../UI/Dialogue/texto_2"
@onready var texto_3 = $"../UI/Dialogue/texto_3"
@onready var texto_4 = $"../UI/Dialogue/texto_4"
@onready var dialogue = $"../UI/Dialogue"

var counter #counts wrong answers
var result
var pitch = 2.0 #tts config
var speed = 1.3 #tts config
var volume = AudioController.volume #tts config
var speaker: String = DisplayServer.tts_get_voices_for_language("pt_BR")[0] #tts config
var cur_position #current horizontal camera position
var x_position #horizontal camera position
var y_margin  #vertical camera margin
var y_position #vertical camera position

func _ready():
	x_position = -1
	cur_position = -1
	y_margin =  0.25
	y_position = -0.4
	counter = 0
	result = dialogue.result 
	AutoloadScene.previous_scene = "res://scenes/levels/level1.tscn"
	DisplayServer.tts_resume()
	AudioController._play_backmusic()
	
func _process(delta):
	#input button action
	if Input.is_action_just_pressed("pause"):
		DisplayServer.tts_stop()
		AudioController._play_select()
		AudioController._pause_backmusic(true)
		get_tree().change_scene_to_file("res://scenes/menu/menu_pausa.tscn")
		
	if Input.is_action_just_pressed("left"):
		x_position -= 1
		if x_position < 0:
			x_position = -1
		cur_position = x_position
		DisplayServer.tts_stop()
		
	if Input.is_action_just_pressed("right"):
		x_position += 1
		if x_position > 1:
			x_position = 1
		cur_position = x_position
		DisplayServer.tts_stop()
		
	if Input.is_action_just_pressed("up"):
		x_position = 0
		y_position = -1.0
		y_margin = 1.0
		solve.grab_focus()
		AudioController._play_question()
		DisplayServer.tts_stop()
		
	if Input.is_action_just_pressed("down"):
		x_position = cur_position
		y_position = -0.4
		y_margin = 0.25
		DisplayServer.tts_stop()
	
	#Dragging camera
	if y_position == -0.4:
		camera_2d.set_drag_horizontal_offset(x_position)
	else:
		camera_2d.set_drag_horizontal_offset(0)
	camera_2d.set_drag_vertical_offset(y_position)
	camera_2d.set_drag_margin(SIDE_BOTTOM, y_margin)
	
	#showing/hiding texts and audiodescription according camera position
	if x_position == -1.0 and y_position == -0.4:
		texto_1.show()
		var text1: String = $"../UI/Dialogue/texto_1/Label".get("text")
		_speak(text1)
	else:
		texto_1.hide()
		
	if x_position == 0 and y_position == -0.4:
		texto_2.show()
		var text2: String = $"../UI/Dialogue/texto_2/Label".get("text")
		_speak(text2)
	else:
		texto_2.hide()
		
	if x_position == 1.0 and y_position == -0.4:
		texto_3.show()
		var text3: String = $"../UI/Dialogue/texto_3/Label".get("text")
		_speak(text3)
	else:
		texto_3.hide()
		
	if  y_position == -1.0: 
		texto_4.show()
	else:
		texto_4.hide()

#enables tts_speak
func _speak(text):
	DisplayServer.tts_speak(text, speaker, volume, pitch, speed, 2)
	DisplayServer.tts_pause()
	
#sets effects after submitting text in LineEdit
func _on_solve_text_submitted(new_text):
	if new_text == str(result):
		AudioController._play_congrats()
		AutoloadScene.previous_scene = "res://scenes/levels/level2.tscn"
		AudioController._play_backmusic()
	else:
		counter += 1
		if counter > 2:
			AudioController._play_answer()
		else:
			AudioController._play_try()
	solve.text = ""

#sets audiodescription in LineEdit
func _on_solve_text_changed(new_text):
	DisplayServer.tts_speak(new_text, speaker, volume, pitch, speed, 1)
