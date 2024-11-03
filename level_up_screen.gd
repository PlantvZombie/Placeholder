extends CanvasLayer

@onready var Items:Array = ["Baton", "Taser", "Drones", "Simulated Arm", "Firewall", "Drank"]
var rng = RandomNumberGenerator.new()
var opt:Array = [0, 0, 0]



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.levelup:
		Leveled()
		Global.levelup = false

func Leveled():
	for i in opt.size():
		rng.randomize()
		opt[i] = Items[rng.randi_range(0, Items.size()-1)]
		Items.remove_at(Items.find(opt[i]))
	get_node("Panel/PanelGap/Components/Options/Option1").set_text(opt[0])
	get_node("Panel/PanelGap/Components/Options/Option2").set_text(opt[1])
	get_node("Panel/PanelGap/Components/Options/Option3").set_text(opt[2])
	self.set_visible(true)


func _on_option_1_pressed() -> void:
	Global.itemlevel[Global.itemname.find(opt[0])] += 1
	Global.leveled = true
	self.set_visible(false)


func _on_option_2_pressed() -> void:
	Global.itemlevel[Global.itemname.find(opt[1])] += 1
	Global.leveled = true
	self.set_visible(false)


func _on_option_3_pressed() -> void:
	Global.itemlevel[Global.itemname.find(opt[2])] += 1
	Global.leveled = true
	self.set_visible(false)
