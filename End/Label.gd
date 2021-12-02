extends Label

func _ready():
	self.text = str("Coins ", PlayerScore.score, "/10\n", "You died ", PlayerScore.deaths, " times")

