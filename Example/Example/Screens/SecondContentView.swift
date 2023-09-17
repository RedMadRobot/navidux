import Navidux
import SwiftUI

struct SecondContentView: View {
    let navigation: NavigationCoordinator?
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            ButtonView(
                action: { [weak navigation] in
                    navigation?.route(with: .pop(nil))
                },
                title: "Back"
            )
            .padding(.top, 40)
            ButtonView(
                action: {},
                title: "Move to second screen"
            )
        }
        .padding()
        .navigationBarBackButtonHidden()
    }
}

struct SecondContentView_Previews: PreviewProvider {
    static var previews: some View {
        SecondContentView(navigation: nil)
    }
}
