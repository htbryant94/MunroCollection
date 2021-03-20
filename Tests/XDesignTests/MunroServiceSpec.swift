import Nimble
import Quick
@testable import Shared

class MunroServiceSpec: QuickSpec {
    override func spec() {
        describe("MunroService") {
            var sut: MunroService!
            var actual: [Munro]!
            var expected: [Munro]!
            
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
                actual = nil
                expected = nil
            }
            
            context("fetch") {
                context("Hill Category Munro") {
                    context("Sort: name ascending") {
                        beforeEach {
                            expected = [
                                .init(name: "Alpha", hillCategory: .munro, height: 100),
                                .init(name: "Charlie", hillCategory: .munro, height: 75),
                                .init(name: "Echo", hillCategory: .munro, height: 10),
                                .init(name: "Hotel", hillCategory: .munro, height: 500),
                                .init(name: "India", hillCategory: .munro, height: 99),
                            ]
                            actual = sut.fetch(data, sortType: .name(.ascending), filter: .munro)
                        }
                        
                        it("should return expected list of Munros") {
                            expect(actual) == expected
                        }
                    }
                    
                    context("Sort: name descending") {
                        beforeEach {
                            expected = [
                                .init(name: "India", hillCategory: .munro, height: 99),
                                .init(name: "Hotel", hillCategory: .munro, height: 500),
                                .init(name: "Echo", hillCategory: .munro, height: 10),
                                .init(name: "Charlie", hillCategory: .munro, height: 75),
                                .init(name: "Alpha", hillCategory: .munro, height: 100),
                            ]
                            actual = sut.fetch(data, sortType: .name(.descending), filter: .munro)
                        }
                        
                        it("should return expected list of Munros") {
                            expect(actual) == expected
                        }
                    }
                    
                    context("Sort: height ascending") {
                        beforeEach {
                            expected = [
                                .init(name: "Echo", hillCategory: .munro, height: 10),
                                .init(name: "Charlie", hillCategory: .munro, height: 75),
                                .init(name: "India", hillCategory: .munro, height: 99),
                                .init(name: "Alpha", hillCategory: .munro, height: 100),
                                .init(name: "Hotel", hillCategory: .munro, height: 500),
                            ]
                            actual = sut.fetch(data, sortType: .height(.ascending), filter: .munro)
                        }
                        
                        it("should return expected list of Munros") {
                            expect(actual) == expected
                        }
                    }
                    
                    context("Sort: height descending") {
                        beforeEach {
                            expected = [
                                .init(name: "Hotel", hillCategory: .munro, height: 500),
                                .init(name: "Alpha", hillCategory: .munro, height: 100),
                                .init(name: "India", hillCategory: .munro, height: 99),
                                .init(name: "Charlie", hillCategory: .munro, height: 75),
                                .init(name: "Echo", hillCategory: .munro, height: 10),
                            ]
                            actual = sut.fetch(data, sortType: .height(.descending), filter: .munro)
                        }
                        
                        it("should return expected list of Munros") {
                            expect(actual) == expected
                        }
                    }
                }
                
                context("Hill Category Munro Top") {
                    context("Sort: name ascending") {
                        beforeEach {
                            expected = [
                                .init(name: "Bravo", hillCategory: .munroTop, height: 1),
                                .init(name: "Delta", hillCategory: .munroTop, height: 1000),
                                .init(name: "Foxtrot", hillCategory: .munroTop, height: 250),
                                .init(name: "Golf", hillCategory: .munroTop, height: 34),
                                .init(name: "Juliet", hillCategory: .munroTop, height: 375),
                            ]
                            actual = sut.fetch(data, sortType: .name(.ascending), filter: .munroTop)
                        }
                        
                        it("should return expected list of Munros") {
                            expect(actual) == expected
                        }
                    }
                    
                    context("Sort: name descending") {
                        beforeEach {
                            expected = [
                                .init(name: "Juliet", hillCategory: .munroTop, height: 375),
                                .init(name: "Golf", hillCategory: .munroTop, height: 34),
                                .init(name: "Foxtrot", hillCategory: .munroTop, height: 250),
                                .init(name: "Delta", hillCategory: .munroTop, height: 1000),
                                .init(name: "Bravo", hillCategory: .munroTop, height: 1),
                            ]
                            actual = sut.fetch(data, sortType: .name(.descending), filter: .munroTop)
                        }
                        
                        it("should return expected list of Munros") {
                            expect(actual) == expected
                        }
                    }
                    
                    context("Sort: height ascending") {
                        beforeEach {
                            expected = [
                                .init(name: "Bravo", hillCategory: .munroTop, height: 1),
                                .init(name: "Golf", hillCategory: .munroTop, height: 34),
                                .init(name: "Foxtrot", hillCategory: .munroTop, height: 250),
                                .init(name: "Juliet", hillCategory: .munroTop, height: 375),
                                .init(name: "Delta", hillCategory: .munroTop, height: 1000),
                            ]
                            actual = sut.fetch(data, sortType: .height(.ascending), filter: .munroTop)
                        }
                        
                        it("should return expected list of Munros") {
                            expect(actual) == expected
                        }
                    }
                    
                    context("Sort: height descending") {
                        beforeEach {
                            expected = [
                                .init(name: "Delta", hillCategory: .munroTop, height: 1000),
                                .init(name: "Juliet", hillCategory: .munroTop, height: 375),
                                .init(name: "Foxtrot", hillCategory: .munroTop, height: 250),
                                .init(name: "Golf", hillCategory: .munroTop, height: 34),
                                .init(name: "Bravo", hillCategory: .munroTop, height: 1),
                            ]
                            actual = sut.fetch(data, sortType: .height(.descending), filter: .munroTop)
                        }
                        
                        it("should return expected list of Munros") {
                            expect(actual) == expected
                        }
                    }
                }
            }
        }
    }
}

public class MunroService {
    
    typealias Filter = MunroFilter
    typealias Sort = MunroSort
    
    public enum SortType {
        case name(MunroSort.Direction)
        case height(MunroSort.Direction)
    }
    
    public func fetch(
        _ data: [Munro],
        sortType: SortType,
        filter: Munro.HillCategory
    ) -> [Munro] {
        let filtered = Filter.byHillCategory(munros: data, hillCategory: filter)
        
        var sorted: [Munro]
        
        switch sortType {
        case let .name(direction):
            sorted = Sort.byName(munros: filtered, orderBy: direction)
        case let .height(direction):
            sorted = Sort.byHeight(munros: filtered, orderBy: direction)
        }
        
        return sorted
    }
}

