extends Area2D

class_name Jugador

signal vida_perdida
signal game_over

const INCREMENTO_POSICION = 32
const POSICION_INICIAL_JUGADOR = Vector2(288.0, 384.0)

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var timer: Timer = $Timer


@export var velocidad = 40
@export var vidas = 3

var nueva_posicion: Vector2 = Vector2.ZERO


func _ready() -> void:
	timer.timeout.connect(on_timer_timeout)


func on_timer_timeout():
	print("[PERDIO VIDA]")
	vidas -= 1
	vida_perdida.emit()
	print("Vidas restantes = [", vidas, "]")
	
	if vidas == 0:
		print("[GAME_OVER]")
		set_process_input(false)
		game_over.emit()
	else:
		resetear_jugador()


func _process(delta: float) -> void:
	if nueva_posicion == Vector2.ZERO:
		return
	position = lerp(position, nueva_posicion, velocidad * delta)
	
	if position.distance_to(nueva_posicion) < 0.1:
		position = nueva_posicion
		nueva_posicion = Vector2.ZERO
		animated_sprite_2d.play("idle")


func _input(event: InputEvent) -> void:
	if nueva_posicion != Vector2.ZERO:
		return
	
	var posicion_modificada
	
	if event.is_action_pressed("up"):
		posicion_modificada = position + Vector2.UP * INCREMENTO_POSICION
		animated_sprite_2d.play("moving")
	elif event.is_action_pressed("down"):
		posicion_modificada = position + Vector2.DOWN * INCREMENTO_POSICION
		animated_sprite_2d.play("moving")
	elif event.is_action_pressed("right"):
		posicion_modificada = position + Vector2.RIGHT * INCREMENTO_POSICION
		animated_sprite_2d.set_flip_h(false)
		animated_sprite_2d.play("moving")
	elif event.is_action_pressed("left"):
		animated_sprite_2d.set_flip_h(true)
		posicion_modificada = position + Vector2.LEFT * INCREMENTO_POSICION
		animated_sprite_2d.play("moving")
	
	if posicion_modificada:
		mover_jugador(posicion_modificada)


func mover_jugador(posicion_modificada: Vector2) -> void:
	var tile_offset = 8
	var viewport_size = get_viewport_rect().size
	
	var min_x = tile_offset
	var max_x = viewport_size.x - tile_offset
	var min_y = tile_offset
	var max_y = viewport_size.y - tile_offset
	
	var posicion_clampeada = Vector2(
		clamp(posicion_modificada.x, min_x, max_x),
		clamp(posicion_modificada.y, min_y, max_y)
	)
	
	nueva_posicion = posicion_clampeada


func muere():
	collision_shape_2d.set_deferred("disabled", false)
	animated_sprite_2d.self_modulate = Color(1,1,1)
	animated_sprite_2d.play("hit")
	set_process_input(false)
	timer.start()


func resetear_jugador():
	set_process_input(true)
	collision_shape_2d.set_deferred("disabled", false)
	animated_sprite_2d.self_modulate = Color(1,1,1)
	animated_sprite_2d.play("idle")
	global_position = POSICION_INICIAL_JUGADOR
	nueva_posicion = POSICION_INICIAL_JUGADOR
