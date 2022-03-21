extends Node2D


var character : KinematicBody2D
var velocity = Vector2()
var to_chase : KinematicBody2D
var radius = 1


func init(character):
	self.character = character


func chase(to_chase, radius=1):
	self.to_chase = to_chase
	self.radius = radius


func _physics_process(delta):
	if to_chase != null:
		var distance = to_chase.transform.get_origin() - character.transform.get_origin()
		if distance.length() > self.radius:
			velocity = distance.normalized()
			velocity = character.walk(velocity)
		else:
			character.stop()
			
