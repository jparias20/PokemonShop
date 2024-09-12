import SwiftUI

struct CustomAlertViewAction {
    var title: String = "Close"
    var action: CompletionBlock?
}

struct CustomAlertConfig: Identifiable {
    let id: String = UUID().uuidString
    var title: String = "Error"
    let message: String
    var primaryConfig = CustomAlertViewAction()
    var secondaryConfig: CustomAlertViewAction?
    
    func alertView() -> Alert {
        if let secondaryConfig {
            let primaryButton: Alert.Button = .default(Text(primaryConfig.title)) {
                primaryConfig.action?()
            }
            
            let secondaryButton: Alert.Button = .cancel(Text(secondaryConfig.title)) {
                secondaryConfig.action?()
            }
            
            return Alert(
                title: Text(title),
                message: Text(message),
                primaryButton: primaryButton,
                secondaryButton: secondaryButton
            )
        }
        
        let primaryButton: Alert.Button = .cancel(Text(primaryConfig.title)) {
            primaryConfig.action?()
        }
        
        return Alert(
            title: Text(title),
            message: Text(message),
            dismissButton: primaryButton
        )
    }
}

extension View {
    func customAlertView(item alertConfig: Binding<CustomAlertConfig?>) -> some View {
        modifier(CustomAlertView(alertConfig: alertConfig))
    }
}

private struct CustomAlertView: ViewModifier {
    @Binding var alertConfig: CustomAlertConfig?
    
    func body(content: Content) -> some View {
        content
            .alert(item: $alertConfig) { $0.alertView() }
    }
}
