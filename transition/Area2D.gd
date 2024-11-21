extends Area2D

# Variável que conterá as cores disponíveis
var colors: Array[Color] = []
# Índice da cor atual
var current_color_index: int = 0

# Função de inicialização
func _ready():
	# Gera uma lista de cores aleatórias de tamanho variável (entre 3 e 10, por exemplo)
	var num_colors = randi_range(3, 10)
	for _i in range(num_colors):
		colors.append(Color(randf(), randf(), randf()))  # Adiciona uma cor aleatória
	# Define a cor inicial
	update_color()

# Detecta as teclas pressionadas para a mudança de cor
func _process(delta):
	if Input.is_action_just_pressed("ui_right"):
		current_color_index = (current_color_index + 1) % colors.size()  # Vai para a próxima cor
		update_color()
	elif Input.is_action_just_pressed("ui_left"):
		current_color_index = (current_color_index - 1) % colors.size()  # Vai para a cor anterior
		update_color()

# Atualiza a cor do círculo
func update_color():
	$ColorRect.color = colors[current_color_index]  # Define a cor no ColorRect
