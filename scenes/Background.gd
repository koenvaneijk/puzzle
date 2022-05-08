extends TextureRect

onready var puzzle = get_parent()

func _draw():
	var width = puzzle.texture.get_width() / puzzle.number_of_columns
	var height = puzzle.texture.get_height() / puzzle.number_of_rows
	
	for i in range(puzzle.number_of_columns):
		draw_line(
			Vector2(
				i*width,
				0
				),
			Vector2(
				i*width,
				puzzle.texture.get_height()
				),
			Color(1,1,1,1),
			2
		)
	
	for i in range(puzzle.number_of_rows):
		draw_line(
			Vector2(
				0,
				i*height
			),
			Vector2(
				puzzle.texture.get_width(),
				i*height
			),
			Color(1,1,1,1),
			2
			)
	
