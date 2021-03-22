public struct MunroSort {
    public enum Direction {
        case ascending
        case descending
    }
    
    public enum SortType {
        case name(MunroSort.Direction)
        case height(MunroSort.Direction)
    }
    
    static func byName(munros: [Munro], orderBy: Direction = .ascending) -> [Munro] {
        switch orderBy {
        case .ascending:
            return munros.sorted { $0.name < $1.name }
        case .descending:
            return munros.sorted { $0.name > $1.name }
        }
    }
    
    static func byHeight(munros: [Munro], orderBy: Direction = .ascending) -> [Munro] {
        switch orderBy {
        case .ascending:
            return munros.sorted { $0.height < $1.height }
        case .descending:
            return munros.sorted { $0.height > $1.height }
        }
    }
}
