public struct Munro {
    let name: String
    let hillCategory: HillCategory
    
    enum HillCategory: String {
        case munro = "MUN"
        case munroTop = "TOP"
    }
}
