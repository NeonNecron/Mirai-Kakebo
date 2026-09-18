import SwiftUI

struct AddExpenseView: View {
    
    @Environment(\.dismiss)
    private var dismiss
    
    @Bindable var viewModel: KakeboViewModel
    
    @State private var amount = ""
    @State private var description = ""
    
    var body: some View {
        NavigationStack {
            
            Form {
                
                Section("Gasto") {
                    
                    TextField(
                        "¿En qué gastaste?",
                        text: $description
                    )
                    
                    TextField(
                        "Cantidad",
                        text: $amount
                    )
                    .keyboardType(.decimalPad)
                }
                
                Section {
                    
                    Button {
                        saveExpense()
                    } label: {
                        HStack {
                            Spacer()
                            
                            Image(
                                systemName: "plus.circle.fill"
                            )
                            
                            Text("Agregar gasto")
                                .fontWeight(.bold)
                            
                            Spacer()
                        }
                    }
                    .disabled(
                        description.isEmpty ||
                        Double(amount) == nil ||
                        Double(amount)! <= 0
                    )
                }
            }
            .navigationTitle("Nuevo gasto")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItem(
                    placement: .cancellationAction
                ) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func saveExpense() {
        
        guard let value = Double(amount),
              value > 0
        else {
            return
        }
        
        viewModel.addExpense(
            amount: value,
            description: description
        )
        
        dismiss()
    }
}

#Preview {
    AddExpenseView(
        viewModel: KakeboViewModel()
    )
}
