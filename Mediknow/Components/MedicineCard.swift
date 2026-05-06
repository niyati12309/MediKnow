import SwiftUI

struct MedicineCard: View {
    let result: ScanResult
    var compact: Bool = false

    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(result.trustLevel.color.opacity(0.12))
                    .frame(width: 54, height: 54)

                Image(systemName: result.imageName)
                    .font(.system(size: 24))
                    .foregroundColor(result.trustLevel.color)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(result.medicineName)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.primary)
                    .lineLimit(1)

                Text(result.brand)
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)

                if !compact {
                    Text(result.formattedDate)
                        .font(.system(size: 12))
                        .foregroundColor(.secondary.opacity(0.8))
                }
            }

            Spacer()

            ScoreBadge(score: result.trustScore, size: compact ? .small : .medium)
        }
        .padding(14)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(color: Color.black.opacity(0.07), radius: 10, x: 0, y: 4)
    }
}

#Preview {
    VStack(spacing: 12) {
        MedicineCard(result: MockData.scanResults[0])
        MedicineCard(result: MockData.scanResults[1], compact: true)
        MedicineCard(result: MockData.scanResults[3])
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
