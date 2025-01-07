extends Node2D

@onready var keys := $Keys
@onready var Trunk := $Trunk
@onready var coin := $Coin
@onready var reset_t := $Keys/reset_timer
@onready var line_ed := $Keys/Lock/LineEdit
@onready var op_s := $Trunk/open_sound
@onready var enumc := $Keys/Lock/enum
@onready var op_1 := $Keys/Key1/op1
@onready var op_2 := $Keys/Key2/op2
@onready var op_3 := $Keys/Key3/op3
@onready var op_4 := $Keys/Key4/op4

@onready var Voices=DisplayServer.tts_get_voices_for_language("pt_BR")
@onready var speaker:String = Voices[Global.selected_voice_id]

var falas_speak = 0
var errors = 0;
var first_time = true;
var write_anw
var speak_enum
var s_op_1
var s_op_2
var s_op_3
var s_op_4 
var s_enum
var congrats = "Parabéns viajante! Você recebeu uma moeda dourada!"
var explain = "Você errou, viajante! Para abrirmos o baú, o resultado da expressão da chave deve ser o mesmo resultado da expressão do baú! Você consegue, vamos tentar outra vez!"
var explain_basic = "Não parece certo, vamos tentar outra vez!"

# 4 alternativas | enunciado | resposta 
var options = [
	["2+6", "4+9", "5+5","3+4","3+7","3"],			#A1
	["14-6", "22-11", "2+3","10-4","13-7","4"],		#A2
	["3+5", "4+5", "11-2","14-7","6+2","1"],		#A3
	["14-8", "10-3", "16-8","7-1","2+5","2"],		#A4
	["10+5", "12+7", "12+4","20-5","8+8","3"],		#A5
	["8+2", "17-7", "13-3","8+3","15-4","4"],		#A6
	["15-6", "5+3", "7+4","10-2","5+4","1"],		#A7
	["8+6", "12+3", "22-8","18-5","19-4","2"],		#A8
	["7+2", "5-6", "7+4","7+2","5+6","3"],			#A9
	["20+12", "42-8", "38-4","19+16","40-5","4"],	#A10
]
func _ready():
	_quiz()
	AutoloadScene.previous_scene = "res://scenes/levels/fase_bau/Trunk_Puzzle.tscn"

func _convert_hifen_to_minus(new_text):
	var c_new_text = new_text.replace("-"," menos")
	return c_new_text
	
func _random_keys():
	var random_index = randi() % options.size()
	var option = options[random_index]
	errors = 0;
	op_1.text = option[0]
	s_op_1 = _convert_hifen_to_minus(option[0])
	op_2.text = option[1]
	s_op_2 = _convert_hifen_to_minus(option[1])
	op_3.text = option[2]
	s_op_3 = _convert_hifen_to_minus(option[2])
	op_4.text = option[3]
	s_op_4 = _convert_hifen_to_minus(option[3])
	enumc.text = option[4]
	s_enum = _convert_hifen_to_minus(option[4])
	write_anw = option[5]
	speak_enum = "Chave 1| "+s_op_1+"Chave 2| "+s_op_2+"Chave  3| "+s_op_3+"Chave 4| "+s_op_4+"Báu "+s_enum+"Aperte R para repetir!"

func _on_line_edit_text_submitted(new_text):
	if new_text == write_anw :
		write_ans()
	elif (errors < 2):
		line_ed.text = ""
		Dialogic.start('wrong_simple')
		DisplayServer.tts_speak(explain_basic, speaker)
		errors+= 1
		
	elif (errors == 2) :
		wrong_ans()

func _quiz():
	_random_keys()
	keys.visible = true
	speak_exerc()

func _input(event: InputEvent):
	
	if (event is InputEventKey and first_time and (event.keycode == KEY_TAB or event.keycode == KEY_ENTER) and event.pressed) or (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed):
		if (line_ed.text!=""):
			DisplayServer.tts_stop()
			_on_line_edit_text_submitted(line_ed.text)

	if event is InputEventKey and (event.keycode != KEY_TAB or event.keycode != KEY_ENTER) and event.pressed and first_time:
		if event.keycode >= KEY_KP_0 and event.keycode <= KEY_KP_9 :
			Dialogic.end_timeline()
			line_ed.text= str(OS.get_keycode_string(event.physical_keycode)).substr(3,1)
			DisplayServer.tts_stop()
			DisplayServer.tts_speak(line_ed.text, speaker)
		elif event.keycode >= KEY_0 and event.keycode <= KEY_9:
			Dialogic.end_timeline()
			line_ed.text = str(OS.get_keycode_string(event.physical_keycode))
			DisplayServer.tts_stop()
			DisplayServer.tts_speak(line_ed.text, speaker)
		elif event.keycode == KEY_R :
			speak_exerc()
		
	if event is InputEventKey and event.keycode == KEY_ESCAPE:
			Dialogic.end_timeline()
			DisplayServer.tts_stop()
			AudioController._play_select()
			AudioController._pause_backmusic(true)
			get_tree().change_scene_to_file("res://scenes/menu/menu_pausa.tscn")
			
func write_ans():
	first_time = false;
	keys.visible = false
	Trunk.play("Open")
	op_s.play()
	await op_s.finished 
	coin.visible = true
	Dialogic.start('rg_ans')
	DisplayServer.tts_speak(congrats, speaker)
	

func wrong_ans():
	Dialogic.start('wrong_ans')
	DisplayServer.tts_speak(explain, speaker)
	reset_t.wait_time = 15
	reset_t.start()

func _on_reset_timer_timeout():
	Dialogic.end_timeline()
	line_ed.text = ""
	_random_keys()
	speak_exerc()
	
func speak_exerc():
	DisplayServer.tts_stop()
	DisplayServer.tts_speak(speak_enum, speaker, AudioController.volume)
	
