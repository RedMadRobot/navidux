public struct ScreenConfig: Equatable {
    let navigationTitle: String
    var isNeedSetBackButton: Bool
    public var initialPayload: NullablePayload

    /// - Parameters:
    ///     - navigationTitle: Set navigation title for screen on init.
    ///     - isNeedSetBackButton: Set or remove back button in navigation bar. Action on callback can be overrided in `NavigationScreen` with function `onBackCallback`.
    ///     - initialPayload: Uses as additional parameter with some data to initialise `NavigationScreen` or some Module/Fabric.
    public init(
        navigationTitle: String,
        isNeedSetBackButton: Bool = true,
        initialPayload: NullablePayload = nil
    ) {
        self.navigationTitle = navigationTitle
        self.isNeedSetBackButton = isNeedSetBackButton
        self.initialPayload = initialPayload
    }

    public static func == (lhs: ScreenConfig, rhs: ScreenConfig) -> Bool {
        lhs.navigationTitle == rhs.navigationTitle
        && lhs.isNeedSetBackButton == rhs.isNeedSetBackButton
        && lhs.initialPayload?.data.hashValue == rhs.initialPayload?.data.hashValue
    }
}
