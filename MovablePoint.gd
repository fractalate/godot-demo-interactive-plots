extends Node2D

var targetPosition: Vector2 = Vector2(0, 0)
var velocity: Vector2 = Vector2(0, 0)
var dampening = 0.99

func setTargetPosition(where: Vector2):
	targetPosition = Vector2(where)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _draw():
	draw_circle(position, 2, Color(1, 1, 1))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position != targetPosition:
		var distance = targetPosition - position
		var direction = distance.normalized()
		var accel = direction * 300 * delta
		velocity += accel
		velocity *= (1 - dampening * delta)
		position += velocity * delta
