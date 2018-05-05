extends KinematicBody2D

const WALK_SPEED = 200

var velocity = Vector2()

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _physics_process(delta):

    if Input.is_action_pressed("ui_left"):
        velocity.x = -WALK_SPEED
    elif Input.is_action_pressed("ui_right"):
        velocity.x =  WALK_SPEED
    else:
        velocity.x = 0
    if Input.is_action_pressed("ui_up"):
        velocity.y = -WALK_SPEED
    elif Input.is_action_pressed("ui_down"):
        velocity.y =  WALK_SPEED
    else:
        velocity.y = 0
    move_and_slide(velocity, Vector2(0, -1))