extends Node2D

class_name LineaObstaculo

signal jugador_golpeado

@onready var escena_obstaculo:PackedScene = preload("res://src/escenas/obstaculo.tscn")

@export var contador_obstaculos = 3
@export var distancia_entre_obstaculos = 128
@export var velocidad = 200
@export var limite_movimiento_y = 304

var obstaculos = []


func _ready() -> void:
	for i in contador_obstaculos:
		var obstaculo = escena_obstaculo.instantiate()
		obstaculo.position = Vector2(0, -limite_movimiento_y + distancia_entre_obstaculos * i)
		obstaculo.area_entered.connect(on_jugador_entra_obstaculo)
		add_child(obstaculo)
		obstaculos.append(obstaculo)


func _process(delta: float) -> void:
	for obstaculo in obstaculos:
		var nueva_posicion_y = velocidad * delta + obstaculo.position.y
		if abs(nueva_posicion_y - limite_movimiento_y) < 10:
			obstaculo.position.y = -limite_movimiento_y
		else:
			obstaculo.position.y = nueva_posicion_y


func on_jugador_entra_obstaculo(area: Area2D):
	if area is Jugador:
		print("[JUGADOR GOLPEADO]")
		jugador_golpeado.emit()
