# ScreenHandler.gd
# Manages UI screens and scene transitions.
extends CanvasLayer

# --- Preload scenes for transitions ---
@export var game_scene: PackedScene
@export var main_menu_scene: PackedScene

var game_over_screen_instance: Node

# Add a flag to prevent the game over screen from being called multiple times.
var is_game_over: bool = false
var is_quit: bool = false

func _ready():
	# This node needs to process input even when the game is paused
	# so that the UI buttons on the game over screen still work.
	process_mode = Node.PROCESS_MODE_ALWAYS

	# Connect to the global event handler's signal.
	EventHandler.player_died.connect(show_game_over_screen)

	# --- Connect to the tree's 'tree_changed' signal ---
	# This is the Godot 4 replacement for the old 'scene_changed' signal.
	get_tree().tree_changed.connect(_on_tree_changed)

	# Load and prepare the game over screen instance.
	load_game_over_screen()
	
	# --- Manually call for the initial scene load ---
	# This ensures the main menu buttons are connected if the game starts there.
	_on_tree_changed()


# --- FIXED FUNCTION ---
# This function runs every time the scene tree changes (e.g., a new scene is loaded).
func _on_tree_changed():
	# The 'tree_changed' signal has no parameters, so we get the scene manually.
	var scene
	if !is_quit:
		scene = get_tree().current_scene


	# --- FIX: Added a null check for 'scene' ---
	# This prevents a crash if the signal fires before a scene is ready.
	if main_menu_scene and scene and scene.scene_file_path == main_menu_scene.resource_path:
		# Connect the main menu buttons to our handler functions.
		# IMPORTANT: Make sure these node paths are correct for your MainMenuScreen.tscn
		var start_button = scene.get_node_or_null("VBoxContainer/StartButton")
		var quit_button = scene.get_node_or_null("VBoxContainer/QuitButton")

		if start_button:
			# Check if already connected to prevent duplicate connections
			if not start_button.pressed.is_connected(_on_start_game_pressed):
				start_button.pressed.connect(_on_start_game_pressed)
		else:
			print("ScreenHandler Error: Could not find 'StartButton' in Main Menu.")
			
		if quit_button:
			if not quit_button.pressed.is_connected(_on_quit_pressed):
				quit_button.pressed.connect(_on_quit_pressed)
		else:
			print("ScreenHandler Error: Could not find 'QuitButton' in Main Menu.")


# --- MODIFIED: Moved the game over screen loading to its own function for clarity ---
func load_game_over_screen():
	var game_over_scene = load("res://Screens/GameOverScreen.tscn")
	if game_over_scene:
		game_over_screen_instance = game_over_scene.instantiate()
		game_over_screen_instance.hide()
		# Connect the buttons from the game over screen to our functions
		# Make sure the node paths here are correct for your GameOverScreen.tscn
		game_over_screen_instance.get_node("VBoxContainer/RestartButton").pressed.connect(_on_restart_pressed)
		game_over_screen_instance.get_node("VBoxContainer/MainMenuButton").pressed.connect(_on_main_menu_pressed)
		add_child(game_over_screen_instance)
	else:
		print("Error: Could not load GameOverScreen.tscn. Please check the file path.")

func show_game_over_screen():
	if is_game_over:
		return
	
	is_game_over = true
	
	if game_over_screen_instance:
		get_tree().paused = true
		game_over_screen_instance.show()

func _on_restart_pressed():
	is_game_over = false
	if game_over_screen_instance:
		game_over_screen_instance.hide()
		
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_main_menu_pressed():
	is_game_over = false
	if game_over_screen_instance:
		game_over_screen_instance.hide()
		
	get_tree().paused = false
	
	if main_menu_scene:
		get_tree().change_scene_to_packed(main_menu_scene)
	else:
		print("Main Menu scene not set in ScreenHandler!")


# --- NEW FUNCTIONS for Main Menu Buttons ---
func _on_start_game_pressed():
	# Unpause the game in case it was paused, and switch to the main game scene.
	get_tree().paused = false
	if game_scene:
		get_tree().change_scene_to_packed(game_scene)
	else:
		print("Game scene not set in ScreenHandler!")

func _on_quit_pressed():
	# Safely quits the application.
	is_quit = true
	get_tree().quit()
