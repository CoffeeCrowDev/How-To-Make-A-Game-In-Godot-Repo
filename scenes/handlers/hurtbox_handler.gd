class_name HurtboxHandler
extends Area2D

@onready var collision_shape_2d = $CollisionShape2D as CollisionShape2D

func _ready():
	area_entered.connect(on_area_entered)


func on_area_entered(area : Area2D) -> void:
	if not area is HitboxHandler:
		return
	
	if area.has_signal("on_hit"):
		area.on_hit.emit()
		print("AREA HIT")
	
	print("AREA NOT HIT")
