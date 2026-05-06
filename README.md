# Mediknow

> **"When in doubt, scan it out"**

Mediknow is a modern app that helps users verify medicine authenticity by scanning packaging and checking trust scores.

## Features

- **Medicine Scanner** — a camera scan or image upload
- **Trust Score** — Color-coded percentage (Green / Yellow / Red)
- **Verification Details** — QR Code Check, Packaging Analysis, OCR Text Match
- **Scan History** — Searchable, filterable list of past scans
- **User Profile** — Stats, settings, and about section

---

## Tech Stack

- **Language:** Swift 5.9+
- **UI Framework:** SwiftUI (iOS 17+)
- **Navigation:** NavigationStack
- **Icons:** SF Symbols

---

## Project Structure

```
Mediknow/
├── MediknowApp.swift          
├── Models/
│   ├── ScanResult.swift       
│   └── UserProfile.swift      
├── Data/
│   └── MockData.swift         
├── Components/
│   ├── ScoreBadge.swift       
│   ├── MedicineCard.swift     
│   ├── DetailCheckCard.swift  
│   └── StatCard.swift        
└── Views/
    ├── ContentView.swift    
    ├── SplashView.swift       
    ├── HomeView.swift         
    ├── ScanResultView.swift  
    ├── HistoryView.swift      
    └── ProfileView.swift      
```

---

## Getting Started

### Requirements

- macOS 13.0+
- Xcode 15.0+
- iOS 17.0+ Simulator or Device

### Setup Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/mediknow.git
   cd mediknow
   ```

2. **Create a new Xcode project**
   - Open Xcode → **File → New → Project**
   - Choose **iOS → App**
   - Set **Product Name** to `Mediknow`
   - Set **Interface** to `SwiftUI`
   - Set **Language** to `Swift`
   - Set **Minimum Deployments** to `iOS 17.0`
   - Save the project inside the `Mediknow/` folder

3. **Add the source files**
   - In Xcode's Project Navigator, right-click and choose **Add Files to "Mediknow"**
   - Select all folders: `Models/`, `Data/`, `Components/`, `Views/`
   - Also add `MediknowApp.swift` (replace the default one created by Xcode)
   - Make sure **"Copy items if needed"** is unchecked (files are already in place)

4. **Delete the default generated files** from Xcode if they conflict (e.g., the default `ContentView.swift`)

5. **Build and Run** — Press `⌘R` to build and run on the Simulator

---

## Trust Score Color Coding

| Score Range | Level      | Color  |
|-------------|------------|--------|
| 75 – 100    | Genuine    | Green  |
| 40 – 74     | Uncertain  | Yellow |
| 0 – 39      | Fake       | Red    |

---

## License

MIT License — feel free to use, modify, and distribute.
