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

        let navigation = NavigationControllerImpl()
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

