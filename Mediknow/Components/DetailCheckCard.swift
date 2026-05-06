import SwiftUI

struct DetailCheckCard: View {
    let check: CheckDetail

    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(statusColor.opacity(0.12))
                    .frame(width: 46, height: 46)

                Image(systemName: check.icon)
                    .font(.system(size: 20))
                    .foregroundColor(statusColor)
            }

            VStack(alignment: .leading, spacing: 3) {
                HStack {
                    Text(check.title)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.primary)

                    Spacer()

                    Image(systemName: check.passed ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .foregroundColor(statusColor)
                        .font(.system(size: 16))
                }

                Text(check.description)
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
        }
        .padding(14)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.06), radius: 8, x: 0, y: 3)
    }

    private var statusColor: Color {
        check.passed ? Color(red: 0.20, green: 0.78, blue: 0.35) : Color(red: 0.95, green: 0.23, blue: 0.23)
    }
}

#Preview {
    VStack(spacing: 10) {
        DetailCheckCard(check: MockData.scanResults[0].checks[0])
        DetailCheckCard(check: MockData.scanResults[1].checks[1])
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
