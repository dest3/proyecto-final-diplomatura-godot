extends Node

@onready var game_state_manager: Node = $"../GameStateManager"


func _ready() -> void:
	var spawner_obstaculos = get_children() as Array[LineaObstaculo]
	
	for linea in spawner_obstaculos:
		linea.jugador_golpeado.connect(on_jugador_colisiona)

func on_jugador_colisiona():
	print("{on_jugador_colisiona}")
	game_state_manager.matar_jugador
