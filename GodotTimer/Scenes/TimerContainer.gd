extends HBoxContainer

@export var mssNode : Label
@export var nnNode : Label

@export var totalSeconds : float

var remainingSeconds : float

func _ready():
	remainingSeconds = totalSeconds

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	remainingSeconds -= delta
	remainingSeconds = max(remainingSeconds, 0)
	var minutesLeft = int(remainingSeconds) / 60
	var secondsLeft = int(remainingSeconds) % 60
	var nanosecLeft = (remainingSeconds - int(remainingSeconds)) * 100
	mssNode.text = str(minutesLeft).pad_zeros(0) + ":" + str(secondsLeft).pad_zeros(2)
	nnNode.text = ":" + str(int(nanosecLeft)).pad_decimals(0).pad_zeros(2)
	pass
