import Foundation
import Observation

@Observable
final class LessonsViewModel {
    
    private let persistence = PersistenceService.shared
    
    var lessons: [Lesson] = []
    var completedLessonIDs: Set<UUID>
    
    init() {
        completedLessonIDs = Set(
            persistence.loadCompletedLessons()
        )
        
        loadLessons()
    }
    
    func loadLessons() {
        lessons = [
            Lesson(
                title: "¿Qué es el dinero?",
                description: "Descubre para qué utilizamos el dinero.",
                content: """
                El dinero nos ayuda a comprar las cosas que necesitamos y queremos.
                
                También podemos guardar una parte de nuestro dinero para utilizarla en el futuro.
                
                Recuerda:
                
                🪙 El dinero tiene un valor.
                🛒 Podemos utilizarlo para comprar.
                🐷 Podemos guardarlo para después.
                """,
                emoji: "🪙",
                duration: 5,
                xpReward: 50
            ),
            
            Lesson(
                title: "Necesidades y deseos",
                description: "Aprende a distinguir entre lo necesario y lo que queremos.",
                content: """
                Una necesidad es algo importante para vivir y estar bien.
                
                Por ejemplo:
                
                🍎 Comida
                🏠 Una casa
                👕 Ropa
                
                Un deseo es algo que queremos, pero podemos vivir sin ello.
                
                Por ejemplo:
                
                🎮 Un videojuego
                🍭 Un dulce
                🧸 Un juguete
                """,
                emoji: "🛒",
                duration: 7,
                xpReward: 60
            ),
            
            Lesson(
                title: "El poder del ahorro",
                description: "Descubre por qué guardar dinero es importante.",
                content: """
                Ahorrar significa guardar una parte de nuestro dinero para utilizarla más adelante.
                
                Podemos ahorrar para:
                
                🎯 Alcanzar una meta.
                🚨 Estar preparados para una emergencia.
                🎁 Comprar algo importante.
                
                ¡Cada pequeña cantidad cuenta!
                """,
                emoji: "🐷",
                duration: 6,
                xpReward: 75
            ),
            
            Lesson(
                title: "Planifica tus gastos",
                description: "Aprende a pensar antes de gastar.",
                content: """
                Antes de gastar dinero podemos preguntarnos:
                
                1. ¿Realmente lo necesito?
                2. ¿Tengo suficiente dinero?
                3. ¿Tengo una meta para mi dinero?
                
                Pensar antes de comprar nos ayuda a tomar mejores decisiones.
                """,
                emoji: "🧠",
                duration: 8,
                xpReward: 80
            )
        ]
    }
    
    func isCompleted(
        _ lesson: Lesson
    ) -> Bool {
        completedLessonIDs.contains(
            lesson.id
        )
    }
    
    func completeLesson(
        _ lesson: Lesson
    ) {
        guard !completedLessonIDs.contains(lesson.id) else {
            return
        }
        
        completedLessonIDs.insert(
            lesson.id
        )
        
        persistence.saveCompletedLessons(
            Array(completedLessonIDs)
        )
    }
}
