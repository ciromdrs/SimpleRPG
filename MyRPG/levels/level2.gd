extends Node2D


func _ready():
	$YSort/player.init($YSort/player/joao)
	$YSort/player/KeyboardController.init($YSort/player)
	$YSort/enemy.init($YSort/enemy/joao)
	$YSort/enemy/ChaseAIController.init($YSort/enemy)
	$YSort/enemy/ChaseAIController.chase($YSort/player, 25)
