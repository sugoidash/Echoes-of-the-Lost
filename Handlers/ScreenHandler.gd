# ScreenHandler.gd
# Manages UI screens and scene transitions.
extends CanvasLayer

# --- Preload scenes for transitions ---
@export var main_menu_scene: PackedScene
var game_over_screen_instance: Node

# Add a flag to prevent the game over screen from being called multiple times.
var is_game_over: bool = false

func _ready():
	# This node needs to process input even when the game is paused
	# so that the UI buttons on the game over screen still work.
	process_mode = Node.PROCESS_MODE_ALWAYS

	# Connect to the global event handler's signal.
	EventHandler.player_died.connect(show_game_over_screen)

	# Load the game over screen scene.
	var game_over_scene = load("res://Screens/GameOverScreen.tscn")

	# Check if the scene was loaded successfully before trying to use it.
	if game_over_scene:
		game_over_screen_instance = game_over_scene.instantiate()
		game_over_screen_instance.hide()
		# Connect the buttons from the game over screen to our functions
		# Make sure the node paths here are correct for your GameOverScreen.tscn
		game_over_screen_instance.get_node("VBoxContainer/RestartButton").pressed.connect(_on_restart_pressed)
		game_over_screen_instance.get_node("VBoxContainer/MainMenuButton").pressed.connect(_on_main_menu_pressed)
		add_child(game_over_screen_instance)
	else:
		# Print an error if the scene could not be loaded.
		print("Error: Could not load GameOverScreen.tscn. Please check the file path.")

func show_game_over_screen():
	# Only run the game over logic if it hasn't already been run.
	if is_game_over:
		return # Exit the function if the game is already over.
	
	is_game_over = true # Set the flag to true.
	
	# Only show the screen if it was loaded correctly.
	if game_over_screen_instance:
		# Pause the game and show the game over screen.
		get_tree().paused = true
		game_over_screen_instance.show()

func _on_restart_pressed():
	# --- FIX ---
	# Because this node is an autoload, we must manually reset its state
	# and hide the UI before reloading the scene.
	is_game_over = false
	if game_over_screen_instance:
		game_over_screen_instance.hide()
		
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_main_menu_pressed():
	# --- FIX ---
	# Also reset state and hide UI when going to the main menu.
	is_game_over = false
	if game_over_screen_instance:
		game_over_screen_instance.hide()
		
	get_tree().paused = false
	if main_menu_scene:
		get_tree().change_scene_to_packed(main_menu_scene)
	else:
		print("Main Menu scene not set in ScreenHandler!")
