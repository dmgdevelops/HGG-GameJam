extends Area2D

func _on_body_entered(body):
	if body.is_in_group("Player"):
		Global.morgan_page_collection+=1
		self.visible = false
		print("Morgan has collected %o page(s)." % Global.morgan_page_collection)
		queue_free()
