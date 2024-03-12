extends Control

@onready var chapter_parent = $ParentContainer/HBoxContainer/ChapterPage
@onready var chapter_container = $ParentContainer/HBoxContainer/ChapterPage/PageContainer
@onready var left_parent = $ParentContainer/HBoxContainer/LeftPage

@onready var left_title = $ParentContainer/HBoxContainer/LeftPage/PageContainer/Title
@onready var left_pattern = $ParentContainer/HBoxContainer/LeftPage/PageContainer/Pattern
@onready var left_desc = $ParentContainer/HBoxContainer/LeftPage/PageContainer/Description

@onready var right_title = $ParentContainer/HBoxContainer/RightPage/PageContainer/Title
@onready var right_pattern = $ParentContainer/HBoxContainer/RightPage/PageContainer/Pattern
@onready var right_desc = $ParentContainer/HBoxContainer/RightPage/PageContainer/Description

@onready var return_button = $ParentContainer/ReturnButton

var spell_data
var chapters : Array
var current_spells : Dictionary

var select_chapter : String

var left_content : Dictionary
var right_content : Dictionary

func _ready():
	var f = FileAccess.open("res://Scripts/Spells/spell_info.json", FileAccess.READ)
	var content = f.get_as_text()
	var json = JSON.new()
	spell_data = json.parse_string(content)
	left_parent.visible = false
	for category in spell_data:
		chapters.append(category)
		var chapter_button = Button.new()
		chapter_button.text = category
		chapter_button.pressed.connect(on_chapter_select.bind(chapter_button.text) )
		chapter_container.add_child(chapter_button)
		#for spell in spell_data[category]:
		#	all_spells[spell] = (spell_data[category][spell])
	#left_content = all_spells[all_spells.keys()[0]]
	#right_content = all_spells[all_spells.keys()[1]]
	#set_left_content(left_content)
	#set_right_content(right_content)

func set_left_content(spell : Dictionary):
	if spell.has("script_name"):
		left_title.text = spell["script_name"]
	if spell.has("pattern"):
		left_pattern.text =  str(spell["pattern"])
	if spell.has("spell_desc"):
		left_desc.text = spell["spell_desc"]
	
func set_right_content(spell : Dictionary):
	if spell.has("script_name"):
		right_title.text = spell["script_name"]
	if spell.has("pattern"):
		right_pattern.text =  str(spell["pattern"])
	if spell.has("spell_desc"):
		right_desc.text = spell["spell_desc"]

func clear_right_content():
	right_title.text = ''
	right_pattern.text = ''
	right_desc.text = ''
	

func on_chapter_select(chapter : String):
	current_spells.clear()
	select_chapter = chapter
	for spell in spell_data[chapter]:
			current_spells[spell] = (spell_data[chapter][spell])
	left_content = current_spells[current_spells.keys()[0]]
	right_content = current_spells[current_spells.keys()[1]]
	set_left_content(left_content)
	set_right_content(right_content)
	left_parent.visible = true
	chapter_parent.visible = false

func _on_back_pressed():
	pass # Replace with function body.


func _on_next_pressed():
	pass # Replace with function body.


func _on_return_button_pressed():
	select_chapter = ''
	chapter_parent.visible = true
	left_parent.visible=false
	clear_right_content()
	
