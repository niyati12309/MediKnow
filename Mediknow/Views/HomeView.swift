import SwiftUI

struct HomeView: View {
    @State private var selectedResult: ScanResult?
    @State private var showScanResult = false
    @State private var scanButtonPressed = false
    @State private var uploadButtonPressed = false

    private let recentScans = Array(MockData.scanResults.prefix(3))

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    headerSection
                    actionButtonsSection
                    recentScansSection
                }
                .padding(.bottom, 32)
            }
            .background(Color(.systemGroupedBackground))
            .navigationDestination(isPresented: $showScanResult) {
                if let result = selectedResult {
                    ScanResultView(result: result)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "bell.badge")
                        .foregroundColor(.blue)
                        .font(.system(size: 18))
                }
            }
        }
    }

    private var headerSection: some View {
        ZStack(alignment: .bottom) {
            LinearGradient(
                colors: [
                    Color(red: 0.04, green: 0.36, blue: 0.90),
                    Color(red: 0.10, green: 0.52, blue: 0.98)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .frame(height: 190)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .ignoresSafeArea(edges: .top)

            VStack(alignment: .leading, spacing: 6) {
                Text("Good Morning 👋")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.white.opacity(0.80))

                Text("Verify your medicine\nsafety today")
                    .font(.system(size: 26, weight: .bold))
                    .foregroundColor(.white)
                    .lineSpacing(2)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 24)
            .padding(.bottom, 28)
        }
        .padding(.horizontal, 16)
    }

    private var actionButtonsSection: some View {
        VStack(spacing: 14) {
            Button {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    scanButtonPressed = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                    scanButtonPressed = false
                    selectedResult = MockData.scanResults[0]
                    showScanResult = true
                }
            } label: {
                HStack(spacing: 14) {
                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.20))
                            .frame(width: 52, height: 52)
                        Image(systemName: "camera.viewfinder")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(.white)
                    }

                    VStack(alignment: .leading, spacing: 3) {
                        Text("Scan Medicine")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                        Text("Point camera at packaging")
                            .font(.system(size: 13))
                            .foregroundColor(.white.opacity(0.75))
                    }

                    Spacer()

                    Image(systemName: "chevron.right")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white.opacity(0.70))
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                .background(
                    LinearGradient(
                        colors: [Color(red: 0.04, green: 0.36, blue: 0.90), Color(red: 0.10, green: 0.52, blue: 0.98)],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(color: Color(red: 0.04, green: 0.36, blue: 0.90).opacity(0.4), radius: 14, x: 0, y: 6)
            }
            .scaleEffect(scanButtonPressed ? 0.96 : 1.0)
            .buttonStyle(.plain)

            Button {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    uploadButtonPressed = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                    uploadButtonPressed = false
                    selectedResult = MockData.scanResults[2]
                    showScanResult = true
                }
            } label: {
                HStack(spacing: 14) {
                    ZStack {
                        Circle()
                            .fill(Color.blue.opacity(0.10))
                            .frame(width: 52, height: 52)
                        Image(systemName: "photo.badge.plus")
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundColor(.blue)
                    }

                    VStack(alignment: .leading, spacing: 3) {
                        Text("Upload Image")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.primary)
                        Text("From photo library")
                            .font(.system(size: 13))
                            .foregroundColor(.secondary)
                    }

                    Spacer()

                    Image(systemName: "chevron.right")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.secondary.opacity(0.5))
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                .background(Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(color: Color.black.opacity(0.07), radius: 10, x: 0, y: 4)
            }
            .scaleEffect(uploadButtonPressed ? 0.96 : 1.0)
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 16)
    }

    private var recentScansSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text("Recent Scans")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.primary)
                Spacer()
                Text("See All")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.blue)
            }
            .padding(.horizontal, 16)

            VStack(spacing: 10) {
                ForEach(recentScans) { result in
                    Button {
                        selectedResult = result
                        showScanResult = true
                    } label: {
                        MedicineCard(result: result, compact: true)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    HomeView()
}
