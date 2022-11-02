@testable import Navidux
import XCTest

final class NavigationCoordinatorTests: XCTestCase {
    let navigationController = NavigationControllerStub()
    let navigationScreen = NaviduxFixture.mockNavigationScreen(tag: NaviduxFixture.oneScreenTag)
    lazy var navigationCoordinator = NavigationCoordinator(
        navigationController,
        screenFactory: ScreenFactoryFixture(mockNavigationScreen: navigationScreen)
    )
    
    func test_start_pushDefaultScreen() {
        navigationCoordinator.start()
        
        XCTAssertEqual(
            navigationController.callingStack,
            [
                .pushViewController(tag: NaviduxFixture.oneScreenTag),
                .addToStack(tag: NaviduxFixture.oneScreenTag)
            ]
        )
    }
    
    func test_pushFullscreen_addCallForPush() {
        navigationCoordinator.actionReducer(
            action: .push(
                .firstScreen,
                NaviduxFixture.mockScreenConfig(),
                .fullscreen
            )
        )
        
        XCTAssertEqual(
            navigationController.callingStack,
            [
                .pushViewController(tag: NaviduxFixture.oneScreenTag),
                .addToStack(tag: NaviduxFixture.oneScreenTag)
            ]
        )
        XCTAssertFalse(navigationScreen.isModal)
    }
    
    func test_pushModal_addCallForPresentAndSetState() {
        navigationCoordinator.actionReducer(
            action: .push(
                .firstScreen,
                NaviduxFixture.mockScreenConfig(),
                .modal
            )
        )
        
        XCTAssertEqual(
            navigationController.callingStack,
            [
                .present(tag: NaviduxFixture.oneScreenTag),
                .addToStack(tag: NaviduxFixture.oneScreenTag)
            ]
        )
        
        XCTAssertTrue(navigationCoordinator.state.hasOverlay)
        XCTAssertTrue(navigationScreen.isModal)
    }
    
    func test_pushBottomSheet_addCallForPresentAndSetState() {
        navigationCoordinator.actionReducer(
            action: .push(
                .firstScreen,
                NaviduxFixture.mockScreenConfig(),
                .bottomSheet([.halfScreen])
            )
        )
        
        XCTAssertEqual(
            navigationController.callingStack,
            [
                .present(tag: NaviduxFixture.oneScreenTag),
                .addToStack(tag: NaviduxFixture.oneScreenTag)
            ]
        )
        
        XCTAssertTrue(navigationCoordinator.state.hasOverlay)
        XCTAssertTrue(navigationScreen.isModal)
    }
    
    func test_popFullscreen_addCallForPop() {
        navigationCoordinator.actionReducer(
            action: .push(
                .firstScreen,
                NaviduxFixture.mockScreenConfig(),
                .fullscreen
            )
        )
        
        navigationCoordinator.actionReducer(action: .pop(nil))
        
        XCTAssertEqual(
            navigationController.callingStack,
            [
                .pushViewController(tag: NaviduxFixture.oneScreenTag),
                .addToStack(tag: NaviduxFixture.oneScreenTag),
                .popViewController,
                .removeLastFromStack
            ]
        )
    }
    
    func test_popModal_addCallForDismiss() {
        navigationCoordinator.actionReducer(
            action: .push(
                .firstScreen,
                NaviduxFixture.mockScreenConfig(),
                .modal
            )
        )
        
        navigationCoordinator.actionReducer(action: .pop(nil))
        
        XCTAssertEqual(
            navigationController.callingStack,
            [
                .present(tag: NaviduxFixture.oneScreenTag),
                .addToStack(tag: NaviduxFixture.oneScreenTag),
                .dismiss,
                .removeLastFromStack
            ]
        )
    }
    
    func test_pushFullscreen_setCallback() {
        navigationCoordinator.actionReducer(
            action: .push(
                .firstScreen,
                NaviduxFixture.mockScreenConfig(),
                .fullscreen
            )
        )
        
        XCTAssertNotNil(navigationScreen.navigationCallback)
    }
    
    //Спорный тест из-за restruct
    func test_popToFullscreen_addCallForPop() {
        navigationCoordinator.actionReducer(
            action: .restruct(
                [
                    (.firstScreen, NaviduxFixture.mockScreenConfig()),
                    (.firstScreen, NaviduxFixture.mockScreenConfig()),
                    (.secondScreen, NaviduxFixture.mockScreenConfig()),
                ]
            )
        )
        
        navigationCoordinator.actionReducer(
            action: .popUntil(.firstScreen, nil)
        )
        
        XCTAssertEqual(
            navigationController.callingStack,
            [
                .popViewController,
                .rebuildNavStack(tags: [
                    NaviduxFixture.oneScreenTag,
                    NaviduxFixture.oneScreenTag,
                    NaviduxFixture.oneScreenTag
                ]),
            ]
        )
    }
    
    //Спорный тест из-за restruct
    func test_popToModal_addCallForPop() {
        navigationCoordinator.actionReducer(
            action: .restruct(
                [
                    (.firstScreen, NaviduxFixture.mockScreenConfig()),
                    (.firstScreen, NaviduxFixture.mockScreenConfig()),
                    (.secondScreen, NaviduxFixture.mockScreenConfig()),
                ]
            )
        )
        navigationCoordinator.actionReducer(
            action: .push(
                .firstScreen,
                NaviduxFixture.mockScreenConfig(),
                .modal
            )
        )
        
        navigationCoordinator.actionReducer(
            action: .popUntil(.firstScreen, nil)
        )
        
        XCTAssertEqual(
            navigationController.callingStack,
            [
                .popViewController,
                .rebuildNavStack(tags: [
                    NaviduxFixture.oneScreenTag,
                    NaviduxFixture.oneScreenTag,
                    NaviduxFixture.oneScreenTag
                ]),
                .present(tag: NaviduxFixture.oneScreenTag),
                .addToStack(tag: NaviduxFixture.oneScreenTag)
            ]
        )
    }
}
