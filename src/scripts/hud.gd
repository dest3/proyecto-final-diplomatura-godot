extends CanvasLayer

class_name Hud

@onready var vidas: VBoxContainer = %vidas
@onready var center_container: CenterContainer = $MarginContainer/CenterContainer
@onready var panel_container: PanelContainer = $MarginContainer/CenterContainer/PanelContainer
@onready var resultado: Label = %resultado


var textura_vida = preload("res://icon.svg")
var texturas_vidas: Array[TextureRect] = []


func crear_vidas(cantidad_vidas: int):
	for i in cantidad_vidas:
		var texture_rect = TextureRect.new()
		texture_rect.custom_minimum_size = Vector2(16, 16)
		texture_rect.texture = textura_vida
		texture_rect.texture_filter = TextureRect.TEXTURE_FILTER_NEAREST
		vidas.add_child(texture_rect)
		texturas_vidas.append(texture_rect)


func mostrar_perder():
	resultado.text = "PERDISTE!"
	panel_container.theme_type_variation = "PanelContainerRojo"
	center_container.show()

func mostrar_ganar():
	resultado.text = "GNASTE!"
	panel_container.theme_type_variation = "PanelContainer"
	center_container.show()


func perder_vidas():
	var _textura_vida = texturas_vidas.pop_back()
	_textura_vida.queue_free()


func _on_button_pressed() -> void:
	get_tree().reload_current_scene()
