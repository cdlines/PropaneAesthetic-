extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var state = 0
var WIDTH = ProjectSettings.get_setting("display/window/size/width")
var HEIGHT = ProjectSettings.get_setting("display/window/size/height")
const PADDING = 100
const SPEED = 200

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	state = 0
	position = Vector2(PADDING,PADDING)
	$Turret0Sprite0/Turret0Area2D.connect("area_entered", self, "hit")
	pass

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	if state == 0:
		move_local_y(SPEED * delta)
		if position.y > HEIGHT-PADDING:
			position.y = HEIGHT-PADDING
			state = 1
	elif state == 1:
		move_local_x(SPEED * delta)
		if position.x > WIDTH-PADDING:
			position.x = WIDTH-PADDING
			state = 2
	elif state == 2:
		move_local_y(-SPEED * delta)
		if position.y < PADDING:
			position.y = PADDING
			state = 3
	elif state == 3:
		move_local_x(-SPEED * delta)
		if position.x < PADDING:
			position.x = PADDING
			state = 0
	pass
	
func hit(hit_object):
	if hit_object.get_name() == "PlayerArea2D":
		call_deferred("queue_free")
