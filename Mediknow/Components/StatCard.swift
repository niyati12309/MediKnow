import SwiftUI

struct StatCard: View {
    let value: String
    let label: String
    let icon: String
    let color: Color

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.15))
                    .frame(width: 44, height: 44)
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(color)
            }

            Text(value)
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.primary)

            Text(label)
                .font(.system(size: 12))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(color: Color.black.opacity(0.06), radius: 8, x: 0, y: 3)
    }
}

#Preview {
    HStack(spacing: 12) {
        StatCard(value: "47", label: "Total Scans", icon: "camera.viewfinder", color: .blue)
        StatCard(value: "41", label: "Genuine", icon: "checkmark.shield", color: .green)
        StatCard(value: "6", label: "Fake", icon: "xmark.shield", color: .red)
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
