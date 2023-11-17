extends CanvasLayer

signal start_game

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func show_message(text, scaling=false):
	$CenterContainer/Message.text = text
	$CenterContainer/Message.show()

	if scaling:
		$AnimationPlayer.play("scaling")
		var animation_timeout = $AnimationPlayer.get_animation("scaling").length
		await get_tree().create_timer(animation_timeout).timeout
		$CenterContainer/Message.hide()
	else:
		await get_tree().create_timer(2.0).timeout
		$CenterContainer/Message.hide()

func show_game_over():
	show_message("Game Over")
	await get_tree().create_timer(2.0).timeout

	$CenterContainer/Message.text = "Dodge\nthe\nCreeps!"
	$CenterContainer/Message.show()

	await get_tree().create_timer(1.0).timeout
	$StartButton.show()

func update_score(score):
	$ScoreLabel.text = str(score)

func _on_message_timer_timeout():
	$CenterContainer/Message.hide()

func _on_start_button_pressed():
	$StartButton.hide()
	await show_message("Get Ready!")
	start_game.emit()
	show_message("GO!", true)
