extends Control

@onready var label = $texto_1/Label
@onready var label2 = $texto_2/Label
@onready var label3 = $texto_3/Label
@onready var label4 = $texto_4/Label
@onready var piglet_1 = $"../../SceneObjects/Characters/piglet1"
@onready var piglet_2 = $"../../SceneObjects/Characters/piglet2"

var number1 = [40,55,47,33,52]
var number2 = [3, 3, 2, 4, 4]
var number3 = [10,19,21,13,8]
var v = AutoloadScene.random_number

var result = (number1[v] - number3[v])/number2[v]  #10, 12, 13, 5, 11

func _ready():
	label.text =  "Você poderia me ajudar?\nEu tenho " + str(number1[v]) + " cenouras e gostaria de alimentar meus filhos." 
	label.autowrap_mode = 2
	label.label_settings = LabelSettings.new()
	label.label_settings.font_size = 24
	label.label_settings.outline_size = 3
	
	label2.text =  "Meus " + str(number2[v]) +  " filhos comem  a mesma quantidade de cenouras!"
	label2.autowrap_mode = 2
	label2.label_settings = LabelSettings.new()
	label2.label_settings.font_size = 24
	label2.label_settings.outline_size = 3
	
	label3.text ="Depois de alimentar os  meus porquinhos, ainda precisa sobrar " + str(number3[v]) + " cenouras."
	label3.autowrap_mode = 2
	label3.label_settings = LabelSettings.new()
	label3.label_settings.font_size = 24
	label3.label_settings.outline_size = 3
	
	label4.text ="Quantas cenouras cada porquinho deverá comer?"
	label4.autowrap_mode = 2
	label4.label_settings = LabelSettings.new()
	label4.label_settings.font_size = 24
	label4.label_settings.outline_size = 3
	
	if number2[v] == 2:
		piglet_1.hide()
		piglet_2.hide()
		
	if number2[v] == 3:
		piglet_2.hide()
