import SwiftUI

struct MessageBubbleView: View {
    let message: MessageModel
    
    var body: some View {
        HStack {
            if message.isCurrentUser {
                Spacer()
                Text(message.text)
                    .padding([.vertical], 11)
                    .padding([.horizontal])
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(22)
            } else {
                Text(message.text)
                    .padding([.vertical], 11)
                    .padding([.horizontal])
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(22)
                Spacer()
            }
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MessageBubbleView(message: MessageModel.mock.first!)
            MessageBubbleView(message: MessageModel.mock[2])
        }
        .padding()
    }
}
