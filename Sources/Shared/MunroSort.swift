public struct MunroSort {
    public enum Direction {
        case ascending
        case descending
    }
    
    public static func byName(
        munros: [Munro],
        orderBy: Direction = .ascending,
        limit: Int? = nil
    ) -> [Munro] {
        switch orderBy {
        case .ascending:
            return munros.sorted { $0.name < $1.name }.limit(limit ?? munros.count)
        case .descending:
            return munros.sorted { $0.name > $1.name }.limit(limit ?? munros.count)
        }
    }
    
    public static func byHeight(
        munros: [Munro],
        orderBy: Direction = .ascending,
        limit: Int? = nil
    ) -> [Munro] {
        switch orderBy {
        case .ascending:
            return munros.sorted { $0.height < $1.height }.limit(limit ?? munros.count)
        case .descending:
            return munros.sorted { $0.height > $1.height }.limit(limit ?? munros.count)
        }
    }
}
