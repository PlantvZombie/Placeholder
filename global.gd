extends Node

var itemname:Array
var itemlevel:Array
var Item:Array
signal LevelUp
var leveled:bool = false

func _ready() -> void:
	connect("LevelUp", Level)
	itemname = ["Baton", "Taser", "Drones", "Simulated Arm", "Firewall"]
	for i in itemname.size():
		itemlevel.append(0)
	itemlevel[0] = 1
	itemlevel[1]= 1
	for i in itemname.size():
		Item.append(0)

func _process(_delta: float) -> void:
	if leveled:
		LevelUp.emit()
		

func Level():
	await get_tree().create_timer(1).timeout
	for i in itemname.size():
		Item[i] = itemname[i] + str(itemlevel[i])
