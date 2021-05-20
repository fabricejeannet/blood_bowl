extends Node2D

var field = null
var status
var selected_player = null

onready var tilemap = $TileMap

func _ready():
	field = Field.new()
