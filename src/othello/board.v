module othello

pub fn create_board(width int, height int) [][]CellType {
    return [][]CellType{
        len: width,
        init: []CellType{ len: height, init: CellType.empty }
    }
}

pub fn draw_cells(cells []Cell, board [][]CellType) [][]CellType {
	mut new_board := board.clone()
	for cell in cells {
		new_board[cell.y][cell.x] = cell.celltype
	}

	return new_board
}

pub fn get_departure_cells(board [][]CellType, width int, height int) []Cell {
	mid_width := int(width / 2)
	mid_height := int(height / 2)

	return [
		Cell { x: mid_width, y: mid_height, celltype: CellType.black },
		Cell { x: mid_width - 1, y:  mid_height - 1, celltype: CellType.black },
		Cell { x: mid_width - 1, y:  mid_height, celltype: CellType.white },
		Cell { x: mid_width, y: mid_height - 1, celltype: CellType.white }
    ]
}

pub fn init_cells(board [][]CellType, width int, height int) [][]CellType {
	return draw_cells(get_departure_cells(board, width, height), board)
}

pub fn is_full(board [][]CellType) bool {
	 for row in board {
        for celltype in row {
			if celltype == CellType.empty {
				return false
			}
		}
	 }

	return true
}

pub fn get_celltype(xPos int, yPos int, board [][]CellType) CellType {
	if xPos < 0 || yPos < 0 {
		return CellType.empty
	}

	if !((board.len - 1) >= yPos && (board[yPos].len - 1) >= xPos) {
		return CellType.empty
	}

	return board[yPos][xPos]
}

pub fn get_flipped_cells_from_cell_change(cell_change Cell, board [][]CellType) []Cell {
	if get_celltype(cell_change.x, cell_change.y, board) != CellType.empty {
		return []
	}

	mut flipped_cells := []Cell{}
	for directionnal_vector in get_directionnal_vectors() {
		flipped_cells << get_flipped_cells_for_cell_change_and_direction_vector(cell_change, directionnal_vector, board)
	}

	return flipped_cells
}

pub fn get_flipped_cells_for_cell_change_and_direction_vector(cell_change Cell, direction_vector Vector, board [][]CellType) []Cell {
	mut flipped_cells := []Cell{}

	mut local_celltype := CellType.empty
	mut local_cellpos := Vector{ x: cell_change.x, y: cell_change.y }
	mut reverse_celltype := get_reverse_celltype(cell_change.celltype)

	for {
		local_cellpos = vector_add(local_cellpos, direction_vector)
		local_celltype = get_celltype(local_cellpos.x, local_cellpos.y, board)
	
		if local_celltype != reverse_celltype {
			break
		}

		flipped_cell := Cell {
			x: local_cellpos.x,
			y: local_cellpos.y,
			celltype: cell_change.celltype
		}

		flipped_cells << flipped_cell
	}

	if local_celltype == cell_change.celltype && flipped_cells.len > 0 {
		return flipped_cells
	}

	return []
}

pub fn is_legal_cell_change(cellChange Cell, board [][]CellType) bool {
	return get_flipped_cells_from_cell_change(cellChange, board).len > 0
}

pub fn get_legal_cell_changes_for_celltype(cellType CellType, board [][]CellType) []Cell {
	mut legal_cell_changes := []Cell{}

	for y, row in board {
		for x, _ in row {
			cell_change := Cell{ x, y, cellType }
			if is_legal_cell_change(cell_change, board) {
				legal_cell_changes << cell_change
			}
		}
	}

	return legal_cell_changes
}

pub fn get_score_by_celltype(board [][]CellType, wantedCellType CellType) int {
	mut count := 0

	for row in board {
		for celltype in row {
			if celltype == wantedCellType {
				count++
			}
		}
	}

	return count
}


// pub fn FindCellIndexAt(x uint8, y uint8, cells []cell.Cell) (cell.Cell, int) {
// 	for idx, cell := range cells {
// 		if cell.X == x && cell.Y == y {
// 			return cell, idx
// 		}
// 	}
// 	return cell.Cell{}, -1
// }