extends Node

var music_player: AudioStreamPlayer
var sound_players: Dictionary = {}
var max_sound_players: int = 8

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	music_player = AudioStreamPlayer.new()
	add_child(music_player)
	
	for i in range(max_sound_players):
		var player = AudioStreamPlayer.new()
		add_child(player)
		sound_players[player] = null

func play_music(stream: AudioStream):
	music_player.stream = stream
	music_player.play()

func pause_music():
	music_player.stream_paused = true

func resume_music():
	music_player.stream_paused = false

func stop_music():
	music_player.stop()

func play_sound(stream: AudioStream):
	for player in sound_players.keys():
		if not player.playing:
			player.stream = stream
			player.play()
			sound_players[player] = stream
			return player
	return null

func stop_sound(player: AudioStreamPlayer):
	if player in sound_players:
		player.stop()
		sound_players[player] = null

func stop_all_sounds():
	for player in sound_players.keys():
		player.stop()
		sound_players[player] = null
		
func _input(event):
	if event.is_action_pressed("mute"):
		toggle_mute()
		
func toggle_mute():
	var master_bus_index = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_mute(master_bus_index, !AudioServer.is_bus_mute(master_bus_index))
