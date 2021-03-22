public struct MunroFilter {
    public static func byHillCategory(munros: [Munro], hillCategory: Munro.HillCategory?) -> [Munro] {
        guard let hillCategory = hillCategory else { return munros }
        return munros.filter { $0.hillCategory == hillCategory }
    }
    
    public static func byHeight(munros: [Munro], min: Double?, max: Double?) -> [Munro] {
        var results = munros
        
        if let min = min {
            results = munros.filter { $0.height >= min }
        }
        
        if let max = max {
            results = results.filter { $0.height <= max }
        }
        
        return results
    }
}
