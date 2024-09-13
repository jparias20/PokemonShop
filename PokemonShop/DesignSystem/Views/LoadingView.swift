import SwiftUI

extension View {
    func loadingView(isPresented: Binding<Bool>) -> some View {
        modifier(LoadingViewModifier(isLoading: isPresented))
    }
}

private struct LoadingViewModifier: ViewModifier {
    @Binding var isLoading: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if isLoading {
                LoadingView()
            }
        }
    }
}

struct LoadingView: View {
    @State private var isVisible = false // State variable to control visibility
    @State private var isAnimating = false // State variable to control animation

    var body: some View {
        VStack {
            ProgressView("Loading...") // Display a loading message
                .progressViewStyle(CircularProgressViewStyle()) // Use a circular style
                .padding()
                .scaleEffect(isAnimating ? 1.2 : 1.0) // Scale animation
                .opacity(isAnimating ? 1.0 : 0.5) // Fade animation
                .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true), value: isAnimating) // Animation effect
                .onAppear { isAnimating = true } // Start animation when the view appears
            
            Text("Please wait while we load the data.") // Optional additional text
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Center the loading view
        .background(Color(.systemBackground)) // Background color
        .edgesIgnoringSafeArea(.all) // Ignore safe area for full-screen
        .scaleEffect(isVisible ? 1.0 : 0.8) // Scale effect for animation
        .opacity(isVisible ? 1.0 : 0.0) // Opacity effect for animation
        .onAppear {
            withAnimation(.easeIn(duration: 0.2)) {
                isVisible = true // Fade in and scale up when the view appears
            }
        }
    }
}

#Preview {
    LoadingView()
}
