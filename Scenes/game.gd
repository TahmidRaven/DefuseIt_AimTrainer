extends Node2D

var tnt_scene = preload("res://Scenes/tnt.tscn")
var score = 0        # Tracks SAVES
var booms = 0        # Tracks BOOMS
var game_over = false

@onready var label = $InstructionLabel
@onready var saves_label = $Scores/SAVES
@onready var booms_label = $Scores/BOOMS

func _ready():
	randomize()
	update_ui()
	spawn_loop()

func update_ui():
	# Updates the labels you added in the editor 
	saves_label.text = "DEFUSES: " + str(score)
	booms_label.text = "BOOMS: " + str(booms)

func spawn_loop():
	while !game_over:
		# Dynamic Speed: Spawns faster as score increases 
		var wait_time = max(0.4, 1.0 - (score * 0.02))
		await get_tree().create_timer(wait_time).timeout
		
		if !game_over:
			spawn()
			
			# Logic for multiple spawns 
			var chance = randf()
			if score >= 50:
				if chance < 0.33: spawn()
			elif score >= 25:
				if chance < 0.22: spawn()
			elif score >= 10:
				if chance < 0.11: spawn()

func spawn():
	var tnt = tnt_scene.instantiate()
	add_child(tnt)

	var screen_size = get_viewport_rect().size
	var padding = 64 
	
	tnt.position = Vector2(
		randf_range(padding, screen_size.x - padding),
		randf_range(padding, screen_size.y - padding)
	)
