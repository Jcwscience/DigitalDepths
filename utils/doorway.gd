extends Node2D

@export var new_entry_point_id : int = 0
@export var self_entry_point_id : int = 0
@export var entry_level = "res://levels/level_1.tscn"

var in_exit : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if in_exit and Input.is_action_just_pressed("up"):
		GlobalVars.entry_point = new_entry_point_id
		print(str(GlobalVars.entry_point))
		get_tree().change_scene_to_file(entry_level)


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		in_exit = true



func _on_area_2d_body_exited(body):
	if body.name == "Player":
		in_exit = false
