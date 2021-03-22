import Foundation

public class MunroService {
    typealias Filter = MunroFilter
    typealias Sort = MunroSort
    
    public enum SortType {
        case name(MunroSort.Direction)
        case height(MunroSort.Direction)
    }
    
    public init() {}
    
    public func fetch(
        _ data: [Munro],
        sortType: SortType = .name(.ascending),
        hillCategory: Munro.HillCategory? = nil,
        minHeight: Double? = nil,
        maxHeight: Double? = nil,
        limit: Int? = nil,
        completionHandler: @escaping (Result<[Munro], Error>) -> Void
    ) {
        if let minHeight = minHeight,
           let maxHeight = maxHeight,
           minHeight >= maxHeight {
            let error = NSError(
                domain: "MunroServiceDomain",
                code: 123,
                userInfo: [
                    NSLocalizedDescriptionKey: "minHeight cannot be greater than or equal to maxHeight"
                ]
            )
            return completionHandler(.failure(error))
        }
        
        var results = data
        
        if let hillCategory = hillCategory {
            results = Filter.byHillCategory(munros: data, hillCategory: hillCategory)
        }
        
        results = Filter.byHeight(
            munros: results,
            min: minHeight,
            max: maxHeight,
            limit: nil
        )
        
        switch sortType {
        case let .name(direction):
            results = Sort.byName(munros: results, orderBy: direction)
        case let .height(direction):
            results = Sort.byHeight(munros: results, orderBy: direction)
        }
        
        return completionHandler(.success(results.limit(limit ?? results.count)))
    }
}
