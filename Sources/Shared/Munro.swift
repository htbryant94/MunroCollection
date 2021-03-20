public struct Munro: Equatable {
    public let name: String
    public let hillCategory: HillCategory
    
    public enum HillCategory: String {
        case munro = "MUN"
        case munroTop = "TOP"
    }
}
