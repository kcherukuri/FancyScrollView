import SwiftUI

struct BackButton: View {
    let color: Color

    @Environment(\.presentationMode)
    var presentationMode: Binding<PresentationMode>
    
    @State private var hasBeenShownAtLeastOnce: Bool = false
    @State var scaleValue: CGFloat = 0.95

    var body: some View {
        (presentationMode.wrappedValue.isPresented || hasBeenShownAtLeastOnce) ?
            Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
               Image(systemName: "chevron.left")
                .font(Font.body.weight(.heavy))
                .foregroundColor(.black)
                .frame(width: 36, height: 36)
                .background(.black.opacity(0.8))
                .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
            }
            .onAppear {
                self.hasBeenShownAtLeastOnce = true
            }
            .buttonStyle(ButtonNavigationAnimationStyle(scaleValue: $scaleValue))
        : nil
    }
}

struct ButtonNavigationAnimationStyle: ButtonStyle {
    @Binding var scaleValue: CGFloat
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scaleValue : 1.0)
            .animation(.interactiveSpring(response: 0.4, dampingFraction: 0.4, blendDuration: 0.8), value: scaleValue)
    }
}
