extends Area2D

@export var drop_handler : DropHandler = null

# Called when the node enters the scene tree for the first time.
func _ready():
	area_entered.connect(on_area_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func on_area_entered(area : Area2D) -> void:
	if !area.is_in_group("collectable"):
		return
	
	drop_handler.add_coin(area.get_parent().value)
	area.get_parent().queue_free()
