import Nimble
import Quick
@testable import Shared

class MunroSortSpec: QuickSpec {
    override func spec() {
        describe("MunroSort") {
            typealias sut = MunroSort
            let data: [Munro] = [
                .init(name: "Bravo", hillCategory: .munro),
                .init(name: "Echo", hillCategory: .munro),
                .init(name: "Alpha", hillCategory: .munro),
                .init(name: "Charlie", hillCategory: .munro),
                .init(name: "Delta", hillCategory: .munro),
            ]
            
            context("When sorting by name") {
                var actual: [Munro]!
                var expected: [Munro]!
                
                context("by ascending") {
                    beforeEach {
                        expected = [
                            .init(name: "Alpha", hillCategory: .munro),
                            .init(name: "Bravo", hillCategory: .munro),
                            .init(name: "Charlie", hillCategory: .munro),
                            .init(name: "Delta", hillCategory: .munro),
                            .init(name: "Echo", hillCategory: .munro),
                        ]
                        
                        actual = sut.byName(munros: data, orderBy: .ascending)
                    }
                    
                    it("should return list in correct order") {
                        expect(actual) == expected
                        
                    }
                }
                
                context("by descending") {
                    beforeEach {
                        expected = [
                            .init(name: "Echo", hillCategory: .munro),
                            .init(name: "Delta", hillCategory: .munro),
                            .init(name: "Charlie", hillCategory: .munro),
                            .init(name: "Bravo", hillCategory: .munro),
                            .init(name: "Alpha", hillCategory: .munro),
                        ]
                        
                        actual = sut.byName(munros: data, orderBy: .descending)
                    }

                    it("should return list in correct order") {
                        expect(actual) == expected
                    }
                }
                
                context("orderBy is not specified") {
                    beforeEach {
                        expected = [
                            .init(name: "Alpha", hillCategory: .munro),
                            .init(name: "Bravo", hillCategory: .munro),
                            .init(name: "Charlie", hillCategory: .munro),
                            .init(name: "Delta", hillCategory: .munro),
                            .init(name: "Echo", hillCategory: .munro),
                        ]
                        
                        actual = sut.byName(munros: data)
                    }
                    
                    it("should default to sorting by ascending") {
                        expect(actual) == expected
                        
                    }
                }
            }
        }
    }
}
