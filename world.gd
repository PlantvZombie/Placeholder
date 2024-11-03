extends Node2D

@export_category("Enemy Scenes")
@export var PlayerPath = preload("res://player.tscn")
@export var CitizenPath = preload("res://citizen.tscn")
@export var SoldierMeleePath = preload("res://soldier.tscn")
@export var SoldierRangedPath = preload("res://soldier_range.tscn")
@onready var Player:Node2D = $Player
@onready var Citizen:Node2D = $Citizen
@onready var SoldierMelee:Node2D = $SoldierMelee
@onready var SoldierRanged:Node2D = $SoldierRange2
@export var marker:Marker2D
@export_category("Wave Properties")
@export var waveOneCount = 10
@export var perSecond = 1.0
@export var amount = 1
@export_subgroup("Extra Properties")
@export var spawnTimer:Timer


var spawnEnemies = true
var spawnLocation
var enemyPerWave

func _ready() -> void:
	get_node("Inventory2").set_visible(false)

func _process(_delta: float) -> void:
	################################################################################################
	#                                      Spawner                                                 #
	################################################################################################
	
	if Input.is_action_just_pressed("test"):
			var instance = CitizenPath.instantiate()
			instance.position = Player.position
			add_child(instance)
	
	
	################################################################################################
	#                                      Input                                                   #
	################################################################################################
	
	if Input.is_action_just_pressed("esc") and get_node("Inventory2").is_visible() == false:
		get_node("Inventory2").set_visible(true)
	elif Input.is_action_just_pressed("esc"):
		get_node("Inventory2").set_visible(false)
	get_node("Inventory2").position = get_node("Player").position
