class MunroFactory {
    private let rows: [String]
   
    init(rows: [String]) {
        self.rows = rows
    }
    
    func makeMunros() -> [Munro] {
        return rows.compactMap { makeMunro(columns: parseColumnsFrom(row: $0)) }
    }
    
    private enum ColumnHeader: Int {
        case name = 6
        case post1997 = 28
        case heightMetres = 10
        case gridRef = 14
        
        var index: Int {
            return rawValue
        }
    }
    
    private func makeMunro(columns: [String]) -> Munro? {
        guard
            let hillCategory = Munro.HillCategory(rawValue: columns[ColumnHeader.post1997.index]),
            let height = Double(columns[ColumnHeader.heightMetres.index]) else { return nil }
        
        return .init(
            name: columns[ColumnHeader.name.index],
            hillCategory: hillCategory,
            height: height,
            gridRef: columns[ColumnHeader.gridRef.index]
        )
    }
    
    private func parseColumnsFrom(row: String) -> [String] {
        return row.components(separatedBy: ",")
    }
}
