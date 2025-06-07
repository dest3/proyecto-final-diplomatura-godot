extends Area2D

class_name Bandera

signal capturo_bandera

@onready var obtenido: Sprite2D = $obtenido
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


func _on_area_entered(area: Area2D) -> void:
	if area is Jugador:
		capturo_bandera.emit()
		obtenido.show()
		collision_shape_2d.set_deferred("disabled", true)
