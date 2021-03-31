module screens

import gx
import gg

pub fn render_welcome_screen (gg &gg.Context, logo gg.Image) {
    gg.draw_image(120, 120, 500, 500, logo)

    gg.draw_text(
        80,
        200,
        "Welcome to Vothello",
        { color: gx.black, size: 40 }
    )

    gg.draw_text(
        100,
        250,
        "(press enter to start)",
        { color: gx.black, size: 30 }
    )
}