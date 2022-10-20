public struct ScreenConfig: Equatable {
    //TODO: Рассмотреть вариант, что navigationTitle может быть Custom View
    let navigationTitle: String
    var isNeedSetBackButton: Bool
    
    public init(navigationTitle: String, isNeedSetBackButton: Bool = true) {
        self.navigationTitle = navigationTitle
        self.isNeedSetBackButton = isNeedSetBackButton
    }
}
