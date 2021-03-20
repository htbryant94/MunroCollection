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
        min: Double = 0,
        max: Double?,
        limit: Int? = nil
    ) -> [Munro] {
        var filteredMunros = munros.filter { $0.height >= min }
        
        if let max = max {
            filteredMunros = filteredMunros.filter { $0.height <= max }
        }
        
        return filteredMunros.limit(limit ?? munros.count)
    }
}
