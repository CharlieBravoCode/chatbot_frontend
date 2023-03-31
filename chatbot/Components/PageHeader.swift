import SwiftUI

struct PageHeader: View {
    var titleName: String
    var body: some View {
        
        VStack {
            HStack {
                Text(titleName)
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(Color.white)
                    .padding([.leading], 30)
                    .padding([.bottom], 10)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .background(Color.blue)
        }
    }
}

struct PageHeader_Previews: PreviewProvider {
    static var previews: some View {
        PageHeader(titleName: "Some Title")
    }
}
