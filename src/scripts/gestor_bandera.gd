extends Node

class_name Bandera_manager

signal todas_las_banderas_capturadas
signal bandera_tomada

var contador_bandera = 0
var bandera_capturada = 0


func _ready() -> void:
	var banderas = get_children() as Array[Bandera]
	contador_bandera = banderas.size()
	
	for bandera in banderas:
		bandera.capturo_bandera.connect(on_jugador_capturo_bandera)


func on_jugador_capturo_bandera():
	print("{on_jugador_entro_casa}")
	bandera_capturada += 1 
	bandera_tomada.emit()
	
	if bandera_capturada == contador_bandera:
		print("[BANDERAS KAPTURADAS]")
		todas_las_banderas_capturadas.emit()
		
