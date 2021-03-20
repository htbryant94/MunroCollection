public struct Munro: Equatable {
    let name: String
    let hillCategory: HillCategory
    
    public enum HillCategory: String {
        case munro = "MUN"
        case munroTop = "TOP"
    }
}
