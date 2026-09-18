import Foundation
import Observation

@Observable
final class GameViewModel {
    
    private let gameService = GameService.shared
    
    var games: [Game] = []
    var selectedGame: Game?
    
    init() {
        loadGames()
    }
    
    func loadGames() {
        games = gameService.games
    }
    
    func selectGame(_ game: Game) {
        selectedGame = game
    }
    
    func clearSelection() {
        selectedGame = nil
    }
}
