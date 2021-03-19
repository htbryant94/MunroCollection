import Foundation

public struct CSVParser {
    public static func parseFile(_ filePath: String, completionHandler: @escaping (Result<String, Error>) -> Void) {
        do {
            let fileContents = try String(contentsOfFile: filePath, encoding: .ascii)
            return completionHandler(.success(fileContents))
        } catch {
            return completionHandler(.failure(error))
        }
    }
}
