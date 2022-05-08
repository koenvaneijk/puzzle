extends Node2D

export(int) var number_of_rows
export(int) var number_of_columns

export(PackedScene) var PuzzlePiece

onready var texture = $Background.texture

func _ready():
	$ColumnSpinbox.value = number_of_columns
	$RowSpinbox.value = number_of_rows
	
	construct_puzzle()
	
func construct_puzzle():
	print("constructing puzzle")
	for piece in $Pieces.get_children():
		piece.queue_free()
		
	$Background.update()
		
	randomize()
	
	var rows = []
	for i in range(number_of_rows):
		rows.append(i)
	rows.shuffle()
	
	var columns = []
	for i in range(number_of_columns):
		columns.append(i)
	columns.shuffle()
	
	for i in rows:
		for j in columns:
			var puzzle_piece = PuzzlePiece.instance()
			
			puzzle_piece.row = i
			puzzle_piece.column = j
			
			$Pieces.add_child(puzzle_piece)
			
			puzzle_piece.set_position($StackPosition.position)



func _on_ColumnSpinbox_value_changed(value):
	number_of_columns = value
	construct_puzzle()


func _on_RowSpinbox_value_changed(value):
	number_of_rows = value
	construct_puzzle()
