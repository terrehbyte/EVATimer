extends HBoxContainer
class_name TimerContainer # declares this type globally

# exports are visible to the inspector
@export var mssNode : Label
@export var nnNode : Label
@export var totalSeconds : float
@export var tickSound : AudioStream
@export var sfxPlayer : AudioStreamPlayer

# signals are events that other scripts can react to
signal timer_started(seconds_to_complete)
signal timer_completed
signal timer_second_tick(seconds_remaining)

# plain variables
var isTimerCompleted : bool = false
var lastSecondTick : int
var remainingSeconds : float

# Called at start of lifetime.
func _ready():
	timer_started.emit(remainingSeconds)
	remainingSeconds = totalSeconds
	lastSecondTick = remainingSeconds
	timer_second_tick.emit(remainingSeconds)

# Called every frame while alive. 'delta' is the elapsed time since the previous frame.
func _process(delta : float):
	remainingSeconds -= delta
	remainingSeconds = max(remainingSeconds, 0)
	var minutesLeft = int(remainingSeconds) / 60
	var secondsLeft = int(remainingSeconds) % 60
	var nanosecLeft = (remainingSeconds - int(remainingSeconds)) * 100
	mssNode.text = str(minutesLeft).pad_zeros(2) + ":" + str(secondsLeft).pad_zeros(2)
	nnNode.text = ":" + str(int(nanosecLeft)).pad_decimals(0).pad_zeros(2)
	
	# Update tick signal if we've ticked over to the next second
	if lastSecondTick != int(remainingSeconds):
		lastSecondTick = remainingSeconds
		timer_second_tick.emit(lastSecondTick)
		sfxPlayer.stream = tickSound
		sfxPlayer.play()
	
	# Emit completed signal if timer has finished counting down
	if !isTimerCompleted && remainingSeconds == 0:
		isTimerCompleted = true
		timer_completed.emit()
		
	pass
