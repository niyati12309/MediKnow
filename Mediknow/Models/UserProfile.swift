import Foundation

struct UserProfile {
    let name: String
    let email: String
    let totalScans: Int
    let genuineFound: Int
    let fakeFound: Int

    var accuracyRate: Int {
        guard totalScans > 0 else { return 0 }
        return Int((Double(genuineFound) / Double(totalScans)) * 100)
    }
}

struct SettingsOption: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let icon: String
    let iconColor: String
}
