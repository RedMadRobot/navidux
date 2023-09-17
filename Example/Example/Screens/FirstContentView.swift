import Navidux
import SwiftUI

struct FirstContentView: View {
    let navigation: NavigationCoordinator?
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            ButtonView(
                action: { [weak navigation] in
                    navigation?.route(with:
                            .push(
                                .secondScreen,
                                ScreenConfig(navigationTitle: "Second Screen"),
                                .fullscreen
                            )
                    )
                },
                title: "Open fullscreen second screen"
            )
            .padding(.top, 40)
        }
        .padding()
        .navigationBarBackButtonHidden()
    }
}

struct FirstContentView_Previews: PreviewProvider {
    static var previews: some View {
        FirstContentView(navigation: nil)
    }
}
