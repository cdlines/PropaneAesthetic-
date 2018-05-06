extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	add_child(load("res://player/Player.tscn").instance())
	#add_child(load("res://turret/Turret0.tscn").instance())
	for i in range(0, 3):
		var enemy = preload("res://turret/Turret0.tscn").instance()
		enemy.init(randi()%1024, randi()%1000, randi()%4, randi()%3)
		add_child(enemy)
	#var enemy = preload("res://turret/Turret0.tscn").instance()
	#enemy.init(50, 50, 0, 2)
	#add_child(enemy)
	
	#var enemy1 = preload("res://turret/Turret0.tscn").instance()
	#enemy1.init(0, 0, 2, 1)
	#add_child(enemy1)
	
	#var enemy2 = preload("res://turret/Turret0.tscn").instance()
	#enemy2.init(100, 100, 1, 0)
	#add_child(enemy2)
	
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
