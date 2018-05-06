extends Sprite

const SPEED = 400
const EASING = 20

var velocity = Vector2()
var health = 100
# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var color = 1
var colors = ["Yellow", "Blue", "Red"]

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	velocity = Vector2()
	health = 100
	$PlayerArea2D.connect("area_entered", self, "hit")
	set_process_input(true)
	set_process(true)
	pass

func _input(event):
	if event.is_action_pressed("left_click"):
		#do thing
		print("left click")
		_cycle_color("forward")
	elif event.is_action_pressed("right_click"):
		print("right click")
		_cycle_color("backwards")
	pass

func _cycle_color(direction):
	if direction == "forward":
		if color == 2:
			color = 0
		else:
			color += 1
	elif direction == "backwards":
		if color == 0:
			color = 2
		else: 
			color -= 1
	
	_change_sprite()
	
func _change_sprite():
	var c = get_color()
	if c == "Yellow":
		set_texture(load("res://Unhappy.png"))
	elif c == "Red":
		set_texture(load("res://Angry.png"))
	elif c == "Blue":
		set_texture(load("res://Happy.png"))
	else:
		print("something went wrong with player color")

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	if health <= 0:
		#popup =
		print("dead - end game") 
	pass

func _accelerate_and_clamp(is_x, boundary):
	if(is_x):
		if(boundary > velocity.x):
			velocity.x += EASING
			if(velocity.x > boundary):
				velocity.x = boundary
		else:
			velocity.x -= EASING
			if(velocity.x < boundary):
				velocity.x = boundary
	else:
		if(boundary > velocity.y):
			velocity.y += EASING
			if(velocity.y > boundary):
				velocity.y = boundary
		else:
			velocity.y -= EASING
			if(velocity.y < boundary):
				velocity.y = boundary

func _physics_process(delta):

	if Input.is_action_pressed("ui_left"):
		_accelerate_and_clamp(true, -SPEED)
	elif Input.is_action_pressed("ui_right"):
		_accelerate_and_clamp(true, SPEED)
	else:
		_accelerate_and_clamp(true, 0)

	if Input.is_action_pressed("ui_up"):
		_accelerate_and_clamp(false, -SPEED)
	elif Input.is_action_pressed("ui_down"):
		_accelerate_and_clamp(false, SPEED)
	else:
		_accelerate_and_clamp(false, 0)

	move_local_x(delta*velocity.x)
	move_local_y(delta*velocity.y)
	
func hit(hit_object):
	print(hit_object.get_name())
	if hit_object.get_name() == "BulletArea2D":
		if hit_object.get_parent().get_color() != get_color():
			health -= hit_object.get_parent().power
			print(health)
		
		
func get_color():
	return self.colors[self.color]