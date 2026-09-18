import SwiftUI

enum MiraiColors {

    // MARK: - Base

    /// Fondo principal crema de Mirai Kakebo
    static let background = Color(
        red: 0.957,
        green: 0.910,
        blue: 0.886
    )

    /// Azul índigo principal
    static let primary = Color(
        red: 0.063,
        green: 0.125,
        blue: 0.251
    )

    // MARK: - Brand Colors

    /// Naranja Mirai
    static let orange = Color(
        red: 0.949,
        green: 0.541,
        blue: 0.125
    )

    /// Rosa Sakura
    static let sakura = Color(
        red: 0.914,
        green: 0.541,
        blue: 0.604
    )

    /// Verde Matcha
    static let matcha = Color(
        red: 0.553,
        green: 0.733,
        blue: 0.510
    )

    /// Lavanda
    static let lavender = Color(
        red: 0.725,
        green: 0.627,
        blue: 0.851
    )

    /// Amarillo para XP y recompensas
    static let yellow = Color(
        red: 0.957,
        green: 0.788,
        blue: 0.212
    )

    /// Dorado para monedas y logros
    static let gold = Color(
        red: 0.784,
        green: 0.529,
        blue: 0.196
    )

    // MARK: - Semantic Colors

    /// Dinero
    static let money = gold

    /// Ahorro
    static let savings = matcha

    /// Educación
    static let education = lavender

    /// Diversión
    static let fun = yellow

    /// Necesidades
    static let needs = matcha

    /// Otros
    static let other = sakura

    /// Error / alerta
    static let warning = orange

    /// Éxito
    static let success = matcha

    // MARK: - Surfaces

    static let card = Color.white

    static let secondaryBackground =
        Color.white.opacity(0.72)

    static let softPrimary =
        primary.opacity(0.08)

    static let softOrange =
        orange.opacity(0.14)

    static let softSakura =
        sakura.opacity(0.14)

    static let softMatcha =
        matcha.opacity(0.16)

    static let softLavender =
        lavender.opacity(0.16)

    static let softYellow =
        yellow.opacity(0.18)

    // MARK: - Text

    static let textPrimary =
        primary

    static let textSecondary =
        primary.opacity(0.65)

    static let textTertiary =
        primary.opacity(0.45)
}
