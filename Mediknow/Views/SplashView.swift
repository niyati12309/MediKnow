import SwiftUI

struct SplashView: View {
    @State private var logoScale: CGFloat = 0.6
    @State private var logoOpacity: Double = 0
    @State private var textOpacity: Double = 0
    @State private var taglineOffset: CGFloat = 20

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.04, green: 0.36, blue: 0.90),
                    Color(red: 0.02, green: 0.22, blue: 0.60)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 24) {
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.15))
                        .frame(width: 120, height: 120)

                    Circle()
                        .fill(Color.white.opacity(0.10))
                        .frame(width: 150, height: 150)

                    Image(systemName: "cross.vial.fill")
                        .font(.system(size: 52, weight: .semibold))
                        .foregroundColor(.white)
                }
                .scaleEffect(logoScale)
                .opacity(logoOpacity)

                VStack(spacing: 10) {
                    Text("Mediknow")
                        .font(.system(size: 38, weight: .bold, design: .rounded))
                        .foregroundColor(.white)

                    Text("When in doubt, scan it out")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white.opacity(0.75))
                        .offset(y: taglineOffset)
                }
                .opacity(textOpacity)
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.7, dampingFraction: 0.65)) {
                logoScale = 1.0
                logoOpacity = 1.0
            }
            withAnimation(.easeOut(duration: 0.6).delay(0.35)) {
                textOpacity = 1.0
                taglineOffset = 0
            }
        }
    }
}

#Preview {
    SplashView()
}
