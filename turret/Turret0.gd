extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var state = 0
var WIDTH = ProjectSettings.get_setting("display/window/size/width")
var HEIGHT = ProjectSettings.get_setting("display/window/size/height")
const PADDING = 100
const SPEED = 200
var color = 0
var colors = ["Yellow", "Blue", "Red"]

func init(x, y, state, color):
	position = Vector2(x,y)
	self.state = state
	self.color = color
	_change_sprite();
	
func _change_sprite():
	var c = get_color()
	if c == "Yellow":
		$Turret0Sprite0.set_texture(load("res://Unhappy.png"))
	elif c == "Red":
		$Turret0Sprite0.set_texture(load("res://Angry.png"))
	elif c == "Blue":
		$Turret0Sprite0.set_texture(load("res://Happy.png"))
	else:
		print("something went wrong with player color")
	

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	#state = 0
	#position = Vector2(PADDING,PADDING)
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
		#print(hit_object.get_parent().get_color())
		if get_color() != hit_object.get_parent().get_color():
			call_deferred("queue_free")

func get_color():
	return self.colors[self.color]