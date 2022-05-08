extends TextureButton

export(int) var row
export(int) var column

var is_pressed = false
var offset = null

var original_transform = get_global_transform()

onready var puzzle = get_parent().get_parent()

func _ready():
	# Crop from texture (save memory)
	var region_to_crop := Rect2(
		_piece_width()*column, 
		_piece_height()*row, 
		_piece_width(), 
		_piece_height())
	
	# Set texture normal of the TextureButton
	texture_normal = get_cropped_texture(puzzle.texture, region_to_crop)
	rect_size.x = _piece_width()
	rect_size.y = _piece_height()
	
	$CPUParticles2D.position = Vector2(_piece_width()/2, _piece_height()/2)
	

func get_cropped_texture(var texture : Texture, var region : Rect2) -> AtlasTexture:
	# Crops a texture using AtlasTexture
	var atlas_texture = AtlasTexture.new()
	
	atlas_texture.set_atlas(texture)
	atlas_texture.set_region(region)
	
	return atlas_texture

func _piece_width():
	# Returns the width of the piece
	return puzzle.texture.get_width() / puzzle.number_of_columns

func _piece_height():
	# Returns the height of the piece
	return puzzle.texture.get_height() / puzzle.number_of_rows

func position_to_grid_row(event):
	var row_
	
	row_ = floor(get_global_mouse_position().y / puzzle.texture.get_height() * puzzle.number_of_rows)

	if row_ > puzzle.number_of_rows or row_ < 0:
		return null
	else:	 
		return row_
	
func position_to_grid_column(event):
	var column_
	
	column_ = floor(get_global_mouse_position().x / puzzle.texture.get_width() * puzzle.number_of_columns)

	if column_ > puzzle.number_of_columns or column_ < 0:
		return null
	else:
		return column_

func _on_PuzzlePiece_gui_input(event):
	# Touching
	if event is InputEventScreenTouch:
		
		if event.is_pressed():
			print_debug("Touched " + str(column) + ":" + str(row))
			is_pressed = true
			offset = event.position
			
		else:
			print_debug("Released " + str(column) + ":" + str(row))
			is_pressed = false
			offset = null
			
			# Check if we released in the right place
			var column_ = position_to_grid_column(event)
			var row_ = position_to_grid_row(event)

			if row_ != null and column_ != null:
				if row == row_ and column == column_:
					
					# Snap in place
					set_position(
						Vector2(_piece_width()*column, _piece_height()*row)
					)
					
					$CPUParticles2D.emitting = true
	# Dragging
	if is_pressed:
		if event is InputEventScreenDrag:
			set_global_position(get_global_mouse_position()-offset)
		
