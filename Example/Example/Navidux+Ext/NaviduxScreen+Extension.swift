import Navidux

extension NaviduxScreen {
    public static let firstScreen = NaviduxScreen(
        screenClass: HostingController<FirstContentView>.self
    )

    public static let secondScreen = NaviduxScreen(
        screenClass: HostingController<SecondContentView>.self
    )
    
    public static let thirdScreen = NaviduxScreen(
        screenClass: ThirdContentViewController.self
    )
}
