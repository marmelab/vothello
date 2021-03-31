module screens

import othello
import gx
import gg
import renderer

pub fn render_running_screen (game othello.Game, gg &gg.Context) {
	renderer.render_board(game, gg)
	renderer.render_choices(game, gg)

	player := othello.current_player(game)

	gg.draw_text(
		30,
		485,
		"Current player: ${player.celltype}",
		{ color: gx.black, size: 20 }
	)

    gg.draw_text(
		270,
		485,
		game.error,
		{ color: gx.red, size: 20 }
	)


	gg.draw_text(
		30,
		485,
		"Current player: ${player.celltype}",
		{ color: gx.black, size: 20 }
	)
}