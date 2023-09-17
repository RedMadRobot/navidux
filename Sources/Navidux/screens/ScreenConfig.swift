public struct ScreenConfig: Equatable {
    public let navigationTitle: String
    public var isNeedSetBackButton: Bool
    public var initialPayload: NullablePayload
    public var output: ((NullablePayload) -> Void)

    /// - Parameters:
    ///     - navigationTitle: Set navigation title for screen on init.
    ///     - isNeedSetBackButton: Set or remove back button in navigation bar. Action on callback can be overrided in `NavigationScreen` with function `onBackCallback`.
    ///     - initialPayload: Uses as additional parameter with some data to initialise `NavigationScreen` or some Module/Fabric.
    public init(
        navigationTitle: String,
        isNeedSetBackButton: Bool = true,
        initialPayload: NullablePayload = nil,
        output: ((NullablePayload) -> Void)?
    ) {
        self.navigationTitle = navigationTitle
        self.isNeedSetBackButton = isNeedSetBackButton
        self.initialPayload = initialPayload
        self.output = output ?? { _ in }
    }

    public static func == (lhs: ScreenConfig, rhs: ScreenConfig) -> Bool {
        lhs.navigationTitle == rhs.navigationTitle
        && lhs.isNeedSetBackButton == rhs.isNeedSetBackButton
        && lhs.initialPayload?.data.hashValue == rhs.initialPayload?.data.hashValue
    }
}
