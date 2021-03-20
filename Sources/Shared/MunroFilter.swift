public struct MunroFilter {
    public static func byHillCategory(munros: [Munro], hillCategory: Munro.HillCategory?) -> [Munro] {
        guard let hillCategory = hillCategory else { return munros }
        return munros.filter { $0.hillCategory == hillCategory }
    }
}

