extends CharacterBody2D



var player_health = GlobalVars.player_health
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


# Calls when scene is loaded
func _enter_tree():
	enter_level()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


# Sets player position to the selected entry point of the level
func enter_level():
	var entry_pos = Vector2(100, 100)
	var entry_id = GlobalVars.entry_point
	var exits = []
	var exits_node = get_parent().get_node("Exits")
	exits = exits_node.get_children()
	entry_pos = exits[entry_id].get_node("SpawnPoint").global_position
	self.position = entry_pos
