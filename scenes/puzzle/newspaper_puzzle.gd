extends CanvasLayer

@onready var pieces = [
	$PanelContainer/MarginController/VBoxContainer/PieceContainer/Piece1,
	$PanelContainer/MarginController/VBoxContainer/PieceContainer/Piece2,
	$PanelContainer/MarginController/VBoxContainer/PieceContainer/Piece3,
	$PanelContainer/MarginController/VBoxContainer/PieceContainer/Piece4,
	$PanelContainer/MarginController/VBoxContainer/PieceContainer/Piece5
]

var piece_data = [
	{
		"id":1,
		"text":"KRISIS ENERGI BESAR\nMELANDA NUSANTARA\n\nPemerintah mengumumkan..."
	},
	{
		"id":2,
		"text":"...cadangan energi\nmenurun drastis\ndalam lima tahun..."
	},
	{
		"id":3,
		"text":"Warga mulai mengalami\npemadaman listrik..."
	},
	{
		"id":4,
		"text":"Ilmuwan menemukan\nbahwa penyebabnya\nbukan faktor alam..."
	},
	{
		"id":5,
		"text":"Dokumen berikutnya\nDIKLASIFIKASIKAN\nRAHASIA NEGARA."
	}
]

var selected_index := -1

func _ready():
	print(pieces)
	randomize()
	piece_data.shuffle()
	update_ui()
	hide()
	
func update_ui():
	for i in piece_data.size():
		pieces[i].text = piece_data[i]["text"]
		
func select_piece(index):
	if selected_index == -1:
		selected_index = index
		pieces[index].modulate = Color.YELLOW
		return
	swap_piece(selected_index,index)
	pieces[selected_index].modulate = Color.WHITE
	selected_index = -1

func swap_piece(a,b):
	var temp = piece_data[a]
	piece_data[a] = piece_data[b]
	piece_data[b] = temp
	update_ui()

func check_puzzle():
	for i in piece_data.size():
		if piece_data[i]["id"] != i+1:
			DialogueManager.start("puzzle_wrong")
			return
	puzzle_complete()
	
func puzzle_complete():
	hide()
	DialogueManager.start("newspaper_complete")
	print("Puzzle Complete")

func _on_piece_1_pressed():
	select_piece(0)
	
func _on_piece_2_pressed():
	select_piece(1)
	
func _on_piece_3_pressed():
	select_piece(2)
	
func _on_piece_4_pressed():
	select_piece(3)
	
func _on_piece_5_pressed():
	select_piece(4)

func _on_check_button_pressed():
	check_puzzle()
