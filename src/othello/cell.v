module othello

import gx

pub enum CellType {
    empty
    black
    white
}

struct Cell {
	pub:
        x int
	    y int
	    celltype CellType
}

pub fn get_celltype_color(cellType CellType) gx.Color {
    return match cellType {
        .empty { gx.rgb(0, 255, 0) }
        .black { gx.black }
        .white { gx.white }
    }
}

pub fn get_reverse_celltype(cellType CellType) CellType {
     return match cellType {
        .empty { CellType.empty }
        .black { CellType.white }
        .white { CellType.black }
    }
}
	