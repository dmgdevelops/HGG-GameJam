extends Area2D

func _on_body_entered(body):
	if body.is_in_group("Player"):
		Global.morgan_picture_collection+=1
		self.visible = false
		print("Morgan has collected %o picture piece(s)." % Global.morgan_picture_collection)
		queue_free()
