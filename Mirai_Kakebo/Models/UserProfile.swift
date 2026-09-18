import Foundation

struct UserProfile: Codable {
    
    var name: String
    var avatarName: String
    var favoriteColor: String
    
    init(
        name: String = "Pequeño aprendiz",
        avatarName: String = "fox",
        favoriteColor: String = "purple"
    ) {
        self.name = name
        self.avatarName = avatarName
        self.favoriteColor = favoriteColor
    }
}
