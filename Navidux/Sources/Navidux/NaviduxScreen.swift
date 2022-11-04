import UIKit

/// NaviduxScreen its alternative to simple Enumeration with possibility to extension.
/// if you want to add case with new screen you have to:
/// ``` swift
/// extension NaviduxScreen {
///     static let newScreen = NaviduxScreen(
///         description: "someDescription",
///         screenClass: YourScreenTypeInheritedFromUIViewController.self
///     )
/// }
/// ```
/// - Note: You can place extension in another module.
public class NaviduxScreen: ExtendableEnum {
    public var asScreenClass: UIViewController.Type
    
    public init(screenClass: UIViewController.Type) {
        self.asScreenClass = screenClass
    }
}
