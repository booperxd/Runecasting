extends Panel

@onready var toast_text = $ToastText
# Called when the node enters the scene tree for the first time.
func _ready():
	#self.visible = false
	toast_text.clear()
	toast_text.bbcode_enabled = true
	Global.open_toast.connect(handle_toast_opening)


func handle_toast_opening(text):
	text = "[center]" + text
	self.visible = true
	
	toast_text.clear()
	toast_text.append_text(text)
	await Global.current_scene.root.get_tree().create_timer(4).timeout
	toast_text.clear()
	self.visible = false
