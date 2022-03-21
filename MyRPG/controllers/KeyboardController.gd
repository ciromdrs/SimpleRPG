extends Node


var character : KinematicBody2D
var velocity = Vector2()

func init(character):
	self.character = character


func _physics_process(delta):
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	velocity = velocity.normalized()
	
	if Input.is_action_just_pressed("attack"):
		velocity = Vector2.ZERO
		character.attack()
		
	if velocity.length() > 0:
		velocity = character.walk(velocity)
