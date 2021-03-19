import Foundation

public struct CSVParser {
    public static func parseFile(_ filePath: String, completionHandler: @escaping (Result<[String], Error>) -> Void) {
        do {
            let fileContents = try String(contentsOfFile: filePath, encoding: .ascii)
            var rows = parseRowFrom(fileContents: fileContents)
            rows.removeFirst()
            return completionHandler(.success(rows))
        } catch {
            return completionHandler(.failure(error))
        }
    }
    
    private static func parseRowFrom(fileContents: String) -> [String] {
        return fileContents.components(separatedBy: "\n")
    }
    
    private static func parseColumnsFrom(row: String) -> [String] {
        return row.components(separatedBy: ",")
    }
}
