import Navidux
import SwiftUI

struct SecondContentView: View {
    let navigation: Coordinator?
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            ButtonView(
                action: { [weak navigation] in
                    navigation?.perform(action: .pop)
                },
                title: "Back"
            )
            .padding(.top, 40)
            ButtonView(
                action: { [weak navigation] in
                    navigation?.perform(action: .push(.third, as: .bottomSheet(.auto, completion: nil)))
                },
                title: "Present bottom sheet - auto"
            )
            ButtonView(
                action: { [weak navigation] in
                    navigation?.perform(action: .push(.third, as: .bottomSheet(.fixed(120), completion: nil)))
                },
                title: "Present bottom sheet - fixed height"
            )
            ButtonView(
                action: { [weak navigation] in
                    navigation?.perform(action: .push(.third, as: .bottomSheet(.fullScreen, completion: nil)))
                },
                title: "Present bottom sheet - full screen"
            )
            ButtonView(
                action: { [weak navigation] in
                    navigation?.perform(action: .push(.third, as: .bottomSheet(.halfScreen, completion: nil)))
                },
                title: "Present bottom sheet - half screen"
            )
        }
        .padding()
        .navigationBarBackButtonHidden()
    }
}

struct SecondContentModule: Module {
    func assembly(using coordinator: Coordinator) -> any NavigationScreen {
        HostingController(content: SecondContentView(navigation: coordinator))
    }
}

extension Module where Self == SecondContentModule {
    static var second: Self {
        SecondContentModule()
    }
}
