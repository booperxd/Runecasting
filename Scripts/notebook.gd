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

var learned_spells : LearnedSpells
var chapters : Array
var current_spells : Array

var select_chapter : String
var page : int

var left_content : Spell
var right_content : Spell

func _ready():
	await(owner.ready)
	process_mode = Node.PROCESS_MODE_ALWAYS
	learned_spells = Global.player.player_spells
	left_parent.visible = false
	
	for category in Spell.SpellCategory:
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

func set_left_content(spell : Spell):
	left_title.text = spell.spell_name
	left_pattern.text =  str(spell.pattern)
	left_desc.text = spell.description
	
func set_right_content(spell : Spell):
	right_title.text = spell.spell_name
	right_pattern.text =  str(spell.pattern)
	right_desc.text = spell.description


func clear_right_content():
	right_title.text = ''
	right_pattern.text = ''
	right_desc.text = ''
	

func on_chapter_select(chapter : String):
	current_spells.clear()
	select_chapter = chapter
	for spell in learned_spells.spells:
		if chapter == Spell.SpellCategory.keys()[spell.category]:
			current_spells.append(spell)
	left_content = current_spells[0]
	if current_spells.size() != 1:
		right_content = current_spells[1]
	page = 1
	set_left_content(left_content)
	if current_spells.size() != 1:
		set_right_content(right_content)
	left_parent.visible = true
	chapter_parent.visible = false

func _on_back_pressed():
	if page == 1:
		return
	page -= 2
	left_content = current_spells[page - 1]
	set_left_content(left_content)
	if (page < current_spells.size()):
		right_content = current_spells[page]
		set_right_content(right_content)
	else:
		clear_right_content()


func _on_next_pressed():
	if (page + 1 >= current_spells.size()):
		return
	page += 2
	left_content = current_spells[page - 1]
	set_left_content(left_content)
	if (page < current_spells.size()):
		right_content = current_spells[page]
		set_right_content(right_content)
	else:
		clear_right_content()
	
	


func _on_return_button_pressed():
	select_chapter = ''
	chapter_parent.visible = true
	left_parent.visible=false
	clear_right_content()
	
