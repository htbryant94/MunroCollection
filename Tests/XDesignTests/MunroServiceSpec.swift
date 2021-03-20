import Nimble
import Quick
@testable import Shared

class MunroServiceSpec: QuickSpec {
    override func spec() {
        describe("MunroService") {
            var sut: MunroService!
            
            let data: [Munro] = [
                .init(name: "Bravo", hillCategory: .munroTop, height: 1),
                .init(name: "Echo", hillCategory: .munro, height: 10),
                .init(name: "Charlie", hillCategory: .munro, height: 75),
                .init(name: "Alpha", hillCategory: .munro, height: 100),
                .init(name: "Delta", hillCategory: .munroTop, height: 1000),
                .init(name: "Foxtrot", hillCategory: .munroTop, height: 250),
                .init(name: "Juliet", hillCategory: .munroTop, height: 375),
                .init(name: "Golf", hillCategory: .munroTop, height: 34),
                .init(name: "India", hillCategory: .munro, height: 99),
                .init(name: "Hotel", hillCategory: .munro, height: 500),
            ]
            
            beforeEach {
                sut = MunroService()
            }
            
            context("fetch") {
                var actual: [Munro]!
                var expected: [Munro]!
                
                context("Sort: name ascending, Filter: hillCategory munro") {
                    beforeEach {
                        expected = [
                            .init(name: "Alpha", hillCategory: .munro, height: 100),
                            .init(name: "Charlie", hillCategory: .munro, height: 75),
                            .init(name: "Echo", hillCategory: .munro, height: 10),
                            .init(name: "Hotel", hillCategory: .munro, height: 500),
                            .init(name: "India", hillCategory: .munro, height: 99),
                        ]
                        actual = sut.fetch(data, sortBy: .ascending, filter: .munro)
                    }
                    
                    it("should return expected list of Munros") {
                        expect(actual) == expected
                    }
                }
            }
        }
    }
}

public class MunroService {
    
    typealias Filter = MunroFilter
    typealias Sort = MunroSort
    
    public func fetch(
        _ data: [Munro],
        sortBy: MunroSort.Direction,
        filter: Munro.HillCategory
    ) -> [Munro] {
        let filtered = Filter.byHillCategory(munros: data, hillCategory: filter)
        let sorted = Sort.byName(munros: filtered)
        return sorted
    }
}

