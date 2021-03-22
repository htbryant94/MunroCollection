public struct Munro: Equatable {
    public let name: String
    public let hillCategory: HillCategory
    public let height: Double
    public let gridRef: String
    
    public enum HillCategory: String {
        case munro = "MUN"
        case munroTop = "TOP"
    }
}
