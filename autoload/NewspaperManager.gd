extends Node

signal piece_collected(current, total)
signal all_collected
const TOTAL_PIECES := 5
var collected_pieces: Array[int] = []

func collect(id: int):

	if id in collected_pieces:
		return
	collected_pieces.append(id)
	piece_collected.emit(collected_pieces.size(), TOTAL_PIECES)
	print("Newspaper:", collected_pieces.size(), "/", TOTAL_PIECES)

	if collected_pieces.size() == TOTAL_PIECES:
		all_collected.emit()
