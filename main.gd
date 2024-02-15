extends Node2D

var movable_point_loaded = load('res://MovablePoint.tscn')

@onready var DebugText = $DebugText
@onready var ControlBox = $ControlBox

var points = []
var drawing = 'random'

func initPoints():
	for x in range(1024):
		var point = movable_point_loaded.instantiate()
		points.append(point)
		add_child(point)

func drawRandom():
	drawing = 'random'
	var view = get_viewport_rect().size
	for point in points:
		point.setTargetPosition(Vector2(randi_range(0, view.x - 1), randi_range(0, view.y - 1)))

func drawSine():
	drawing = 'sine'
	var view = get_viewport_rect().size
	var center_y = floor(view.y / 2)
	points.shuffle()
	for x in range(len(points)):
		var point = points[x]
		var y = 300 * sin((x + 0.0) / len(points) * (2 * PI)) + center_y
		point.setTargetPosition(Vector2(x, y))

func drawCosine():
	drawing = 'cosine'
	var view = get_viewport_rect().size
	var center_y = floor(view.y / 2)
	points.shuffle()
	for x in range(len(points)):
		var point = points[x]
		var y = 300 * cos((x + 0.0) / len(points) * (2 * PI)) + center_y
		point.setTargetPosition(Vector2(x, y))
		
func drawHeart():
	drawing = 'heart'
	var mid_x = floor(len(points) / 2)
	var view = get_viewport_rect().size
	var center_y = floor(view.y / 2)
	points.shuffle()
	for x in range(len(points)):
		var point = points[x]
		var y = 0
		if x % 2 == 0:
			y = -200 * abs(sin((x + 0.0) / len(points) * (2 * PI))) + center_y
		else:
			y = (floor(len(points) / 2) - abs(x - mid_x)) * 0.75 + center_y
		point.setTargetPosition(Vector2(x, y))

func _ready():
	ControlBox.connect("box_hit", on_box_hit)
	#var point = movable_point_loaded.instantiate()
	#point.position = get_viewport_rect().size / 2
	#add_child(point)
	initPoints()
	drawRandom()

func on_box_hit():
	print("we are here")
	if drawing == 'random':
		drawHeart()
	elif drawing == 'heart':
		drawSine()
	elif drawing == 'sine':
		drawCosine()
	elif drawing == 'cosine':
		drawRandom()
	
func _process(delta):
	pass
