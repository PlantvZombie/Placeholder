extends Node
class_name variables
#Item Variables
var itemname:Array
var itemlevel:Array
var Item:Array
signal LevelUp
var leveled:bool = false
var maxplayerhp = 100
var playerhealth = 100
var neededexp = 1000
var exp = 0

func _ready() -> void:
	connect("LevelUp", Level)
	itemname = ["Baton", "Taser", "Drones", "Simulated Arm", "Firewall", "Drank"]
	for i in itemname.size():
		itemlevel.append(0)
	itemlevel[0] = 1
	itemlevel[1]= 1
	for i in itemname.size():
		Item.append(0)
	for i in itemname.size():
		Item[i] = itemname[i] + str(itemlevel[i])

func _process(_delta: float) -> void:
	if leveled:
		LevelUp.emit()
		

func Level():
	await get_tree().create_timer(1).timeout
	for i in itemname.size():
		Item[i] = itemname[i] + str(itemlevel[i])
