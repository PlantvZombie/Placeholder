extends CanvasLayer

@onready var LevelBar = $"UI/Mbox/VBoxContainer/LevelM/exp bar"
@onready var HealthBar = $UI/Mbox/VBoxContainer/HealthM/Health
@onready var Level = get_node("UI/Mbox/VBoxContainer/LevelM/exp bar/LevelText")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LevelBar.set_max(Global.neededexp) 
	HealthBar.set_max(Global.maxplayerhp) 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	LevelBar.set_value(Global.exp)
	HealthBar.set_value(Global.playerhealth)
	Level.set_text("Level: " + str(Global.level))
