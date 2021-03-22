import Nimble
import Quick
@testable import Shared

class MunroSortSpec: QuickSpec {
    override func spec() {
        describe("MunroSort") {
            typealias sut = MunroSort
            let data: [Munro] = [
                .make(name: "Bravo", height: 2.5),
                .make(name: "Echo", height: 8.6),
                .make(name: "Alpha", height: 1),
                .make(name: "Charlie", height: 10),
                .make(name: "Delta", height: 3.7),
            ]
            
            var actual: [Munro]!
            var expected: [Munro]!
            
            context("When sorting by name") {
                context("by ascending") {
                    beforeEach {
                        expected = [
                            .make(name: "Alpha", height: 1),
                            .make(name: "Bravo", height: 2.5),
                            .make(name: "Charlie", height: 10),
                            .make(name: "Delta", height: 3.7),
                            .make(name: "Echo", height: 8.6),
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
                            .make(name: "Echo", height: 8.6),
                            .make(name: "Delta", height: 3.7),
                            .make(name: "Charlie", height: 10),
                            .make(name: "Bravo", height: 2.5),
                            .make(name: "Alpha", height: 1),
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
                            .make(name: "Alpha", height: 1),
                            .make(name: "Bravo", height: 2.5),
                            .make(name: "Charlie", height: 10),
                            .make(name: "Delta", height: 3.7),
                            .make(name: "Echo", height: 8.6),
                        ]
                        
                        actual = sut.byName(munros: data)
                    }
                    
                    it("should default to sorting by ascending") {
                        expect(actual) == expected
                        
                    }
                }
            }
            
            context("when sorting by height") {
                context("by ascending") {
                    beforeEach {
                        expected = [
                            .make(name: "Alpha", height: 1),
                            .make(name: "Bravo", height: 2.5),
                            .make(name: "Delta", height: 3.7),
                            .make(name: "Echo", height: 8.6),
                            .make(name: "Charlie", height: 10),
                        ]
                        actual = sut.byHeight(munros: data, orderBy: .ascending)
                    }
                    
                    it("should return list in correct order") {
                        expect(actual) == expected
                    }
                }
                
                context("by descending") {
                    beforeEach {
                        expected = [
                            .make(name: "Charlie", height: 10),
                            .make(name: "Echo", height: 8.6),
                            .make(name: "Delta", height: 3.7),
                            .make(name: "Bravo", height: 2.5),
                            .make(name: "Alpha", height: 1),
                            
                        ]
                        actual = sut.byHeight(munros: data, orderBy: .descending)
                    }
                    
                    it("should return list in correct order") {
                        expect(actual) == expected
                    }
                }
                
                context("orderBy is not specified") {
                    beforeEach {
                        expected = [
                            .make(name: "Alpha", height: 1),
                            .make(name: "Bravo", height: 2.5),
                            .make(name: "Delta", height: 3.7),
                            .make(name: "Echo", height: 8.6),
                            .make(name: "Charlie", height: 10),
                        ]
                        actual = sut.byHeight(munros: data)
                    }
                    
                    it("should default to sorting by ascending") {
                        expect(actual) == expected
                    }
                }
            }
        }
    }
}
