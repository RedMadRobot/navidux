@testable import Navidux
import XCTest

final class NavigationCoordinatorTests: XCTestCase {
    let navigationController = NavigationControllerStub()
    var expectedPayload: PayloadStub?
    lazy var navigationScreen = NaviduxFixture.mockNavigationScreen(
        tag: NaviduxFixture.oneScreenTag,
        output: { [weak self] payload in
            self?.expectedPayload = payload as? PayloadStub
        }
    )
    lazy var screenAssembler = ScreenAssemblerStub(
        vcTag: NaviduxFixture.oneScreenTag,
        screenToPush: navigationScreen
    )
    
    lazy var navigationCoordinator = NavigationCoordinator(
        navigationController,
        screenAssembler: screenAssembler
    )

    func test_pushFullscreen_addCallForPush() {
        screenAssembler.navigation = navigationCoordinator

        navigationCoordinator.route(
            with: .push(
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
        screenAssembler.navigation = navigationCoordinator
        
        navigationCoordinator.route(
            with: .push(
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
        screenAssembler.navigation = navigationCoordinator
        
        navigationCoordinator.route(
            with: .push(
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
        screenAssembler.navigation = navigationCoordinator
        
        navigationCoordinator.route(
            with: .push(
                .firstScreen,
                NaviduxFixture.mockScreenConfig(),
                .fullscreen
            )
        )
        
        navigationCoordinator.route(with: .pop(nil))
        
        XCTAssertEqual(
            navigationController.callingStack,
            [
                .pushViewController(tag: NaviduxFixture.oneScreenTag),
                .addToStack(tag: NaviduxFixture.oneScreenTag)
            ]
        )
    }
    
    func test_popModal_addCallForDismiss() {
        screenAssembler.navigation = navigationCoordinator
        
        navigationCoordinator.route(
            with: .push(
                .firstScreen,
                NaviduxFixture.mockScreenConfig(),
                .modal
            )
        )
        
        navigationCoordinator.route(with: .pop(nil))
        
        XCTAssertEqual(
            navigationController.callingStack,
            [
                .present(tag: NaviduxFixture.oneScreenTag),
                .addToStack(tag: NaviduxFixture.oneScreenTag)
            ]
        )
    }
    
    func test_pushFullscreen_setCallback() {
        screenAssembler.navigation = navigationCoordinator
        
        navigationCoordinator.route(
            with: .push(
                .firstScreen,
                NaviduxFixture.mockScreenConfig(),
                .fullscreen
            )
        )
        
        XCTAssertNotNil(navigationScreen.navigationCallback)
    }
    
    //Спорный тест из-за restruct
    func test_popToFullscreen_addCallForPop() {
        screenAssembler.navigation = navigationCoordinator
        
        navigationCoordinator.route(
            with: .restruct(
                screens: [
                    ScreenAsseblyComponents(screenType: .firstScreen, config: NaviduxFixture.mockScreenConfig()),
                    ScreenAsseblyComponents(screenType: .secondScreen, config: NaviduxFixture.mockScreenConfig()),
                    ScreenAsseblyComponents(screenType: .thirdScreen, config: NaviduxFixture.mockScreenConfig()),
                ],
                animationType: .backward
            )
        )
        
        navigationCoordinator.route(
            with: .popUntil(.firstScreen, nil)
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
        screenAssembler.navigation = navigationCoordinator
        
        navigationCoordinator.route(
            with: .restruct(
                screens: [
                    ScreenAsseblyComponents(screenType: .firstScreen, config: NaviduxFixture.mockScreenConfig()),
                    ScreenAsseblyComponents(screenType: .secondScreen, config: NaviduxFixture.mockScreenConfig()),
                    ScreenAsseblyComponents(screenType: .thirdScreen, config: NaviduxFixture.mockScreenConfig()),
                ],
                animationType: .backward
            )
        )
        navigationCoordinator.route(
            with: .push(
                .firstScreen,
                NaviduxFixture.mockScreenConfig(),
                .modal
            )
        )
        
        navigationCoordinator.route(
            with: .popUntil(.firstScreen, nil)
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
    
    func test_popWithPayload() {
        screenAssembler.navigation = navigationCoordinator
                
        navigationCoordinator.route(with: .push(
            .firstScreen,
            NaviduxFixture.mockScreenConfig(),
            .fullscreen)
        )
        
        navigationCoordinator.route(with: .push(
            .secondScreen,
            NaviduxFixture.mockScreenConfig(),
            .fullscreen)
        )
        
        let outputPayload = PayloadStub(value: 123)
        navigationCoordinator.route(with: .pop(outputPayload))
        
        XCTAssertEqual(
            navigationController.callingStack,
            [
                .pushViewController(tag: NaviduxFixture.oneScreenTag),
                .addToStack(tag: NaviduxFixture.oneScreenTag),
                
                .pushViewController(tag: NaviduxFixture.oneScreenTag),
                .addToStack(tag: NaviduxFixture.oneScreenTag),
                
                .popViewController,
                .removeLastFromStack
            ]
        )
        
        XCTAssertEqual(navigationController.screens.count, 1)
        
        XCTAssertEqual(outputPayload, expectedPayload)
    }
}
