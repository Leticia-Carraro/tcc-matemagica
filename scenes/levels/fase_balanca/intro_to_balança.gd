extends Node2D

@onready var falas = [
"Preciso da sua ajuda! Estou ocupado com alguns feitiços... sabe como é",
"Esse pessoal de Sujópolis sabe como me dar trabalho!",
"Bem, preciso da sua ajuda urgentemente!!",
"Poderia ir até o grande mercado e comprar alguns ingredientes para mim, por favor?",
"Mas olhe só, o dinheiro está contadinho! Não vá gastar mais do que o necessário",
"Como saber o preço certo? Ora, isso é muito simples. Cada item tem um valor...",
"Por exemplo a pimenta dracônica, custa 7 moedas de ouro",
"Se você precisar comprar uma pimenta e uma bota suja, que custa 2 moedas, vai precisar pagar 9 moedas de ouro!",
"Fácil, né? Mas cuidado! O pessoal do mercado mágico opera uma balança mágica, que não faz só contas de adição...",
"Você também vai precisar fazer subtrações, pois temos alguns desses itens em casa já!",
"E quando formos comprar mais de um do mesmo item vai precisar fazer multiplicação! De vez em quando a balança fica maluca e pede até divisão!",
"Mas isso não vai ser um problema para uma pessoa esperta como você! Boa sorte! E TRAGA MEU TROCO!	",
]

@onready var Voices=DisplayServer.tts_get_voices_for_language("pt_BR")
@onready var speaker:String = Voices[Global.selected_voice_id]

var falas_speak = 0
var first_time = true
var speak_enum 

func _ready() -> void:
	if Dialogic.current_timeline != null:
		return
	# Tocar som e executar animações em sequência
	$feira_som.play()
	$Blurry.play("new_animation")
		
	#Deixando Blurry
	$BlurryFeira.set_visible(true)
	
	#Trazendo o Mago
	$WizardAnimation.play("new_animation")
	$Wizard.set_visible(true)
	
	# Iniciar o diálogo
	DisplayServer.tts_speak(falas[falas_speak], speaker)
	falas_speak+=1
	Dialogic.start('intro_balanca')
	get_viewport().set_input_as_handled()

func _input(event: InputEvent):
	if first_time:
		if (event is InputEventKey and (event.keycode == KEY_TAB or event.keycode == KEY_ENTER or event.keycode == KEY_KP_ENTER) and event.pressed) or (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed):
			if falas_speak <= falas.size() - 1:
				DisplayServer.tts_stop()
				DisplayServer.tts_speak(falas[falas_speak], speaker, AudioController.volume)
				falas_speak+=1
			elif (first_time):
				first_time = false
	else:
		Dialogic.end_timeline()
		get_tree().change_scene_to_file("res://scenes/levels/fase_balanca/balanca.tscn")
	
func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout		
