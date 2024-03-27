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
                    // Bottom Sheet
                },
                title: "Present bottom sheet - auto"
            )
            ButtonView(
                action: { [weak navigation] in
                    // Bottom Sheet with fixed height
                },
                title: "Present bottom sheet - fixed height"
            )
            ButtonView(
                action: { [weak navigation] in
                    // Bottom Sheet with full screen
                },
                title: "Present bottom sheet - full screen"
            )
            ButtonView(
                action: { [weak navigation] in
                    // Bottom Sheet with half screen
                },
                title: "Present bottom sheet - half screen"
            )
        }
        .padding()
    }
}

struct SecondContentModule: Module {
    func assembly(using coordinator: Coordinator) -> UIViewController {
        return UIHostingController(rootView: SecondContentView(navigation: coordinator))
    }
}

extension Module where Self == SecondContentModule {
    static var second: Self {
        return SecondContentModule()
    }
}
