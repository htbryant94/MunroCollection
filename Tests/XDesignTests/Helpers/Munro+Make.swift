@testable import Shared

extension Munro {
    static func make(
        name: String = "name",
        hillCategory: HillCategory = .munro,
        height: Double = 0
    ) -> Munro {
        return .init(
            name: name,
            hillCategory: hillCategory,
            height: height
        )
    }
}
