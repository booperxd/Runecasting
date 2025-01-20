class_name DrawingNotebook

extends Control

@onready var canvas : NotebookCanvas = $CanvasViewport/SubViewport/Node

func get_canvas_viewport() -> ViewportTexture:
	var text : Texture = canvas.viewport.get_texture()
	return text
