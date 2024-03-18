@testable import Navidux

struct NaviduxFixture {
    static let oneScreenTag = "MockNavigationScreen"
    static let mockScreenTag = "Dummy"
    
    static func mockNavigationScreen(
        coordinator: Coordinator? = nil,
        tag: String = NaviduxFixture.mockScreenTag,
        output: ((NullablePayload) -> Void)? = nil
    ) -> any NavigationScreenOld {
        return ViewController(
            coordinator: coordinator,
            tag: tag,
            output: output ?? { _ in }
        )
    }
}
