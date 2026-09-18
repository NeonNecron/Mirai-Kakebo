import SwiftUI

struct KakeboView: View {
    
    @State private var viewModel = KakeboViewModel()
    
    @State private var showingExpense = false
    @State private var showingIncome = false
    
    var body: some View {
        NavigationStack {
            
            ScrollView {
                
                VStack(spacing: 20) {
                    
                    // MARK: - Header
                    
                    VStack(spacing: 8) {
                        
                        Text("Mi Kakebo")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text("Organiza tu dinero")
                            .foregroundStyle(.secondary)
                    }
                    
                    // MARK: - Balance
                    
                    VStack(spacing: 8) {
                        
                        Text("Dinero disponible")
                            .font(.headline)
                        
                        Text(
                            "$\(viewModel.balance, specifier: "%.2f")"
                        )
                        .font(
                            .system(
                                size: 42,
                                weight: .bold
                            )
                        )
                        .foregroundStyle(
                            viewModel.balance >= 0
                            ? .green
                            : .red
                        )
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 30)
                    .background(.white)
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius: 25
                        )
                    )
                    .shadow(
                        color: .black.opacity(0.08),
                        radius: 10,
                        y: 5
                    )
                    
                    // MARK: - Financial Cards
                    
                    FinancialCard(
                        title: "Ingresos",
                        amount: viewModel.income,
                        icon: "arrow.down.circle.fill",
                        color: .green
                    )
                    
                    FinancialCard(
                        title: "Gastos",
                        amount: viewModel.expenses,
                        icon: "arrow.up.circle.fill",
                        color: .red
                    )
                    
                    // MARK: - Buttons
                    
                    HStack(spacing: 12) {
                        
                        Button {
                            showingIncome = true
                        } label: {
                            Label(
                                "Agregar ingreso",
                                systemImage: "plus.circle.fill"
                            )
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                        }
                        .buttonStyle(
                            .borderedProminent
                        )
                        .tint(.green)
                        
                        Button {
                            showingExpense = true
                        } label: {
                            Label(
                                "Agregar gasto",
                                systemImage: "minus.circle.fill"
                            )
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                        }
                        .buttonStyle(
                            .borderedProminent
                        )
                        .tint(.red)
                    }
                    
                    // MARK: - Chart
                    
                    FinancialChartView(
                        income: viewModel.income,
                        expenses: viewModel.expenses
                    )
                    
                    // MARK: - Recent Transactions
                    
                    if !viewModel.incomeTransactions.isEmpty ||
                        !viewModel.expenseTransactions.isEmpty {
                        
                        transactionsSection
                    }
                }
                .padding()
            }
            .background(
                Color.green.opacity(0.05)
                    .ignoresSafeArea()
            )
            .navigationTitle("Kakebo")
            
            // MARK: - Sheets
            
            .sheet(
                isPresented: $showingExpense
            ) {
                AddExpenseView(
                    viewModel: viewModel
                )
            }
            
            .sheet(
                isPresented: $showingIncome
            ) {
                AddIncomeView(
                    viewModel: viewModel
                )
            }
        }
    }
    
    // MARK: - Transactions
    
    private var transactionsSection: some View {
        VStack(
            alignment: .leading,
            spacing: 12
        ) {
            
            Text("Movimientos recientes")
                .font(.title3)
                .fontWeight(.bold)
            
            ForEach(
                viewModel.incomeTransactions
            ) { transaction in
                
                transactionRow(
                    transaction
                )
            }
            
            ForEach(
                viewModel.expenseTransactions
            ) { transaction in
                
                transactionRow(
                    transaction
                )
            }
        }
    }
    
    private func transactionRow(
        _ transaction: KakeboTransaction
    ) -> some View {
        
        HStack {
            
            Image(
                systemName:
                    transaction.type == .income
                    ? "arrow.down.circle.fill"
                    : "arrow.up.circle.fill"
            )
            .foregroundStyle(
                transaction.type == .income
                ? .green
                : .red
            )
            
            Text(transaction.description)
            
            Spacer()
            
            Text(
                transaction.type == .income
                ? "+$\(transaction.amount, specifier: "%.2f")"
                : "-$\(transaction.amount, specifier: "%.2f")"
            )
            .fontWeight(.bold)
            .foregroundStyle(
                transaction.type == .income
                ? .green
                : .red
            )
        }
        .padding()
        .background(.white)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 16
            )
        )
    }
}

// MARK: - Financial Card

struct FinancialCard: View {
    
    let title: String
    let amount: Double
    let icon: String
    let color: Color
    
    var body: some View {
        HStack {
            
            Image(systemName: icon)
                .font(.title)
                .foregroundStyle(color)
            
            VStack(
                alignment: .leading
            ) {
                
                Text(title)
                    .font(.headline)
                
                Text(
                    "$\(amount, specifier: "%.2f")"
                )
                .font(.title3)
                .fontWeight(.bold)
            }
            
            Spacer()
        }
        .padding()
        .background(.white)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 18
            )
        )
    }
}

#Preview {
    KakeboView()
}
