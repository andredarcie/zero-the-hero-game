class_name Spider extends Enemy

func _ready():
	self.PoolOfBlood = preload("res://enemies/Spider/PoolOfBooldSpider.tscn")
	self.dying_sound = preload("res://enemies/Spider/spider.wav")
