module othello

struct Game {
	pub mut:
		board [][]CellType
		player_index int
		players []Player
		error string
}

pub fn create_game() Game {
 	board := othello.init_cells(
        othello.create_board(8, 8),
        8,
        8
    )	

	return Game {
		board: board
		player_index: 0
		players: [
			Player { celltype: CellType.black },
			Player { celltype: CellType.white }
		]
	}
}

pub fn (game Game) is_finished() bool {
	return is_full(game.board)
}

pub fn current_player (game Game) Player {
	return game.players[game.player_index]
}

pub fn other_player (game Game) Player {
	return game.players[if game.player_index == 1 { 0 } else { 1 }]
}

pub fn get_winner (game Game) ?Player {
	first_player_score := get_score_by_celltype(game.board, game.players[0].celltype)
	second_player_score := get_score_by_celltype(game.board, game.players[1].celltype)

	if first_player_score == second_player_score {
		return none
	}

	if first_player_score < second_player_score {
		return game.players[1]
	}

	return game.players[0]
}

// pub fn GetScore(game Game) map[player.Player]uint8 {
// 	dist := board.GetCellDistribution(game.Board)
// 	score := make(map[player.Player]uint8, 2)
// 	for _, player := range game.Players {
// 		score[player] = dist[player.CellType]
// 	}
// 	return score
// }

pub fn (mut game Game) switch_player() {
	if game.player_index == 0 {
		game.player_index = 1
	} else {
		game.player_index = 0
	}
}

fn can_player_change_cells(player Player, game Game) bool {
	return get_legal_cell_changes_for_celltype(player.celltype, game.board).len > 0
}



// func askForCellChange(game Game) cell.Cell {

// 	var legalCellChangeChoice int
// 	currentPlayer := GetCurrentPlayer(game)
// 	legalCellChanges := board.GetLegalCellChangesForCellType(currentPlayer.CellType, game.Board)

// 	fmt.Printf("%s, It's our turn !\n", strings.ToUpper(currentPlayer.Name))

// 	if currentPlayer.HumanPlayer {
// 		fmt.Printf("Which position do you choose (0..%d) ? ", len(legalCellChanges)-1)
// 		fmt.Scanf("%d\n", &legalCellChangeChoice)
// 	} else {
// 		legalCellChangeChoice = 0 // todo => AI
// 		fmt.Printf("AI makes his choice ! %d\n", legalCellChangeChoice)
// 	}

// 	return legalCellChanges[legalCellChangeChoice]

// }