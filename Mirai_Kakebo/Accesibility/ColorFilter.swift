import SwiftUI

enum ColorFilter: String, CaseIterable, Codable, Identifiable {

    case normal
    case grayscale
    case redGreen
    case greenRed
    case blueYellow

    var id: String {
        rawValue
    }

    // MARK: - Nombre mostrado

    var title: String {
        switch self {
        case .normal:
            return "Normal"

        case .grayscale:
            return "Escala de grises"

        case .redGreen:
            return "Rojo–Verde"

        case .greenRed:
            return "Verde–Rojo"

        case .blueYellow:
            return "Azul–Amarillo"
        }
    }

    // MARK: - Descripción

    var description: String {
        switch self {
        case .normal:
            return "Colores originales de Mirai Kakebo."

        case .grayscale:
            return "Reduce los colores para facilitar la percepción de formas, texto y contraste."

        case .redGreen:
            return "Ayuda a distinguir elementos que utilizan principalmente tonos rojos y verdes."

        case .greenRed:
            return "Ajusta la percepción visual de tonos verdes y rojos."

        case .blueYellow:
            return "Ajusta la percepción visual de tonos azules y amarillos."
        }
    }

    // MARK: - Icono

    var systemImage: String {
        switch self {
        case .normal:
            return "paintpalette.fill"

        case .grayscale:
            return "circle.lefthalf.filled"

        case .redGreen:
            return "eye.fill"

        case .greenRed:
            return "eye.circle.fill"

        case .blueYellow:
            return "eyeglasses"
        }
    }

    // MARK: - Accesibilidad

    var accessibilityLabel: String {
        "Filtro de color: \(title)"
    }
}
