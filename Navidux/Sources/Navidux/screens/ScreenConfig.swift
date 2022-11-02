public struct ScreenConfig: Equatable {
    let navigationTitle: String
    var isNeedSetBackButton: Bool
    
    public init(navigationTitle: String, isNeedSetBackButton: Bool = true) {
        self.navigationTitle = navigationTitle
        self.isNeedSetBackButton = isNeedSetBackButton
    }
}
