public typealias NullablePayload = (any Payload)?

/// Payload uses to transfer some data from screen to screen.
/// In default implementation on push new screen `Payload` added to `ScreenConfig` objet.
/// You have access to data in `ScreenAssemble` object.
/// Another case with access, you have on `.pop` and `.popUntil` actions.
/// This payload return as parameter in default implementation of `gotUpdatedData(_:)` in `NavigayionScreen` protocol.
/// If you want access data at this access point you have to override `gotUpdatedData(_:)` function in your inherited ViewController.
public protocol Payload: Hashable {
    associatedtype T: Hashable
    var data: T { get }
}

/// It's shortcut for Payload.
public struct VoidPayload: Payload {
    public var data = false
}
