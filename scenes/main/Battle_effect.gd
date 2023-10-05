extends TileMap




var dark_tile : Vector2 = Vector2(0,0)
var is_time_for_battle = false
var zoom : int = 4
var counter : int = 0
var restart_counter : float = 0.0
@onready var rect : Rect2 = get_viewport_rect()
@onready var max_tiles_count = (rect.size.x * rect.size.y) / (zoom*16)

var big_dict : Dictionary = {}
var rng := RandomNumberGenerator.new()
var show_effect : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for x in range(rect.size.x / (zoom*16)):
		for y in range(rect.size.y / (zoom*16)):
			big_dict[Vector2(x,y)] = null
	
#	var timer = Timer.new()
#	timer.wait_time = 5
#	add_child(timer)
#	timer.start()
#	timer.connect("timeout", func (): show_effect = true)
#	timer.connect("timeout", func (): timer.queue_free())


func _process(delta: float) -> void:
	if big_dict.size() > 0 and show_effect == true:
		var min_range : int = min(big_dict.size(), 10)
		for i in range(min_range):
			#print(big_dict.size())
			
			rng.randomize()
			var index = rng.randi_range(0, big_dict.size() - 1)
			var keys = big_dict.keys()
			set_cell(0, keys[index],0, dark_tile)
			big_dict.erase(keys[index])
	elif show_effect == true:
		restart_counter += delta
		#print(restart_counter)
		
		
		if restart_counter >= 0.25:
			restart_counter = 0
			show_effect = false
			clear()
			change_to_battle_scene()
			
			

func show_battle_effect() -> void:
	%white_background.is_active = true
	var timer = Timer.new()
	timer.wait_time = 0.5
	add_child(timer)
	timer.start()
	timer.connect("timeout", func (): show_effect = true)
	timer.connect("timeout", func (): timer.queue_free())

func change_to_battle_scene() -> void:
	get_tree().change_scene_to_packed(Scenes.battle)
	pass
