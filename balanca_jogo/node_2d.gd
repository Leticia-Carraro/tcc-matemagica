extends Node2D

# Lista de nós que podem ser focados
@onready var focusable_nodes: Array[Node] = [$balanca/conta, $balanca/SpinBox, $balanca/Label]

# Índice do nó atualmente focado
var current_index: int = 0
var conta

func _ready():
	# Verifica se há nós válidos
	if focusable_nodes.size() > 0:
		_set_focus_to_current()

func _input(event: InputEvent):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_TAB:
			_move_focus_forward()
		elif event.keycode == KEY_ENTER or event.keycode == KEY_KP_ENTER:
			submit_answer()	

# Alterna o foco para o próximo nó
func _move_focus_forward():
	current_index = (current_index + 1) % focusable_nodes.size()
	_set_focus_to_current()

# Define o foco no nó atual
func _set_focus_to_current():
	if is_instance_valid(focusable_nodes[current_index]):
		focusable_nodes[current_index].grab_focus()
	if current_index != 1:
		if current_index == 0:
			conta = focusable_nodes[current_index].text.replace("*", "vezes")
			conta = conta.replace("/", "dividido por")
			conta = conta.replace("-", "menos")
			conta = conta.replace("+", "mais")
			speak_text(conta)	
		else:
			speak_text(focusable_nodes[current_index].text)
	else:
		speak_text("insira sua resposta")	

func submit_answer():
	pass

func speak_text(text: String):
	DisplayServer.tts_stop()
	var voices = DisplayServer.tts_get_voices_for_language("pt")
	var voice_id = voices[Global.selected_voice_id]

	DisplayServer.tts_speak(text, voice_id, 50, 1.0, 0.8)
