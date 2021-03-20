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
}
