public class MunroFactory {
    private let fileContents: String
    
    public init(fileContents: String) {
        self.fileContents = fileContents
    }
    
    public func makeMunros() -> [Munro] {
        return parseRows().compactMap { makeMunro(columns: parseColumnsFrom(row: $0)) }
    }
    
    private enum Column: Int {
        case runningNo = 0
        case doBIHNumber = 1
        case geograph = 4
    }
    
    private func makeMunro(columns: [String]) -> Munro? {
        guard let runningNo = Int(columns[Column.runningNo.rawValue]),
              let doBIHNumber = Int(columns[(Column.doBIHNumber.rawValue)]) else { return nil }
        
        return .init(
            runningNo: runningNo,
            DoBIHNumber: doBIHNumber,
            streetMap: columns[2] + columns[3],
            geograph: columns[Column.geograph.rawValue]
        )
    }
    
    private func parseRows() -> [String] {
        return fileContents.components(separatedBy: "\n")
    }
    
    private func parseColumnsFrom(row: String) -> [String] {
        return row.components(separatedBy: ",")
    }
}
