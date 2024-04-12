extends Panel

@onready var toast_text = $ToastText
@onready var timer : Timer = $ToastTimer
# Called when the node enters the scene tree for the first time.
func _ready():
	#self.visible = false
	toast_text.clear()
	toast_text.bbcode_enabled = true
	process_mode = Node.PROCESS_MODE_ALWAYS
	Global.open_toast.connect(handle_toast_opening)


func handle_toast_opening(text):
	text = "[center]" + text
	self.visible = true
	
	toast_text.clear()
	toast_text.append_text(text)
	timer.start()
	


func _on_toast_timer_timeout():
	toast_text.clear()
	self.visible = false
