@testable import Navidux
import XCTest

final class NavigationControllerTests: XCTestCase {
    let navigation = BaseNavigationController()
    
    func test_Init_withZeroScreens() {
        XCTAssertTrue(navigation.screens.isEmpty)
    }
    
    func test_topScreen_returnLastScreen() {
        let screen1 = NaviduxFixture.mockNavigationScreen(tag: "1")
        let screen2 = NaviduxFixture.mockNavigationScreen(tag: "2")
        navigation.screens = [screen1, screen2]
        
        XCTAssertNotNil(navigation.topScreen)
        XCTAssertEqual(navigation.topScreen?.tag, screen2.tag)
    }
    
    func test_addToStackScreen_updateScreenProperty() {
        let screen = NaviduxFixture.mockNavigationScreen()
        
        navigation.addToStack(screen: screen)
        
        XCTAssertEqual(navigation.screens.count, 1)
        XCTAssertEqual(navigation.screens.first?.tag, screen.tag)
    }
    
    func test_removeLastFromStack_updateScreenProperty() {
        let screen = NaviduxFixture.mockNavigationScreen()
        navigation.screens = [screen]
        
        navigation.removeLastFromStack()
        
        XCTAssertTrue(navigation.screens.count == 1)
    }
    
    func test_removeTillFromStack_removeLastToScreens() {
        let screen1 = NaviduxFixture.mockNavigationScreen(tag: "1")
        let screen2 = NaviduxFixture.mockNavigationScreen(tag: "2")
        let screen3 = NaviduxFixture.mockNavigationScreen(tag: "3")
        navigation.screens = [screen1, screen2, screen3]
        
        navigation.removeTillFromStack(screen: screen1)
        
        XCTAssertEqual(navigation.screens.count, 1)
        XCTAssertEqual(navigation.screens.first?.tag, screen1.tag)
    }
    
    func test_rebuildNavStack_changes_screens() {
        let screen1 = NaviduxFixture.mockNavigationScreen(tag: "1")
        let screen2 = NaviduxFixture.mockNavigationScreen(tag: "2")
        let screen3 = NaviduxFixture.mockNavigationScreen(tag: "3")
        navigation.screens = [screen1, screen2]
        
        navigation.rebuildNavStack(with: [screen3])
        
        XCTAssertEqual(navigation.screens.count, 1)
        XCTAssertEqual(navigation.screens.first?.tag, screen3.tag)
    }
}

