import Foundation

public protocol ExtendableEnum: AnyObject, Hashable { }

extension ExtendableEnum {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
      }
}

public func ==<T: ExtendableEnum>(lhs: T, rhs: T) -> Bool {
    return lhs === rhs
}
