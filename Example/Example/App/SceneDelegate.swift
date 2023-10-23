import Navidux
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)

        let navigation = NavigationControllerImpl { controller in
            controller.view.backgroundColor = .green
            controller.navigationBar.isTranslucent = false
            controller.navigationBar.backgroundColor = .green
            controller.navigationBar.shadowImage = .init()
            controller.navigationBar.barTintColor = .green
            controller.navigationBar.tintColor = .black
            controller.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.black
            ]
        }
        let screenFactory = NaviduxScreenFactory()
        let alertFactory = AlertFactoryImpl()
        let navigationCoordinatorProxy = NavigationCoordinatorProxy()
        let screenAssembler = NaviduxScreenAssembler(
            screenFactory: screenFactory,
            alertFactory: alertFactory,
            screenCoordinator: navigationCoordinatorProxy
        )
        let navigationCoordinator = NavigationCoordinator(
            navigation,
            screenAssembler: screenAssembler
        )
        navigationCoordinatorProxy.subject = navigationCoordinator
        navigationCoordinatorProxy.route(
            with: .push(
                .firstScreen,
                ScreenConfig(navigationTitle: "First screen", isNeedSetBackButton: false),
                .fullscreen
            )
        )

        window.rootViewController = navigation
        self.window = window
        window.makeKeyAndVisible()
        
    }
}

