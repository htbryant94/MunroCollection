import Nimble
import Quick
@testable import Shared

class MunroFilterSpec: QuickSpec {
    override func spec() {
        describe("MunroFilter") {
            typealias Filter = MunroFilter
            let data: [Munro] = [
                .init(name: "one", hillCategory: .munro),
                .init(name: "two", hillCategory: .munro),
                .init(name: "three", hillCategory: .munroTop),
                .init(name: "four", hillCategory: .munro),
                .init(name: "five", hillCategory: .munroTop),
            ]
            
            context("Filter by hill category") {
                var actual: [Munro]!
                var expected: [Munro]!
                
                context("when filtering for Munros") {
                    beforeEach {
                        expected = [
                            .init(name: "one", hillCategory: .munro),
                            .init(name: "two", hillCategory: .munro),
                            .init(name: "four", hillCategory: .munro),
                        ]
                        actual = Filter.byHillCategory(munros: data, hillCategory: .munro)
                    }
                    
                    it("should return array of only Munros") {
                        expect(actual) == expected
                    }
                }
                
                context("when filtering for Munro Tops") {
                    beforeEach {
                        expected = [
                            .init(name: "three", hillCategory: .munroTop),
                            .init(name: "five", hillCategory: .munroTop),
                        ]
                        actual = Filter.byHillCategory(munros: data, hillCategory: .munroTop)
                    }
                    
                    it("should return array of only Munro Tops") {
                        expect(actual) == expected
                    }
                }
                
                context("when hill category is not specified") {
                    beforeEach {
                        actual = Filter.byHillCategory(munros: data, hillCategory: nil)
                    }
                    
                    it("should return array of both Munro & Munro Tops") {
                        expect(actual) == data
                    }
                }
            }
        }
    }
}
