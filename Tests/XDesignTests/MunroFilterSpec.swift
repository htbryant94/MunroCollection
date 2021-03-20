import Nimble
import Quick
@testable import Shared

class MunroFilterSpec: QuickSpec {
    override func spec() {
        describe("MunroFilter") {
            typealias Filter = MunroFilter
            let data: [Munro] = [
                .make(name: "Alpha", hillCategory: .munro),
                .make(name: "Bravo", hillCategory: .munro),
                .make(name: "Charlie", hillCategory: .munroTop),
                .make(name: "Delta", hillCategory: .munro),
                .make(name: "Echo", hillCategory: .munroTop),
            ]
            
            context("Filter by hill category") {
                var actual: [Munro]!
                var expected: [Munro]!
                
                context("when filtering for Munros") {
                    beforeEach {
                        expected = [
                            .make(name: "Alpha", hillCategory: .munro),
                            .make(name: "Bravo", hillCategory: .munro),
                            .make(name: "Delta", hillCategory: .munro),
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
                            .make(name: "Charlie", hillCategory: .munroTop),
                            .make(name: "Echo", hillCategory: .munroTop),
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
                
                context("limit") {
                    context("when limit is specified") {
                        beforeEach {
                            expected = [
                                .make(name: "Alpha", hillCategory: .munro),
                                .make(name: "Bravo", hillCategory: .munro),
                            ]
                            actual = Filter.byHillCategory(
                                munros: data,
                                hillCategory: .munro,
                                limit: 2
                            )
                        }
                        
                        it("should return list of the first matching items up to the maximum limit") {
                            expect(actual) == expected
                        }
                    }
                    
                    context("when limit is not specified") {
                        beforeEach {
                            expected = [
                                .make(name: "Alpha", hillCategory: .munro),
                                .make(name: "Bravo", hillCategory: .munro),
                                .make(name: "Delta", hillCategory: .munro),
                            ]
                            actual = Filter.byHillCategory(
                                munros: data,
                                hillCategory: .munro
                            )
                        }
                        
                        it("should return complete list of the matching items") {
                            expect(actual) == expected
                        }
                    }
                    
                    context("when specified limit is greater than the data range") {
                        beforeEach {
                            expected = [
                                .make(name: "Alpha", hillCategory: .munro),
                                .make(name: "Bravo", hillCategory: .munro),
                                .make(name: "Delta", hillCategory: .munro),
                            ]
                            actual = Filter.byHillCategory(
                                munros: data,
                                hillCategory: .munro,
                                limit: 10
                            )
                        }
                        
                        it("should return complete list of the matching items") {
                            expect(actual) == expected
                        }
                    }
                }
            }
            
            context("Filtering by height") {
                let data: [Munro] = [
                    .make(name: "Alpha", hillCategory: .munro, height: 1),
                    .make(name: "Bravo", hillCategory: .munro, height: 1000),
                    .make(name: "Charlie", hillCategory: .munroTop, height: 37.5),
                    .make(name: "Delta", hillCategory: .munro, height: 56),
                    .make(name: "Echo", hillCategory: .munroTop, height: 10),
                ]
                
                var actual: [Munro]!
                var expected: [Munro]!
                
                context("with minimum & maximum specified") {
                    beforeEach {
                        expected = [
                            .make(name: "Charlie", hillCategory: .munroTop, height: 37.5),
                            .make(name: "Delta", hillCategory: .munro, height: 56),
                            .make(name: "Echo", hillCategory: .munroTop, height: 10),
                        ]
                        
                        actual = Filter.byHeight(munros: data, min: 5, max: 100)
                    }
                    
                    it("should return correct number of matching items") {
                        expect(actual) == expected
                    }
                }
                
                context("none specified") {
                    beforeEach {
                        expected = [
                            .make(name: "Alpha", hillCategory: .munro, height: 1),
                            .make(name: "Bravo", hillCategory: .munro, height: 1000),
                            .make(name: "Charlie", hillCategory: .munroTop, height: 37.5),
                            .make(name: "Delta", hillCategory: .munro, height: 56),
                            .make(name: "Echo", hillCategory: .munroTop, height: 10),
                        ]
                        
                        actual = Filter.byHeight(munros: data, max: nil)
                    }
                    
                    it("should return correct number of matching items") {
                        expect(actual) == expected
                    }
                }
                
                context("only minimum specified") {
                    beforeEach {
                        expected = [
                            .make(name: "Bravo", hillCategory: .munro, height: 1000),
                            .make(name: "Charlie", hillCategory: .munroTop, height: 37.5),
                            .make(name: "Delta", hillCategory: .munro, height: 56),
                            .make(name: "Echo", hillCategory: .munroTop, height: 10),
                        ]
                        
                        actual = Filter.byHeight(munros: data, min: 5, max: nil)
                    }
                    
                    it("should return correct number of matching items") {
                        expect(actual) == expected
                    }
                }
                
                context("only maximum specified") {
                    beforeEach {
                        expected = [
                            .make(name: "Alpha", hillCategory: .munro, height: 1),
                            .make(name: "Charlie", hillCategory: .munroTop, height: 37.5),
                            .make(name: "Delta", hillCategory: .munro, height: 56),
                            .make(name: "Echo", hillCategory: .munroTop, height: 10),
                        ]
                        
                        actual = Filter.byHeight(munros: data, max: 100)
                    }
                    
                    it("should return correct number of matching items") {
                        expect(actual) == expected
                    }
                }
            }
        }
    }
}
