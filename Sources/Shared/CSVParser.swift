import Foundation

struct CSVParser {
    static func parseFile(_ filePath: String, completionHandler: @escaping (Result<[String], Error>) -> Void) {
        do {
            let fileContents = try String(contentsOfFile: filePath, encoding: .ascii)
            let rows = parseRows(fileContents: fileContents)
            return completionHandler(.success(rows))
            
            
        } catch {
            return completionHandler(.failure(error))
        }
    }
    
    static func parseRows(fileContents: String) -> [String] {
        var rows = fileContents.components(separatedBy: "\n")
        rows.removeFirst() // Remove Headers
        rows.removeSubrange(603...610) // Remove Empty Rows
        return rows
    }
}
