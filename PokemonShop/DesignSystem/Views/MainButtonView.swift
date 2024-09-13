import SwiftUI

struct MainButtonView: View {
    let title: String
    let actionCompletion: CompletionBlock

    var body: some View {
        Button {
            actionCompletion()
        } label: {
            Text(title)
                .bold()
                .frame(maxWidth: .infinity)
        }
        .tint(.green)
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    MainButtonView(title: "Sendxxxx") { }
        .preferredColorScheme(.dark)
}

#Preview {
    MainButtonView(title: "Send") { }
        .preferredColorScheme(.light)
}
