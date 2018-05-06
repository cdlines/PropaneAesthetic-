extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var a_vel = 0
var r_vel = 0
var radius = 0
var angle = 0
var origin = Vector2()
var power = 0

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	$BulletArea2D.connect("area_entered", self, "hit")
	pass

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	angle = fmod(angle + a_vel*delta, 2*PI)
	radius += r_vel
	global_position.x = origin.x + cos(angle)*radius
	global_position.y = origin.y + sin(angle)*radius
	pass

func init_pos(a, r):
	angle = a
	radius = r

func init_vel(a, r):
	a_vel = a
	r_vel = r
	
func init_origin(vector):
	origin.x = vector.x
	origin.y = vector.y
	global_position.x = origin.x
	global_position.y = origin.y
	
func set_power(power):
	self.power = power
	
func hit(hit_object):
	if hit_object.get_name() == "PlayerArea2D":
		call_deferred("queue_free")