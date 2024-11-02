extends Node

var itemname:Array
var itemlevel:Array
var Item:Array

func _ready() -> void:
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
