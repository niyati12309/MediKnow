import SwiftUI

enum TrustLevel {
    case safe
    case warning
    case danger

    var color: Color {
        switch self {
        case .safe:    return Color(red: 0.20, green: 0.78, blue: 0.35)
        case .warning: return Color(red: 1.00, green: 0.75, blue: 0.00)
        case .danger:  return Color(red: 0.95, green: 0.23, blue: 0.23)
        }
    }

    var label: String {
        switch self {
        case .safe:    return "Genuine"
        case .warning: return "Uncertain"
        case .danger:  return "Fake"
        }
    }

    var icon: String {
        switch self {
        case .safe:    return "checkmark.shield.fill"
        case .warning: return "exclamationmark.triangle.fill"
        case .danger:  return "xmark.shield.fill"
        }
    }

    static func from(score: Int) -> TrustLevel {
        switch score {
        case 75...100: return .safe
        case 40..<75:  return .warning
        default:       return .danger
        }
    }
}

struct CheckDetail: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let icon: String
    let passed: Bool
}

struct ScanResult: Identifiable {
    let id: UUID
    let medicineName: String
    let brand: String
    let trustScore: Int
    let date: Date
    let imageName: String
    let checks: [CheckDetail]

    var trustLevel: TrustLevel {
        TrustLevel.from(score: trustScore)
    }

    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
