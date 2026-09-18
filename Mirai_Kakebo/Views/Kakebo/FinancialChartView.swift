import SwiftUI
import Charts

struct FinancialChartView: View {
    
    let income: Double
    let expenses: Double
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 14
        ) {
            
            Text("📊 Mis movimientos")
                .font(.title3)
                .fontWeight(.bold)
            
            Chart {
                
                BarMark(
                    x: .value(
                        "Tipo",
                        "Ingresos"
                    ),
                    y: .value(
                        "Cantidad",
                        income
                    )
                )
                .foregroundStyle(.green)
                
                BarMark(
                    x: .value(
                        "Tipo",
                        "Gastos"
                    ),
                    y: .value(
                        "Cantidad",
                        expenses
                    )
                )
                .foregroundStyle(.red)
            }
            .frame(height: 220)
            
            HStack {
                
                Label(
                    "Ingresos",
                    systemImage: "arrow.down.circle.fill"
                )
                .foregroundStyle(.green)
                
                Spacer()
                
                Label(
                    "Gastos",
                    systemImage: "arrow.up.circle.fill"
                )
                .foregroundStyle(.red)
            }
            .font(.caption)
        }
        .padding()
        .background(.white)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 22
            )
        )
    }
}

#Preview {
    FinancialChartView(
        income: 500,
        expenses: 150
    )
    .padding()
}
