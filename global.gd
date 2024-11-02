extends Node
class_name variables
#Item Variables
var itemname:Array
var itemlevel:Array
var Item:Array
#Game
var maxplayerhp = 100
var playerhealth = 70
var neededexp = 1000
var exp = 145

func _ready() -> void:
	var maxplayerhp = 100
	var playerhealth = 70
	var neededexp = 1000
	var exp = 145
	itemname = ["Baton", "Taser"]
	for i in itemname.size():
		itemlevel.append(0)
	itemlevel[0] = 1
	itemlevel[1]= 1
	for i in itemname.size():
		Item.append(0)

func _process(_delta: float) -> void:
	for i in itemname.size():
		Item[i] = itemname[i] + str(itemlevel[i])
