module screens

import gx
import gg
import othello
import renderer

pub fn render_finished_screen (game othello.Game, gg &gg.Context) {
    renderer.render_board(game, gg)

    gg.draw_square(0, 0, 530, gx.rgba(255, 255, 255, 180))

    gg.draw_text(
        180,
        300,
        "Finished",
        { color: gx.black, size: 40 }
    )

    gg.draw_text(
        60,
        350,
        "(press enter to play again)",
        { color: gx.black, size: 30 }
    )

    winner := othello.get_winner(game) or {
        gg.draw_text(
            60,
            180,
            "It's a draw!",
            { color: gx.black, size: 50 }
        )

        return
    }

    gg.draw_text(
        60,
        180,
        "${winner.celltype} player win!",
        { color: gx.black, size: 50 }
    )
}