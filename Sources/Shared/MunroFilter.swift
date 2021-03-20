public struct MunroFilter {
    public static func byHillCategory(
        munros: [Munro],
        hillCategory: Munro.HillCategory?,
        limit: Int? = nil
    ) -> [Munro] {
        guard let hillCategory = hillCategory else {
            return munros.limit(limit ?? munros.count)
        }
        
        return munros
            .filter { $0.hillCategory == hillCategory }
            .limit(limit ?? munros.count)
    }
    
    public static func byHeight(
        munros: [Munro],
        min: Double?,
        max: Double?,
        limit: Int? = nil
    ) -> [Munro] {
        var results = munros
        
        if let min = min {
            results = munros.filter { $0.height >= min }
        }
        
        if let max = max {
            results = results.filter { $0.height <= max }
        }
        
        return results.limit(limit ?? munros.count)
    }
}
