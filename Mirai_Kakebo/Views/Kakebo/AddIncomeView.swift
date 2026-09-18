import SwiftUI

struct AddIncomeView: View {
    
    @Environment(\.dismiss)
    private var dismiss
    
    @Bindable var viewModel: KakeboViewModel
    
    @State private var amount = ""
    @State private var description = ""
    
    var body: some View {
        NavigationStack {
            
            Form {
                
                Section("Ingreso") {
                    
                    TextField(
                        "¿De dónde viene el dinero?",
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
                        saveIncome()
                    } label: {
                        HStack {
                            Spacer()
                            
                            Image(
                                systemName: "plus.circle.fill"
                            )
                            
                            Text("Agregar ingreso")
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
            .navigationTitle("Nuevo ingreso")
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
    
    private func saveIncome() {
        
        guard let value = Double(amount),
              value > 0
        else {
            return
        }
        
        viewModel.addIncome(
            amount: value,
            description: description
        )
        
        dismiss()
    }
}

#Preview {
    AddIncomeView(
        viewModel: KakeboViewModel()
    )
}
