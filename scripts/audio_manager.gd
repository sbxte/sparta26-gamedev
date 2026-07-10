extends Node
##An audio manager for music and sound effects.

##The background music player.
var bgm_player := AudioStreamPlayer.new()
##The sound effect players.
var sfx_players:Dictionary[String, AudioStreamPlayer]

##The linear volume of all [AudioStreamPlayer]s.
var master_volume:float = 1:
	set(x):
		var bus_index:int = AudioServer.get_bus_index("Master")
		AudioServer.set_bus_volume_linear(bus_index, x)
		master_volume = x
##If [code]true[/code], mutes all [AudioStreamPlayer]s.
var master_muted:bool = false:
	set(x):
		var bus_index:int = AudioServer.get_bus_index("Master")
		AudioServer.set_bus_mute(bus_index, x)
		master_muted = x

##The linear volume of the background music.
var bgm_volume:float = 1:
	set(x):
		var bus_index:int = AudioServer.get_bus_index("bgm")
		AudioServer.set_bus_volume_linear(bus_index, x)
		bgm_volume = x
##If [code]true[/code], mutes the background music.
var bgm_muted:bool = false:
	set(x):
		var bus_index:int = AudioServer.get_bus_index("bgm")
		AudioServer.set_bus_mute(bus_index, x)
		bgm_muted = x

##The linear volume of all sound effects.
var sfx_volume:float = 1:
	set(x):
		var bus_index:int = AudioServer.get_bus_index("sfx")
		AudioServer.set_bus_volume_linear(bus_index, x)
		sfx_volume = x
##If [code]true[/code], mutes the sound effects.
var sfx_muted:bool = false:
	set(x):
		var bus_index:int = AudioServer.get_bus_index("sfx")
		AudioServer.set_bus_mute(bus_index, x)
		sfx_muted = x

##The maximum amount of times the same sound effect can play at once.
var sfx_polyphony:int = 5:
	set(x):
		for sfx in sfx_players:
			sfx_players[sfx].max_polyphony = x
			sfx_polyphony = x

##Ensures the audio manager always runs and adds the [member bgm_player].
func _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS
	add_child(bgm_player)
	bgm_player.process_mode = PROCESS_MODE_ALWAYS
	bgm_player.bus = "bgm"

##Adds a new [AudioStreamPlayer] designated to a sound effect. Its [enum Node.ProcessMode] is [code]PROCESS_MODE_PAUSABLE[/code] by default.
func add_sfx(sfx:String, mode:ProcessMode = PROCESS_MODE_PAUSABLE) -> AudioStreamPlayer:
	assert(not sfx_players.has(sfx), "sfx player already exists")
	var sfx_player = AudioStreamPlayer.new()
	sfx_players[sfx] = sfx_player
	add_child(sfx_player)
	sfx_player.stream = load(sfx)
	sfx_player.max_polyphony = sfx_polyphony
	sfx_player.process_mode = mode
	sfx_player.bus = "sfx"
	return sfx_player

##Plays the background music.
func play_bgm(bgm:String) -> void:
	bgm_player.stream = load(bgm)
	bgm_player.play()

##Plays a sound effect. Adds an [AudioStreamPlayer] if there's no designated player yet.
func play_sfx(sfx:String) -> void:
	if sfx_players.has(sfx):
		sfx_players[sfx].play()
	else:
		add_sfx(sfx).play()

##Pauses the background music.
func pause_bgm() -> void:
	bgm_player.stream_paused = true

##Resumes the background music.
func resume_bgm() -> void:
	bgm_player.stream_paused = false

##Stops the background music.
func stop_bgm() -> void:
	bgm_player.stop()

##Stops a sound effect.
func stop_sfx(sfx:String) -> void:
	assert(sfx_players.has(sfx), "sfx player doesn't exist")
	sfx_players[sfx].stop()

##Stops all sound effects.
func stop_all_sfx() -> void:
	for sfx in sfx_players:
		sfx_players[sfx].stop()
