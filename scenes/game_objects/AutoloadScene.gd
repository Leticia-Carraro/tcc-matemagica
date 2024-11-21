extends Node

var previous_scene
var random_number = randi_range(0,4)

func _random(number):
	while random_number == number:
		random_number = randi_range(0,4)
