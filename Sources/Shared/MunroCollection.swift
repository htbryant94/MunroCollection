public class MunroCollection {
    private let filePath: String
    
    public init(filePath: String = "Sources/Resources/munrotab_v6.2.csv") {
        self.filePath = filePath
    }
    
    public func get(
        sortType: MunroSort.SortType = .name(.ascending),
        hillCategory: Munro.HillCategory? = nil,
        minHeight: Double? = nil,
        maxHeight: Double? = nil,
        limit: Int? = nil,
        _ completionHandler: @escaping (Result<[Munro], Error>
) -> Void) {
        CSVParser.parseFile(filePath) { result in
            switch result {
            case let .success(data):
                let munroService = MunroService(munros: MunroFactory(rows: data).makeMunros())
                munroService.fetch(
                    sortType: sortType,
                    hillCategory: hillCategory,
                    minHeight: minHeight,
                    maxHeight: maxHeight,
                    limit: limit,
                    completionHandler: { result in
                    switch result {
                    case let .success(results):
                        completionHandler(.success(results))
                    case let .failure(error):
                        completionHandler(.failure(error))
                    }
                })
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }
}
