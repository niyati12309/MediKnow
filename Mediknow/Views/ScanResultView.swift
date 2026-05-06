import SwiftUI

struct ScanResultView: View {
    let result: ScanResult
    @State private var scoreAnimated: Bool = false
    @State private var cardsVisible: Bool = false
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            VStack(spacing: 22) {
                imagePlaceholderSection
                trustScoreSection
                checksSection
                actionSection
            }
            .padding(.bottom, 40)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Scan Result")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            withAnimation(.spring(response: 0.8, dampingFraction: 0.7).delay(0.2)) {
                scoreAnimated = true
            }
            withAnimation(.easeOut(duration: 0.5).delay(0.5)) {
                cardsVisible = true
            }
        }
    }

    private var imagePlaceholderSection: some View {
        ZStack {
            LinearGradient(
                colors: [result.trustLevel.color.opacity(0.15), result.trustLevel.color.opacity(0.05)],
                startPoint: .top,
                endPoint: .bottom
            )

            VStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(result.trustLevel.color.opacity(0.18))
                        .frame(width: 110, height: 110)

                    Image(systemName: result.imageName)
                        .font(.system(size: 52))
                        .foregroundColor(result.trustLevel.color)
                }

                VStack(spacing: 4) {
                    Text(result.medicineName)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.primary)
                    Text(result.brand)
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                }
            }
            .padding(.vertical, 32)
        }
        .clipShape(RoundedRectangle(cornerRadius: 28))
        .padding(.horizontal, 16)
        .padding(.top, 8)
        .shadow(color: result.trustLevel.color.opacity(0.15), radius: 14, x: 0, y: 6)
    }

    private var trustScoreSection: some View {
        VStack(spacing: 16) {
            ZStack {
                Circle()
                    .stroke(Color(.systemGray5), lineWidth: 14)
                    .frame(width: 150, height: 150)

                Circle()
                    .trim(from: 0, to: scoreAnimated ? CGFloat(result.trustScore) / 100 : 0)
                    .stroke(result.trustLevel.color, style: StrokeStyle(lineWidth: 14, lineCap: .round))
                    .frame(width: 150, height: 150)
                    .rotationEffect(.degrees(-90))
                    .animation(.spring(response: 1.2, dampingFraction: 0.8).delay(0.2), value: scoreAnimated)

                VStack(spacing: 4) {
                    Text("\(result.trustScore)%")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundColor(.primary)
                    Text("Trust Score")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.secondary)
                }
            }

            HStack(spacing: 10) {
                Image(systemName: result.trustLevel.icon)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(result.trustLevel.color)

                Text(result.trustLevel.label)
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(result.trustLevel.color)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 10)
            .background(result.trustLevel.color.opacity(0.12))
            .clipShape(Capsule())

            Text("Scanned on \(result.formattedDate)")
                .font(.system(size: 13))
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 10)
    }

    private var checksSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Verification Details")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.primary)
                .padding(.horizontal, 16)

            VStack(spacing: 10) {
                ForEach(Array(result.checks.enumerated()), id: \.element.id) { index, check in
                    DetailCheckCard(check: check)
                        .opacity(cardsVisible ? 1 : 0)
                        .offset(y: cardsVisible ? 0 : 20)
                        .animation(.easeOut(duration: 0.4).delay(Double(index) * 0.1 + 0.5), value: cardsVisible)
                }
            }
            .padding(.horizontal, 16)
        }
    }

    private var actionSection: some View {
        VStack(spacing: 12) {
            Button {
                dismiss()
            } label: {
                Label("Scan Another", systemImage: "camera.viewfinder")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(
                        LinearGradient(
                            colors: [Color(red: 0.04, green: 0.36, blue: 0.90), Color(red: 0.10, green: 0.52, blue: 0.98)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(color: Color.blue.opacity(0.35), radius: 10, x: 0, y: 5)
            }
            .buttonStyle(.plain)

            Button {
            } label: {
                Label("Share Result", systemImage: "square.and.arrow.up")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.blue)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color(.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(color: Color.black.opacity(0.06), radius: 8, x: 0, y: 3)
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    NavigationStack {
        ScanResultView(result: MockData.scanResults[0])
    }
}
