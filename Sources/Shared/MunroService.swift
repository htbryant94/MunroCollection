import Foundation

class MunroService {
    typealias Filter = MunroFilter
    typealias Sort = MunroSort
    
    private let munros: [Munro]
    
    init(munros: [Munro]) {
        self.munros = munros
    }
    
    func fetch(
        sortType: MunroSort.SortType = .name(.ascending),
        hillCategory: Munro.HillCategory? = nil,
        minHeight: Double? = nil,
        maxHeight: Double? = nil,
        limit: Int? = nil,
        completionHandler: @escaping (Result<[Munro], Error>) -> Void
    ) {
        guard minHeight != 0 else { return completionHandler(.failure(minHeightZeroError)) }
        
        if
            let min = minHeight,
            let max = maxHeight,
            min >= max {
            return completionHandler(.failure(minMaxHeightError))
        }
        
        var results = munros
        
        if let hillCategory = hillCategory {
            results = Filter.byHillCategory(munros: results, hillCategory: hillCategory)
        }
        
        results = Filter.byHeight(munros: results, min: minHeight, max: maxHeight)
        
        switch sortType {
        case let .name(direction):
            results = Sort.byName(munros: results, orderBy: direction)
        case let .height(direction):
            results = Sort.byHeight(munros: results, orderBy: direction)
        }
        
        if results.count > 0 {
            completionHandler(.success(results.limit(limit ?? results.count)))
        } else {
            completionHandler(.failure(noResultsError))
        }
    }
    
    private var minMaxHeightError: Error {
        return NSError(
            domain: "MunroServiceDomain",
            code: 123,
            userInfo: [
                NSLocalizedDescriptionKey: "minHeight cannot be greater than or equal to maxHeight"
            ]
        )
    }
    
    private var minHeightZeroError: Error {
        return NSError(
            domain: "MunroServiceDomain",
            code: 123,
            userInfo: [
                NSLocalizedDescriptionKey: "minHeight cannot be 0"
            ]
        )
    }
    
    private var noResultsError: Error {
        return NSError(
            domain: "MunroServiceDomain",
            code: 456,
            userInfo: [
                NSLocalizedDescriptionKey: "No results found, try expanding your search parameters"
            ]
        )
    }
}
