extends Node2D

@export_category("Enemy Scenes")
@export var Player:PackedScene
@export var Citizen2:PackedScene
@export var SoldierMelee:PackedScene
@export var SoldierRanged:PackedScene

@export_category("Wave Properties")
@export var waveOneCount = 10

@export_subgroup("Extra Properties")
@export var waveTimer:Timer

func _ready() -> void:
	get_node("Inventory2").set_visible(false)

func _process(_delta: float) -> void:
	################################################################################################
	#                                      Spawner                                                 #
	################################################################################################
	
	
	
	################################################################################################
	#                                      Input                                                   #
	################################################################################################
	
	if Input.is_action_just_pressed("esc") and get_node("Inventory2").is_visible() == false:
		get_node("Inventory2").set_visible(true)
	elif Input.is_action_just_pressed("esc"):
		get_node("Inventory2").set_visible(false)
	get_node("Inventory2").position = get_node("Player").position
