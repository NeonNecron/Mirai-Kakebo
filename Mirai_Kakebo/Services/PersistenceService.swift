import Foundation

final class PersistenceService {
    
    static let shared = PersistenceService()
    
    private init() {}
    
    private let profileKey = "mirai.userProfile"
    private let progressKey = "mirai.userProgress"
    private let expensesKey = "mirai.expenses"
    private let completedLessonsKey = "mirai.completedLessons"
    
    // MARK: - Generic Save
    
    private func save<T: Encodable>(
        _ value: T,
        forKey key: String
    ) {
        do {
            let data = try JSONEncoder().encode(value)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print("Error guardando \(key): \(error)")
        }
    }
    
    private func load<T: Decodable>(
        _ type: T.Type,
        forKey key: String
    ) -> T? {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return nil
        }
        
        do {
            return try JSONDecoder().decode(type, from: data)
        } catch {
            print("Error cargando \(key): \(error)")
            return nil
        }
    }
    
    // MARK: - Profile
    
    func saveProfile(_ profile: UserProfile) {
        save(profile, forKey: profileKey)
    }
    
    func loadProfile() -> UserProfile {
        load(
            UserProfile.self,
            forKey: profileKey
        ) ?? UserProfile()
    }
    
    // MARK: - Progress
    
    func saveProgress(_ progress: UserProgress) {
        save(progress, forKey: progressKey)
    }
    
    func loadProgress() -> UserProgress {
        load(
            UserProgress.self,
            forKey: progressKey
        ) ?? UserProgress()
    }
    
    // MARK: - Expenses
    
    func saveExpenses(_ expenses: [Expense]) {
        save(expenses, forKey: expensesKey)
    }
    
    func loadExpenses() -> [Expense] {
        load(
            [Expense].self,
            forKey: expensesKey
        ) ?? []
    }
    
    // MARK: - Lessons
    
    func saveCompletedLessons(_ ids: [UUID]) {
        save(ids, forKey: completedLessonsKey)
    }
    
    func loadCompletedLessons() -> [UUID] {
        load(
            [UUID].self,
            forKey: completedLessonsKey
        ) ?? []
    }
}
