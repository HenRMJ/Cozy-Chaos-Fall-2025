extends CanvasLayer
class_name HUD

@export var hearth_container:HBoxContainer
@export var empty_hearth_container:HBoxContainer


var hear_res:PackedScene = load("res://scenes/ui/ingame hud/hearth_full.tscn")
var empty_hear_res:PackedScene = load("res://scenes/ui/ingame hud/hearth_empty.tscn")

func _ready() -> void:
	$MarginContainer/CenterContainer/Label.text = "Level - " + str(GameManager.current_level) + "/4"
	$Timer.start()

func init() -> void:
	for x in range(Globals.max_player_health):
		add_heart()

func on_player_leaf_collision() -> void:
	pass

func on_player_health_changed(change:int) -> void:
	if change > 0:
		add_heart()
	else:
		remove_hearth()

func on_player_leaf_changed(_value:int) -> void:
	$Control/MarginContainer2/HBoxContainer/Label.text = str(GameManager.player.leaf) + "/" + str(Globals.max_leaf_count)
	
	if GameManager.player.leaf == Globals.max_leaf_count:
		GameManager.next_level()

func add_heart() -> void:
	if empty_hearth_container.get_child_count() > 0:
		empty_hearth_container.get_child(0).queue_free()
		
	hearth_container.add_child(hear_res.instantiate())
	
func remove_hearth() -> void:
	if hearth_container.get_child_count() > 0:
		hearth_container.get_child(0).queue_free()
	empty_hearth_container.add_child(empty_hear_res.instantiate())

func on_player_death() -> void:
	hide()


func _on_timer_timeout() -> void:
	$MarginContainer/CenterContainer/Label.hide()
