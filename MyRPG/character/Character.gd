extends KinematicBody2D


const DEFAULT_SPEED = 100
const IDLE = 0x1
const WALKING = 0x2
const ATTACKING = 0x4
const ATTACK_FREEZE_DURATION = 0.5

var speed = DEFAULT_SPEED
var sprite : AnimatedSprite
var state := IDLE
var movement := Vector2.ZERO
var freeze_time : float

func init(sprite, speed=DEFAULT_SPEED):
	self.sprite = sprite
	self.sprite.animation = 'walk_D'
	self.speed = speed
	self.state = state
	freeze_time = -1


func walk(movement : Vector2):
	self.movement = movement
	if state in [WALKING, IDLE]:
		state = WALKING
		var mx = stepify(movement.x, .01)
		var my = stepify(movement.y, .01)
		if mx > 0:
			sprite.animation = 'walk_R'
		elif mx < 0:
			sprite.animation = 'walk_L'
		elif my > 0:
			sprite.animation = 'walk_D'
		elif my < 0:
			sprite.animation = 'walk_U'	


func attack():
	if state in [WALKING, IDLE]:
		state = ATTACKING
		freeze_time = gettime()
		if sprite.animation.ends_with('_R'):
			sprite.animation = 'attack_R'
		elif sprite.animation.ends_with('_L'):
			sprite.animation = 'attack_L'
		elif sprite.animation.ends_with('_D'):
			sprite.animation = 'attack_D'
		elif sprite.animation.ends_with('_U'):
			sprite.animation = 'attack_U'


func idle():
	state = IDLE
	if sprite.animation.ends_with('_R'):
		sprite.animation = 'walk_R'
	elif sprite.animation.ends_with('_L'):
		sprite.animation = 'walk_L'
	elif sprite.animation.ends_with('_D'):
		sprite.animation = 'walk_D'
	elif sprite.animation.ends_with('_U'):
		sprite.animation = 'walk_U'
	stop()


func stop():
	sprite.set_frame(0)
	sprite.stop()


func _physics_process(delta):
	if state in [ATTACKING]:
		sprite.play()
		var now = gettime()
		if now - freeze_time > ATTACK_FREEZE_DURATION:
			self.idle()
	elif state in [WALKING]:
		if movement != Vector2.ZERO:
			sprite.play()
			move_and_slide(movement*speed)
			movement = Vector2.ZERO
		else:
			self.idle()


func gettime():
	"""Returns current time in seconds."""
	var now = float(OS.get_ticks_msec()) / 1000
	return now
