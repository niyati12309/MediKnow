import SwiftUI

struct ProfileView: View {
    let profile = MockData.userProfile
    let settings = MockData.settingsOptions
    @State private var showSignOutAlert = false

    private let iconColorMap: [String: Color] = [
        "red": .red, "blue": .blue, "orange": .orange,
        "green": .green, "purple": .purple, "yellow": Color(red: 0.95, green: 0.75, blue: 0.0)
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    profileHeaderSection
                    statsSection
                    settingsSection
                    aboutSection
                    signOutButton
                }
                .padding(.bottom, 40)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Profile")
            .alert("Sign Out", isPresented: $showSignOutAlert) {
                Button("Cancel", role: .cancel) {}
                Button("Sign Out", role: .destructive) {}
            } message: {
                Text("Are you sure you want to sign out?")
            }
        }
    }

    private var profileHeaderSection: some View {
        VStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color(red: 0.04, green: 0.36, blue: 0.90), Color(red: 0.10, green: 0.52, blue: 0.98)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 90, height: 90)
                    .shadow(color: Color.blue.opacity(0.35), radius: 12, x: 0, y: 6)

                Text(String(profile.name.prefix(1)))
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.white)
            }

            VStack(spacing: 5) {
                Text(profile.name)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.primary)

                Text(profile.email)
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)

                HStack(spacing: 6) {
                    Image(systemName: "checkmark.seal.fill")
                        .font(.system(size: 13))
                        .foregroundColor(.blue)
                    Text("Verified User")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.blue)
                }
                .padding(.top, 2)
            }
        }
        .padding(.top, 8)
    }

    private var statsSection: some View {
        HStack(spacing: 12) {
            StatCard(
                value: "\(profile.totalScans)",
                label: "Total Scans",
                icon: "camera.viewfinder",
                color: .blue
            )
            StatCard(
                value: "\(profile.genuineFound)",
                label: "Genuine",
                icon: "checkmark.shield.fill",
                color: Color(red: 0.20, green: 0.78, blue: 0.35)
            )
            StatCard(
                value: "\(profile.fakeFound)",
                label: "Fake",
                icon: "xmark.shield.fill",
                color: Color(red: 0.95, green: 0.23, blue: 0.23)
            )
        }
        .padding(.horizontal, 16)
    }

    private var settingsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Settings")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.primary)
                .padding(.horizontal, 16)

            VStack(spacing: 2) {
                ForEach(settings) { option in
                    Button {
                    } label: {
                        HStack(spacing: 14) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 9)
                                    .fill((iconColorMap[option.iconColor] ?? .blue).opacity(0.15))
                                    .frame(width: 38, height: 38)
                                Image(systemName: option.icon)
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(iconColorMap[option.iconColor] ?? .blue)
                            }

                            VStack(alignment: .leading, spacing: 2) {
                                Text(option.title)
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(.primary)
                                Text(option.subtitle)
                                    .font(.system(size: 12))
                                    .foregroundColor(.secondary)
                            }

                            Spacer()

                            Image(systemName: "chevron.right")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(.secondary.opacity(0.4))
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(Color(.systemBackground))
                    }
                    .buttonStyle(.plain)

                    if option.id != settings.last?.id {
                        Divider()
                            .padding(.leading, 68)
                            .background(Color(.systemBackground))
                    }
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 18))
            .shadow(color: Color.black.opacity(0.06), radius: 8, x: 0, y: 3)
            .padding(.horizontal, 16)
        }
    }

    private var aboutSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("About")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.primary)
                .padding(.horizontal, 16)

            VStack(spacing: 0) {
                aboutRow(title: "Version", value: "1.0.0", icon: "info.circle.fill", color: .gray)
                Divider().padding(.leading, 68).background(Color(.systemBackground))
                aboutRow(title: "Privacy Policy", value: "", icon: "hand.raised.fill", color: .indigo)
                Divider().padding(.leading, 68).background(Color(.systemBackground))
                aboutRow(title: "Terms of Service", value: "", icon: "doc.text.fill", color: .teal)
            }
            .clipShape(RoundedRectangle(cornerRadius: 18))
            .shadow(color: Color.black.opacity(0.06), radius: 8, x: 0, y: 3)
            .padding(.horizontal, 16)
        }
    }

    private func aboutRow(title: String, value: String, icon: String, color: Color) -> some View {
        Button {
        } label: {
            HStack(spacing: 14) {
                ZStack {
                    RoundedRectangle(cornerRadius: 9)
                        .fill(color.opacity(0.15))
                        .frame(width: 38, height: 38)
                    Image(systemName: icon)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(color)
                }

                Text(title)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.primary)

                Spacer()

                if !value.isEmpty {
                    Text(value)
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                } else {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.secondary.opacity(0.4))
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color(.systemBackground))
        }
        .buttonStyle(.plain)
    }

    private var signOutButton: some View {
        Button {
            showSignOutAlert = true
        } label: {
            HStack(spacing: 8) {
                Image(systemName: "arrow.right.square")
                    .font(.system(size: 16, weight: .semibold))
                Text("Sign Out")
                    .font(.system(size: 16, weight: .semibold))
            }
            .foregroundColor(Color(red: 0.95, green: 0.23, blue: 0.23))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(Color(red: 0.95, green: 0.23, blue: 0.23).opacity(0.10))
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .buttonStyle(.plain)
        .padding(.horizontal, 16)
    }
}

#Preview {
    ProfileView()
}
