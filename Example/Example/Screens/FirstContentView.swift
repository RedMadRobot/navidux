import Navidux
import SwiftUI

struct FirstContentView: View {
    let navigation: Coordinator?
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            ButtonView(
                action: { [weak navigation] in
                    navigation?.perform(
                        action: .push(
                            .third
                                .barButton(.init(title: "Text", style: .plain, target: nil, action: nil), at: .right)
                                .presentationStyle(.fullScreen)
                        )
                    )
                },
                title: "Open fullscreen second screen"
            )
            .padding(.top, 40)
        }
        .padding()
    }
}

struct FirstContentModule: Module {
    func assembly(using coordinator: Coordinator) -> UIViewController {
        return UIHostingController(rootView: FirstContentView(navigation: coordinator))
    }
}

extension Module where Self == FirstContentModule {
    static var first: Self {
        return FirstContentModule()
    }
}
