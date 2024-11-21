extends Control

@onready var label = $texto_1/Label
@onready var label2 = $texto_2/Label
@onready var label3 = $texto_3/Label
@onready var label4 = $texto_4/Label
@onready var character_body_2d_3 = $"../../SceneObjects/Characters/CharacterBody2D3"

var number1 = [33,38,54,46,52]
var number2 = [12, 11, 6, 8, 9]

var v = AutoloadScene.random_number

var result = (2*number2[v] + number1[v])*2  #114 120 132 124 140

func _ready():
	label.text =  "Olá viajante!\nSomos um grupo de raposas e gostariamos de saber quanto precisamos andar para atravessar a floresta. Consegue nos ajudar?" 
	label.autowrap_mode = 2
	label.label_settings = LabelSettings.new()
	label.label_settings.font_size = 24
	label.label_settings.outline_size = 3
	
	label2.text =  "Eu sei que somando "  + str(number1[v]) + " com a distância até aquela árvore gigante resulta na metade do caminho para atravessar a floresta."
	label2.autowrap_mode = 2
	label2.label_settings = LabelSettings.new()
	label2.label_settings.font_size = 24
	label2.label_settings.outline_size = 3
	
	label3.text = "A distância até a árvore gigante é o dobro de " + str(number2[v]) + "."
	label3.autowrap_mode = 2
	label3.label_settings = LabelSettings.new()
	label3.label_settings.font_size = 24
	label3.label_settings.outline_size = 3
	
	label4.text ="Qual a distância para atravessar a floresta?"
	label4.autowrap_mode = 2
	label4.label_settings = LabelSettings.new()
	label4.label_settings.font_size = 24
	label4.label_settings.outline_size = 3
