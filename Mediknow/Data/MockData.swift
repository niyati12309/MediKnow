import Foundation

struct MockData {

    static let scanResults: [ScanResult] = [
        ScanResult(
            id: UUID(),
            medicineName: "Paracetamol 500mg",
            brand: "Panadol",
            trustScore: 92,
            date: Date().addingTimeInterval(-3600),
            imageName: "pill.fill",
            checks: [
                CheckDetail(title: "QR Code Check", description: "QR code matches manufacturer database", icon: "qrcode.viewfinder", passed: true),
                CheckDetail(title: "Packaging Analysis", description: "Hologram and seal verified successfully", icon: "shippingbox.fill", passed: true),
                CheckDetail(title: "OCR Text Match", description: "All printed text matches official records", icon: "text.viewfinder", passed: true)
            ]
        ),
        ScanResult(
            id: UUID(),
            medicineName: "Amoxicillin 250mg",
            brand: "Generic",
            trustScore: 61,
            date: Date().addingTimeInterval(-86400),
            imageName: "capsule.fill",
            checks: [
                CheckDetail(title: "QR Code Check", description: "QR code partially readable", icon: "qrcode.viewfinder", passed: true),
                CheckDetail(title: "Packaging Analysis", description: "Minor inconsistencies found on seal", icon: "shippingbox.fill", passed: false),
                CheckDetail(title: "OCR Text Match", description: "Batch number matches but expiry format is unusual", icon: "text.viewfinder", passed: true)
            ]
        ),
        ScanResult(
            id: UUID(),
            medicineName: "Ibuprofen 400mg",
            brand: "Brufen",
            trustScore: 88,
            date: Date().addingTimeInterval(-172800),
            imageName: "pill.fill",
            checks: [
                CheckDetail(title: "QR Code Check", description: "QR code verified and authentic", icon: "qrcode.viewfinder", passed: true),
                CheckDetail(title: "Packaging Analysis", description: "Packaging integrity confirmed", icon: "shippingbox.fill", passed: true),
                CheckDetail(title: "OCR Text Match", description: "Text content fully validated", icon: "text.viewfinder", passed: true)
            ]
        ),
        ScanResult(
            id: UUID(),
            medicineName: "Metformin 850mg",
            brand: "Glucophage",
            trustScore: 24,
            date: Date().addingTimeInterval(-259200),
            imageName: "cross.vial.fill",
            checks: [
                CheckDetail(title: "QR Code Check", description: "QR code not found or unreadable", icon: "qrcode.viewfinder", passed: false),
                CheckDetail(title: "Packaging Analysis", description: "Seal appears tampered or counterfeit", icon: "shippingbox.fill", passed: false),
                CheckDetail(title: "OCR Text Match", description: "Multiple text mismatches detected", icon: "text.viewfinder", passed: false)
            ]
        ),
        ScanResult(
            id: UUID(),
            medicineName: "Omeprazole 20mg",
            brand: "Losec",
            trustScore: 77,
            date: Date().addingTimeInterval(-345600),
            imageName: "capsule.fill",
            checks: [
                CheckDetail(title: "QR Code Check", description: "QR code valid", icon: "qrcode.viewfinder", passed: true),
                CheckDetail(title: "Packaging Analysis", description: "Packaging consistent with authentic product", icon: "shippingbox.fill", passed: true),
                CheckDetail(title: "OCR Text Match", description: "Minor font discrepancy detected", icon: "text.viewfinder", passed: false)
            ]
        ),
        ScanResult(
            id: UUID(),
            medicineName: "Atorvastatin 10mg",
            brand: "Lipitor",
            trustScore: 95,
            date: Date().addingTimeInterval(-432000),
            imageName: "pill.fill",
            checks: [
                CheckDetail(title: "QR Code Check", description: "QR code fully authenticated", icon: "qrcode.viewfinder", passed: true),
                CheckDetail(title: "Packaging Analysis", description: "Holographic seal and packaging verified", icon: "shippingbox.fill", passed: true),
                CheckDetail(title: "OCR Text Match", description: "100% text match with official database", icon: "text.viewfinder", passed: true)
            ]
        )
    ]

    static let userProfile = UserProfile(
        name: "Alex Johnson",
        email: "alex.johnson@email.com",
        totalScans: 47,
        genuineFound: 41,
        fakeFound: 6
    )

    static let settingsOptions: [SettingsOption] = [
        SettingsOption(title: "Notifications", subtitle: "Scan alerts and updates", icon: "bell.fill", iconColor: "red"),
        SettingsOption(title: "Privacy", subtitle: "Data and permissions", icon: "lock.shield.fill", iconColor: "blue"),
        SettingsOption(title: "Scan History", subtitle: "Manage saved scans", icon: "clock.fill", iconColor: "orange"),
        SettingsOption(title: "Language", subtitle: "English", icon: "globe", iconColor: "green"),
        SettingsOption(title: "Help & Support", subtitle: "FAQ and contact", icon: "questionmark.circle.fill", iconColor: "purple"),
        SettingsOption(title: "Rate Mediknow", subtitle: "Share your experience", icon: "star.fill", iconColor: "yellow")
    ]
}
