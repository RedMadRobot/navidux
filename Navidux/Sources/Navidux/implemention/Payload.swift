public typealias NullablePayload = (any Payload)?

public protocol Payload: Equatable {}

public struct VoidPayload: Payload {}
