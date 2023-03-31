import SwiftUI

struct SubmitButton: View {
    let text: String
    let submitAction: () async -> Void
    var body: some View {
        Button(action: {
            Task {
                await submitAction()
            }
        }) {
            Text(text)
                .font(.system(size: 26, weight: .medium))
                .foregroundColor(Color.white)
                .frame(width: 310, height: 60)
                .background(Color.blue)
                .cornerRadius(12)
        }
    }
    
}

struct SubmitButton_Previews: PreviewProvider {
    static var previews: some View {
        SubmitButton(text: "", submitAction: {})
    }
}

