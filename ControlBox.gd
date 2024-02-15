extends StaticBody2D

signal box_hit

func _ready():
	$HitBox.connect('body_entered', on_body_entered)

func on_body_entered(what: Node2D):
	print('you hit it')
	box_hit.emit()

func _process(delta):
	pass
