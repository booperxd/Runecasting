class_name FightRoomManager

extends Node

@export var func_godot_properties : Dictionary

@export var room_name : String
@export var total_cost : int
@export var max_points_out : int
@export var enemies : Array[PackedScene]
@export var spawn_points : Array[Node3D]
@export var spawn_delay : float = 1.4

var points_left
var current_points_out = 0
var active : bool
var completed : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	points_left = total_cost
	
	room_name = func_godot_properties["room_name"]
	
	Global.enter_fight_room.connect(_on_room_entered)
	Global.enemy_beat_in_room.connect(_on_enemy_defeated)

func _physics_process(delta):
	if not active or completed:
		return
	if points_left <= 0 and current_points_out <= 0:
		Global.beat_fight_room.emit(room_name)
		active = false
		completed = true

func _on_room_entered(_room_name):
	if room_name != _room_name or completed or active:
		return
	start_fight()
	
func _on_enemy_defeated():
	if not active:
		return
	
	current_points_out-=1	

func start_fight():
	Global.fight_room_started.emit(room_name)
	await get_tree().create_timer(spawn_delay).timeout
	for point in spawn_points:
		spawn_enemy(point)
	active=true

func spawn_enemy(point : SpawnPoint):
	if points_left <= 0 || current_points_out >= max_points_out:
		return
	var enemy = enemies.pick_random()
	point.spawn_being(enemy)
	current_points_out+=1
	points_left-=1
