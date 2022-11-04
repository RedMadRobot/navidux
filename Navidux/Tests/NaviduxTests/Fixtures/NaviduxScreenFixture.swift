@testable import Navidux

extension NaviduxScreen {
    public static let firstScreen = NaviduxScreen(
        screenClass: FirstController.self
    )
    public static let secondScreen = NaviduxScreen(
        screenClass: SecondController.self
    )
    public static let thirdScreen = NaviduxScreen(
        screenClass: ThirdController.self
    )
}

final class FirstController: ViewController {}

final class SecondController: ViewController {}

final class ThirdController: ViewController {}
