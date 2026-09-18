import SwiftUI

struct LessonsView: View {
    
    let lessons = [
        ("¿Qué es el dinero?", "💰", "Aprende para qué sirve el dinero."),
        ("Necesidades y deseos", "🛒", "Descubre la diferencia."),
        ("Aprender a ahorrar", "🐷", "Guarda dinero para tus metas."),
        ("Comprar inteligentemente", "🧠", "Aprende a comparar precios."),
        ("Crear un presupuesto", "📊", "Organiza tu dinero."),
        ("Economía del hogar", "🏠", "Aprende a cuidar tu hogar.")
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Aprende")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text("Descubre nuevas habilidades para tu vida diaria.")
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    
                    ForEach(lessons, id: \.0) { lesson in
                        
                        HStack(spacing: 16) {
                            
                            Text(lesson.1)
                                .font(.system(size: 35))
                            
                            VStack(alignment: .leading, spacing: 5) {
                                
                                Text(lesson.0)
                                    .font(.headline)
                                
                                Text(lesson.2)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.secondary)
                        }
                        .padding()
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                        .shadow(
                            color: .black.opacity(0.06),
                            radius: 8,
                            y: 4
                        )
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .background(Color.blue.opacity(0.05))
            .navigationTitle("Aprender")
        }
    }
}


#Preview {
    LessonsView()
}
