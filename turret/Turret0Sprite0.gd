extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const RADIUS = 100
const ANG_VEL = 5
var angle = 0
const TIME = 4
var time = TIME
var bullet_resource = load("res://bullet/Bullet0.tscn")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	time = TIME
	angle = 0
	pass

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	time -= 1
	if time == 0:
		time = TIME
		var bullet = bullet_resource.instance()
		bullet.set_color(get_parent().color)
		bullet.init_origin(global_position)
		bullet.init_pos(Vector2(1,0).angle_to_point(position),0)
		bullet.init_vel(0, -5)
		bullet.set_power(35)
		get_parent().get_parent().add_child(bullet)
		
	angle = fmod(angle+ANG_VEL*delta, 2*PI)
	position.x = cos(angle)*RADIUS
	position.y = sin(angle)*RADIUS
	pass
