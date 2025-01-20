extends Sprite3D


func _ready():
	Global.notebook_saved.connect(_on_notebook_saved)


func _on_notebook_saved(_texture : ViewportTexture):
	texture = _texture
	#image.save_png("res://Material/test.jpg")
