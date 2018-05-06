extends Sprite

const SPEED = 400
const EASING = 20

var velocity = Vector2()
var health = 100
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	velocity = Vector2()
	health = 100
	$PlayerArea2D.connect("area_entered", self, "hit")
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

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
		health -= hit_object.get_parent().power
		print(health)