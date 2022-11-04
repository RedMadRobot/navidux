/// ScreenFactory uses as part of `ScreenAssembly` module and helps you to create `NavigationScreen` in `assmblyScreen` function.
/// You can extend protocol with `(Dependencies) -> (Coordinator, Configuration) -> Resulted VC` function and call them in assembler
/// on call.
/// - Example:
/// ``` swift
/// import Navidux
///
/// extension Navidux.ScreenFactory {
///    public var someScreenFactory: (Coordinator?, ScreenConfig) -> any NavigationScreen {
///         { coordinator, config
///             return MyViewControllerConformedNavigationScreen()
///         }
///    }
/// ```
public protocol ScreenFactory {}
