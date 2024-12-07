extends AnimatedSprite2D

var num1 = 0
var num2 = 0
var aux = 0
var division_aux = true
var num_aux_div = 0
var cont_number_1 = 0
var operator = "+"
var correct_answer = 0
var operator_said = "mais"

@onready var label_equation = $conta
@onready var input_result = $SpinBox

func _ready():
	$Button.disabled = true
	$peso_direita.play("moeda_0")
	generate_equation()

func generate_equation():
	$Button.disabled = false
	num1 = randi() % 10  
	num2 = randi() % 10  
	aux = 0
	division_aux = true 
	num_aux_div = 0
	var operators = ["+", "-", "*", "/"]
	operator = operators[randi() % operators.size()]
	$".".play("equilibrio")
	
	match operator:
		"+":
			correct_answer = num1 + num2
		"-":
			if num1<num2:
				aux = num1
				num1 = num2
				num2 = aux
			correct_answer = num1 - num2
		"*":
			correct_answer = num1 * num2
		"/":
			num_aux_div = num2*num1
			num1 = num_aux_div
			if num2 == 1 or num1 == num2:
				cont_number_1 +=2
			if cont_number_1 >=2:
				num2 = randi() % 10 
				cont_number_1 -=1
			while division_aux:
				if num2 != 0 and num1 != 0 and num1 % num2 == 0 and num1 >= num2 :
					division_aux = false
				else:
					num1 = randi() % 10
					num2 = randi() % 10
			correct_answer = num1 / num2
	if num1 <= 10 and operator != "*" :
		$peso_esquerda_num_1.play("{num_1}".format({"num_1": str(num1)}))
	else:
		$peso_esquerda_num_1.play("nothing")
	
	if num2 <= 10 and operator != "/":
		$peso_esquerda_num_2.play("{num_2}".format({"num_2": str(num2)}))
	else:
		$peso_esquerda_num_2.play("nothing")
	
	if operator == "*":
		operator_said = "vezes"
	elif operator == "/":
		operator_said = "divido por"
	elif operator == "-":
		operator_said = "menos"
	elif operator == "+":
		operator_said = "mais"
		
	var conta = str(num1) + " " + operator_said + " " + str(num2) + " = a?"
	speak_text(conta)
	label_equation.text = str(num1) + " " + operator + " " + str(num2) + " = ?"

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func _on_button_pressed():
	if operator == "*":
		operator_said = "vezes"
	elif operator == "/":
		operator_said = "divido por"
	elif operator == "-":
		operator_said = "menos"
	elif operator == "+":
		operator_said = "mais"
		
	var conta = str(num1) + " " + operator_said + " " + str(num2) + " = a"
	
	if(input_result.value <=20):
		$peso_direita.play("moeda_{num_2}".format({"num_2": str(input_result.value)}))
	else:
		$peso_direita.play("moeda_20")
	$".".play("balancando")
	
	$Button.disabled = true
	await wait(2.0)
	var player_answer = input_result.value
	if player_answer == correct_answer:
		$".".play("equilibrio")
		await wait(1.0)
		$"../correctSound".play()
		$"../RibbonBlue3Slides".set_visible(true)	
		await wait(1.5)
		speak_text("Correto!")
		$"../RibbonBlue3Slides".set_visible(false)
		await wait(1.0)
	elif player_answer > correct_answer:
		$".".play("pesado_direita")
		await wait(1.0)
		$"../wrongSound".play()
		$"../RibbonRed3Slides".set_visible(true)
		$"../RibbonRed3Slides/Label".text = "Errado!\n" + str(num1) + " " + operator + " " + str(num2) + " = "+ str(correct_answer)
		await wait(3.0)
		speak_text("Errado!" + conta+str(correct_answer))
		$"../RibbonRed3Slides".set_visible(false)
		await wait(5.0)		
	else:
		$".".play("pesado_esquerda")
		await wait(1.0)
		$"../wrongSound".play()
		$"../RibbonRed3Slides".set_visible(true)
		$"../RibbonRed3Slides/Label".text = "Errado!\n" + str(num1) + " " + operator + " " + str(num2) + " = "+ str(correct_answer)
		await wait(3.0)
		speak_text("Errado!" + conta+str(correct_answer))
		$"../RibbonRed3Slides".set_visible(false)
		await wait(5.0)
	generate_equation()	

func _input(event: InputEvent):
		if event is InputEventKey and (event.keycode == KEY_ENTER or event.keycode == KEY_KP_ENTER) and event.pressed:
			_on_button_pressed()

func _on_spin_box_value_changed(value):
	speak_text(str($SpinBox.value))
	$Button.disabled = false

func speak_text(text: String):
	DisplayServer.tts_stop()
	var voices = DisplayServer.tts_get_voices_for_language("pt")
	var voice_id = voices[Global.selected_voice_id]

	DisplayServer.tts_speak(text, voice_id, AudioController.volume, 1.0, 0.8)
