module renderer

import othello
import gx
import gg

pub fn render_board(game othello.Game, gg &gg.Context) {
	for i, row in game.board {
        for j, celltype in row {
            if celltype == othello.CellType.empty {
                gg.draw_circle_with_segments(
                    55 + (i * 55),
                    54 + (j * 55),
                    25,
                    40,
                    gx.black
                )
                
                gg.draw_circle_with_segments(
                    55 + (i * 55),
                    56 + (j * 55),
                    25,
                    40,
                    gx.white
                )
            }

            gg.draw_circle_with_segments(
                55 + (i * 55),
                55 + (j * 55),
                25,
				40,
                othello.get_celltype_color(celltype)
			)
        }
    }
}

pub fn render_choices(game othello.Game, gg &gg.Context) {
	player := othello.current_player(game)
	legal_cell_changes := othello.get_legal_cell_changes_for_celltype(player.celltype, game.board)

	for i, row in game.board {
        for j, _ in row {
            for index, cell_change in legal_cell_changes {
                if cell_change.x == j && cell_change.y == i {
                    gg.draw_text(
                        48 + (i * 55),
                        43 + (j * 55),
                        (index + 1).str(),
                        { color: gx.black, size: 26 }
                    )
                }
            }
        }
    }
}