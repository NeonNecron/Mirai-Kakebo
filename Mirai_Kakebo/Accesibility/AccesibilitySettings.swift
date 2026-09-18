import SwiftUI
import Observation

@Observable
final class AccessibilitySettings {

    // MARK: - Clave de almacenamiento

    private let colorFilterKey = "mirai.colorFilter"

    // MARK: - Configuración

    var colorFilter: ColorFilter {
        didSet {
            saveColorFilter()
        }
    }

    // MARK: - Inicialización

    init() {

        if let savedValue = UserDefaults.standard.string(
            forKey: colorFilterKey
        ),
        let savedFilter = ColorFilter(
            rawValue: savedValue
        ) {

            self.colorFilter = savedFilter

        } else {

            self.colorFilter = .normal
        }
    }

    // MARK: - Guardar

    private func saveColorFilter() {

        UserDefaults.standard.set(
            colorFilter.rawValue,
            forKey: colorFilterKey
        )
    }

    // MARK: - Restablecer

    func resetAccessibilitySettings() {

        colorFilter = .normal
    }
}
