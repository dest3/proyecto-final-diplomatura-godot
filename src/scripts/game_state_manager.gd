extends Node

@onready var jugdor: Jugador = $"../jugdor"
@onready var gestor_bandera: Bandera_manager = $"../gestor_bandera"
@onready var hud: Hud = $"../hud"


func _ready() -> void:
	gestor_bandera.todas_las_banderas_capturadas.connect(on_todas_las_banderas_capturadas)
	gestor_bandera.bandera_tomada.connect(on_bandera_capturada)
	jugdor.vida_perdida.connect(on_vida_perdida)
	jugdor.game_over.connect(on_game_over)
	hud.crear_vidas(jugdor.vidas)


func on_todas_las_banderas_capturadas():
	print("[GANASTE EL JUEGO!!!]")
	jugdor.set_process_input(false)
	jugdor.animated_sprite_2d.self_modulate = Color(0, 1, 0)
	hud.mostrar_ganar()


func on_bandera_capturada():
	print("{on_casa_ocupa}")
	jugdor.resetear_jugador()

func on_vida_perdida():
	hud.perder_vidas()

func on_game_over():
	hud.mostrar_perder()


func matar_jugador():
	print("[C MURIO EL JUGADOR]")
	jugdor.muere()
