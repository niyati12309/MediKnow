import SwiftUI

struct ScoreBadge: View {
    let score: Int
    var size: BadgeSize = .medium

    enum BadgeSize {
        case small, medium, large

        var fontSize: CGFloat {
            switch self {
            case .small:  return 12
            case .medium: return 14
            case .large:  return 18
            }
        }

        var padding: EdgeInsets {
            switch self {
            case .small:  return EdgeInsets(top: 3, leading: 8, bottom: 3, trailing: 8)
            case .medium: return EdgeInsets(top: 5, leading: 12, bottom: 5, trailing: 12)
            case .large:  return EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
            }
        }

        var cornerRadius: CGFloat {
            switch self {
            case .small:  return 8
            case .medium: return 10
            case .large:  return 14
            }
        }
    }

    private var trustLevel: TrustLevel {
        TrustLevel.from(score: score)
    }

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: trustLevel.icon)
                .font(.system(size: size.fontSize - 1, weight: .semibold))
            Text("\(score)%")
                .font(.system(size: size.fontSize, weight: .bold))
        }
        .foregroundColor(.white)
        .padding(size.padding)
        .background(trustLevel.color)
        .clipShape(RoundedRectangle(cornerRadius: size.cornerRadius))
        .shadow(color: trustLevel.color.opacity(0.4), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    HStack(spacing: 12) {
        ScoreBadge(score: 92, size: .small)
        ScoreBadge(score: 61, size: .medium)
        ScoreBadge(score: 24, size: .large)
    }
    .padding()
}
