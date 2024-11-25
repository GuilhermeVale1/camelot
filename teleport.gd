extends Area2D



func _on_body_entered(body):
	if(body.is_in_group("jogador")):
		if body.has_method("mudLocale"):
			body.mudLocale()
			var teleport_markers = get_tree().get_nodes_in_group("teleport")
			
			if teleport_markers.size() > 0:
				# Seleciona o primeiro marcador (ou altere conforme necessário)
				var target_marker = teleport_markers[0]
				body.global_position = target_marker.global_position
