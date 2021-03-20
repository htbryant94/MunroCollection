public struct MunroSort {
    public enum Direction {
        case ascending
        case descending
    }
    
    public static func byName(munros: [Munro], orderBy: Direction = .ascending) -> [Munro] {
        switch orderBy {
        case .ascending: return munros.sorted { $0.name < $1.name }
        default: return munros.sorted { $0.name > $1.name }
        }
    }
    
    public static func byHeight(munros: [Munro], orderBy: Direction = .ascending) -> [Munro] {
        switch orderBy {
        case .ascending: return munros.sorted { $0.height < $1.height }
        default: return munros.sorted { $0.height > $1.height }
        }
    }
}
