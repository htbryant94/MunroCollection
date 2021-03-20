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
        sortType: SortType,
        hillCategory: Munro.HillCategory? = nil,
        minHeight: Double? = nil,
        maxHeight: Double? = nil
    ) -> [Munro] {
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
        
        return results
    }
}
