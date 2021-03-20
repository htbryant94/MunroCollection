public class MunroFactory {
    private let rows: [String]
   
    public init(rows: [String]) {
        self.rows = rows
    }
    
    public func makeMunros() -> [Munro] {
        return rows.compactMap { makeMunro(columns: parseColumnsFrom(row: $0)) }
    }
    
    private enum ColumnHeader: Int {
        case name = 6
        case post1997 = 28
        
        var index: Int {
            return rawValue
        }
    }
    
    private func makeMunro(columns: [String]) -> Munro? {
        guard let hillCategory = Munro.HillCategory(rawValue: columns[ColumnHeader.post1997.index]) else { return nil }
        return .init(
            name: columns[ColumnHeader.name.index],
            hillCategory: hillCategory
        )
    }
    
    private func parseColumnsFrom(row: String) -> [String] {
        return row.components(separatedBy: ",")
    }
}
