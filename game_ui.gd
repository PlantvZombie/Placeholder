extends Control

@onready var LevelBar = $"UI/Mbox/VBoxContainer/LevelM/exp bar"
@onready var HealthBar = $UI/Mbox/VBoxContainer/HealthM/Health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LevelBar.max_value = Global.neededexp
	HealthBar.max_value = Global.maxplayerhp


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	LevelBar.value = Global.exp
	HealthBar.value = Global.playerhealth
