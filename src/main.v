import othello
import screens
import gx
import gg
import os

const (
    win_width  = 500
    win_height = 530
)

enum AppState {
    start
    running
    finished
}

struct App {
    mut: 
        gg &gg.Context = 0
        game othello.Game
        state AppState = AppState.start
        logo gg.Image
}

fn frame(mut app App) {
	app.gg.begin()
	app.draw()
	app.gg.end()
}

fn (app &App) draw() {
    match app.state {
        .start { screens.render_welcome_screen(app.gg, app.logo) }
        .running { screens.render_running_screen(app.game, app.gg) }
        .finished { screens.render_finished_screen(app.game, app.gg) }
    }
}

fn (mut app App) handle_cell_change_input(index int) {
    app.game.error = ""

	player := othello.current_player(app.game)
    legal_cellchanges := othello.get_legal_cell_changes_for_celltype(player.celltype, app.game.board)

    if legal_cellchanges.len - 1 < index {
        app.game.error = "(invalid move)"
        return
    }

    cellchange := legal_cellchanges[index]

    mut cell_changes_from_choice := othello.get_flipped_cells_from_cell_change(
        cellchange,
        app.game.board
    )

    cell_changes_from_choice << cellchange
    app.game.board = othello.draw_cells(cell_changes_from_choice, app.game.board)
    
    reverse_player := othello.other_player(app.game)
    reverse_legal_cellchanges := othello.get_legal_cell_changes_for_celltype(reverse_player.celltype, app.game.board)
    if reverse_legal_cellchanges.len == 0 {
        next_legal_cellchanges := othello.get_legal_cell_changes_for_celltype(othello.current_player(app.game).celltype, app.game.board)
        
        if next_legal_cellchanges.len == 0 {
            app.state = AppState.finished
            return
        }

         app.game.error = "(${reverse_player.celltype} can't play)"
    }  else {
        app.game.switch_player()
    }
    
    // check game state here

    if app.game.is_finished() {
        app.state = AppState.finished
    }
}

fn (mut app App) on_key_down(key gg.KeyCode) {
	match key {
		.escape { exit(0) }
        .enter {
            match app.state {
                .start { app.state = AppState.running }
                .finished {
                    app.game = othello.create_game()
                    app.state = AppState.running
                }
                else { /* Ignore other states */ }
            }
        }
        .kp_1 { app.handle_cell_change_input(0) }
        .kp_2 { app.handle_cell_change_input(1) }
        .kp_3 { app.handle_cell_change_input(2) }
        .kp_4 { app.handle_cell_change_input(3) }
        .kp_5 { app.handle_cell_change_input(4) }
        .kp_6 { app.handle_cell_change_input(5) }
        .kp_7 { app.handle_cell_change_input(6) }
        .kp_8 { app.handle_cell_change_input(7) }
        .kp_9 { app.handle_cell_change_input(8) }
		else { /* Ignore other events */ }
	}

    app.gg.refresh_ui()
}

fn on_event(e &gg.Event, mut app App) {
	match e.typ {
		.key_down {
			app.on_key_down(e.key_code)
		}
		else { /* Ignore other events */ }
	}
}

fn init_assets (mut app App) {
    app.logo = app.gg.create_image(os.resource_abs_path('./assets/v.png'))
}

// no left choice => 1 2 2 1.....

fn main() {
    mut app := &App{}
    
    app.game = othello.create_game()

    app.gg = gg.new_context(
        bg_color: gx.rgb(230, 230, 230)
        width: win_width
        height: win_height
        sample_count: 8 // higher quality curves
        create_window: true
        window_title: "Vothello"
        frame_fn: frame
        user_data: app
        event_fn: on_event
        init_fn: init_assets
        font_path: os.resource_abs_path(os.join_path('./assets/', 'RobotoMono-Regular.ttf'))
    )

    app.gg.run()
}