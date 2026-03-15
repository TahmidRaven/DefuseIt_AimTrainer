extends Area2D

@onready var anim = $AnimatedSprite2D

var padding = 40
var clicked = false

func _ready():
	anim.frame = 0
	
	if anim.sprite_frames.has_animation("explode"):
		anim.play("explode")
	else:
		print("Error: Animation 'explode' not found!")
	
	await anim.animation_finished
	if !clicked:
		fail() # If the animation ends and we haven't clicked, it's a fail 
		

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and !clicked:
		clicked = true
		
		var total_frames = anim.sprite_frames.get_frame_count("explode")
		var halfway = total_frames / 2
		
		if anim.frame <= halfway:
			success()
		else:
			anim.stop() 
			fail()

func success():
	print("SAFE")
	var game = get_parent()
	game.score += 1 
	game.update_ui() # Refresh labels 
	queue_free()
	
func fail():
	print("BOOM")
	var game = get_parent()
	game.booms += 1
	game.update_ui() # Refresh labels 
	
	# Feedback: Make it big and red 
	modulate = Color.RED
	scale = Vector2(4, 4)
	await get_tree().create_timer(0.2).timeout
	queue_free()
