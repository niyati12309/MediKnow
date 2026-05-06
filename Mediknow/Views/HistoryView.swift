import SwiftUI

struct HistoryView: View {
    @State private var searchText = ""
    @State private var selectedFilter: FilterOption = .all
    @State private var selectedResult: ScanResult?
    @State private var showDetail = false

    enum FilterOption: String, CaseIterable {
        case all = "All"
        case genuine = "Genuine"
        case uncertain = "Uncertain"
        case fake = "Fake"

        var trustRange: ClosedRange<Int>? {
            switch self {
            case .all:       return nil
            case .genuine:   return 75...100
            case .uncertain: return 40...74
            case .fake:      return 0...39
            }
        }
    }

    private var filteredResults: [ScanResult] {
        var results = MockData.scanResults

        if !searchText.isEmpty {
            results = results.filter {
                $0.medicineName.localizedCaseInsensitiveContains(searchText) ||
                $0.brand.localizedCaseInsensitiveContains(searchText)
            }
        }

        if let range = selectedFilter.trustRange {
            results = results.filter { range.contains($0.trustScore) }
        }

        return results
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                filterBar

                if filteredResults.isEmpty {
                    emptyState
                } else {
                    ScrollView {
                        LazyVStack(spacing: 10) {
                            ForEach(filteredResults) { result in
                                Button {
                                    selectedResult = result
                                    showDetail = true
                                } label: {
                                    historyRow(result: result)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 14)
                        .padding(.bottom, 32)
                    }
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Scan History")
            .searchable(text: $searchText, prompt: "Search medicines...")
            .navigationDestination(isPresented: $showDetail) {
                if let result = selectedResult {
                    ScanResultView(result: result)
                }
            }
        }
    }

    private var filterBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(FilterOption.allCases, id: \.self) { option in
                    Button {
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
                            selectedFilter = option
                        }
                    } label: {
                        Text(option.rawValue)
                            .font(.system(size: 13, weight: selectedFilter == option ? .bold : .medium))
                            .foregroundColor(selectedFilter == option ? .white : .secondary)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(
                                selectedFilter == option
                                    ? Color.blue
                                    : Color(.systemBackground)
                            )
                            .clipShape(Capsule())
                            .shadow(color: selectedFilter == option ? Color.blue.opacity(0.3) : Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .background(Color(.systemGroupedBackground))
    }

    private func historyRow(result: ScanResult) -> some View {
        HStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(result.trustLevel.color.opacity(0.12))
                    .frame(width: 48, height: 48)
                Image(systemName: result.imageName)
                    .font(.system(size: 22))
                    .foregroundColor(result.trustLevel.color)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(result.medicineName)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.primary)
                    .lineLimit(1)

                HStack(spacing: 6) {
                    Image(systemName: "calendar")
                        .font(.system(size: 11))
                        .foregroundColor(.secondary)
                    Text(result.formattedDate)
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                }
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 6) {
                ScoreBadge(score: result.trustScore, size: .small)

                Text(result.trustLevel.label)
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(result.trustLevel.color)
            }

            Image(systemName: "chevron.right")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.secondary.opacity(0.4))
        }
        .padding(14)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(color: Color.black.opacity(0.06), radius: 8, x: 0, y: 3)
    }

    private var emptyState: some View {
        VStack(spacing: 16) {
            Spacer()
            Image(systemName: "magnifyingglass.circle")
                .font(.system(size: 60))
                .foregroundColor(.secondary.opacity(0.4))
            Text("No results found")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.secondary)
            Text("Try adjusting your search or filter")
                .font(.system(size: 14))
                .foregroundColor(.secondary.opacity(0.7))
            Spacer()
        }
    }
}

#Preview {
    HistoryView()
}
