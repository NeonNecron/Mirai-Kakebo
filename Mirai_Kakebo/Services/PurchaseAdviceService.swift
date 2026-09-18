import Foundation

struct PurchaseAdviceService {
    
    static let shared = PurchaseAdviceService()
    
    private init() {}
    
    func generateAdvice(
        products: [Product],
        total: Double
    ) -> String {
        
        let needs = products.filter {
            $0.isNeed
        }
        
        let wants = products.filter {
            !$0.isNeed
        }
        
        if wants.isEmpty {
            
            return """
            ¡Muy bien! 🌟 Elegiste principalmente necesidades. \
            Eso significa que estás pensando en lo que realmente necesitas antes de gastar tu dinero.
            """
        }
        
        if needs.isEmpty {
            
            return """
            Recuerda hacer una pausa antes de comprar. 🧠 \
            Pregúntate: ¿lo necesito realmente o solamente quiero tenerlo?
            """
        }
        
        if total > 250 {
            
            return """
            Tu compra tiene varias cosas interesantes. 🛒 \
            Antes de pagar, revisa si todo cabe dentro de tu presupuesto y decide qué productos son realmente importantes.
            """
        }
        
        if wants.count > needs.count {
            
            return """
            Veo que elegiste varios deseos. 🎮 \
            Está bien disfrutar de algunas cosas, pero primero asegúrate de cubrir tus necesidades.
            """
        }
        
        return """
        ¡Buen trabajo! 💰 \
        Estás aprendiendo a diferenciar entre necesidades y deseos. \
        Antes de comprar, compara tus opciones y piensa si esa compra te ayudará a cumplir tus objetivos.
        """
    }
}
