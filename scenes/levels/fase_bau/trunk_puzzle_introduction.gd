extends Node2D

@onready var falas = [
	"Hum... veja só o que encontramos na floresta, um baú encantado! ",
	"Ele parece estar trancado, deve guardar algo muito valioso...",
	"Mas veja só, tem 4 chaves e uma mensagem perto dele",
	"A mensagem diz que apenas a chave certa abrirá o baú",
	"Caso a chave errada seja usada 3 vezes, a expressão irá mudar.",
	"para abrirmos o baú, devemos usar a chave que contem uma expressão de mesmo valor que no cadeado do baú!",
]

@onready var Voices=DisplayServer.tts_get_voices_for_language("pt_BR")
@onready var speaker:String = Voices[Global.selected_voice_id]

var falas_speak = 0
var first_time = true
var speak_enum 

func _ready() -> void:
	if Dialogic.current_timeline != null:
		return
	$AnimationPlayer.play("new_animation")
	wait(2)
	#Deixando Blurry
	$BauIntroBlurry.set_visible(true)
	
	#Trazendo o Mago
	$Wizard2.play("new_animation")
	$Wizard.set_visible(true)
	
	# Iniciar o diálogo
	DisplayServer.tts_speak(falas[falas_speak], speaker)
	falas_speak+=1
	Dialogic.start('Quiz')
	get_viewport().set_input_as_handled()

	

func _input(event: InputEvent):
	if first_time:
		if (event is InputEventKey and (event.keycode == KEY_TAB or event.keycode == KEY_ENTER or event.keycode == KEY_KP_ENTER) and event.pressed) or (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed):
			if falas_speak <= falas.size() - 1:
				DisplayServer.tts_stop()
				DisplayServer.tts_speak(falas[falas_speak], speaker)
				falas_speak+=1
			elif (first_time):
				first_time = false
		
	else:
		Dialogic.end_timeline()
		get_tree().change_scene_to_file("res://scenes/levels/fase_bau/Trunk_Puzzle.tscn")
	
func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout		
