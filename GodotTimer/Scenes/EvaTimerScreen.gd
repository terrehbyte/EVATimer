extends Control

@export var fillControl : TextureRect
@export var timer : TimerContainer

var noise : Noise
var timeElapsed : float

func _ready():
	noise = FastNoiseLite.new()
	pass

func _process(delta : float):
	timeElapsed += delta
	var curNoise = noise.get_noise_1d(timeElapsed * 100.0) / 10.0
	if timer.getTimeRemainingFrac() == 0.0:
		curNoise = 0.0
	fillControl.anchor_right = timer.getTimeRemainingFrac() + curNoise
	pass
