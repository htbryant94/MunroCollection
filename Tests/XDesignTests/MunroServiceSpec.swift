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
                            actual = sut.fetch(
                                data,
                                sortType: .name(.ascending),
                                hillCategory: .munro
                            )
                        }
                        
                        it("should return expected list of Munros") {
                            expect(actual) == expected
                        }
                        
                        context("Filter: min specified") {
                            beforeEach {
                                expected = [
                                    .init(name: "Alpha", hillCategory: .munro, height: 100),
                                    .init(name: "Hotel", hillCategory: .munro, height: 500),
                                    .init(name: "India", hillCategory: .munro, height: 99),
                                ]
                                actual = sut.fetch(
                                    data,
                                    sortType: .name(.ascending),
                                    hillCategory: .munro,
                                    minHeight: 80
                                )
                            }
                            
                            it("should return expected list of Munros") {
                                expect(actual) == expected
                            }
                        }
                        
                        context("Filter: max specified") {
                            beforeEach {
                                expected = [
                                    .init(name: "Charlie", hillCategory: .munro, height: 75),
                                    .init(name: "Echo", hillCategory: .munro, height: 10),
                                    .init(name: "India", hillCategory: .munro, height: 99),
                                ]
                                actual = sut.fetch(
                                    data,
                                    sortType: .name(.ascending),
                                    hillCategory: .munro,
                                    maxHeight: 99
                                )
                            }
                            
                            it("should return expected list of Munros") {
                                expect(actual) == expected
                            }
                        }
                        
                        context("Filter: min max specified") {
                            beforeEach {
                                expected = [
                                    .init(name: "Charlie", hillCategory: .munro, height: 75),
                                    .init(name: "India", hillCategory: .munro, height: 99),
                                ]
                                actual = sut.fetch(
                                    data,
                                    sortType: .name(.ascending),
                                    hillCategory: .munro,
                                    minHeight: 20,
                                    maxHeight: 99
                                )
                            }
                            
                            it("should return expected list of Munros") {
                                expect(actual) == expected
                            }
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
                            actual = sut.fetch(
                                data,
                                sortType: .name(.descending),
                                hillCategory: .munro
                            )
                        }
                        
                        it("should return expected list of Munros") {
                            expect(actual) == expected
                        }
                        
                        context("Filter: min specified") {
                            beforeEach {
                                expected = [
                                    .init(name: "India", hillCategory: .munro, height: 99),
                                    .init(name: "Hotel", hillCategory: .munro, height: 500),
                                    .init(name: "Alpha", hillCategory: .munro, height: 100),
                                ]
                                actual = sut.fetch(
                                    data,
                                    sortType: .name(.descending),
                                    hillCategory: .munro,
                                    minHeight: 80
                                )
                            }
                            
                            it("should return expected list of Munros") {
                                expect(actual) == expected
                            }
                        }
                        
                        context("Filter: max specified") {
                            beforeEach {
                                expected = [
                                    .init(name: "India", hillCategory: .munro, height: 99),
                                    .init(name: "Echo", hillCategory: .munro, height: 10),
                                    .init(name: "Charlie", hillCategory: .munro, height: 75),
                                ]
                                actual = sut.fetch(
                                    data,
                                    sortType: .name(.descending),
                                    hillCategory: .munro,
                                    maxHeight: 99
                                )
                            }
                            
                            it("should return expected list of Munros") {
                                expect(actual) == expected
                            }
                        }
                        
                        context("Filter: min max specified") {
                            beforeEach {
                                expected = [
                                    .init(name: "India", hillCategory: .munro, height: 99),
                                    .init(name: "Charlie", hillCategory: .munro, height: 75),
                                ]
                                actual = sut.fetch(
                                    data,
                                    sortType: .name(.descending),
                                    hillCategory: .munro,
                                    minHeight: 20,
                                    maxHeight: 99
                                )
                            }
                            
                            it("should return expected list of Munros") {
                                expect(actual) == expected
                            }
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
                            actual = sut.fetch(
                                data,
                                sortType: .height(.ascending),
                                hillCategory: .munro
                            )
                        }
                        
                        it("should return expected list of Munros") {
                            expect(actual) == expected
                        }
                        
                        context("Filter: min specified") {
                            beforeEach {
                                expected = [
                                    .init(name: "Charlie", hillCategory: .munro, height: 75),
                                    .init(name: "India", hillCategory: .munro, height: 99),
                                    .init(name: "Alpha", hillCategory: .munro, height: 100),
                                    .init(name: "Hotel", hillCategory: .munro, height: 500),
                                ]
                                actual = sut.fetch(
                                    data,
                                    sortType: .height(.ascending),
                                    hillCategory: .munro,
                                    minHeight: 20
                                )
                            }
                            
                            it("should return expected list of Munros") {
                                expect(actual) == expected
                            }
                        }
                        
                        context("Filter: max specified") {
                            beforeEach {
                                expected = [
                                    .init(name: "Echo", hillCategory: .munro, height: 10),
                                    .init(name: "Charlie", hillCategory: .munro, height: 75),
                                    .init(name: "India", hillCategory: .munro, height: 99),
                                ]
                                actual = sut.fetch(
                                    data,
                                    sortType: .height(.ascending),
                                    hillCategory: .munro,
                                    maxHeight: 99
                                )
                            }
                            
                            it("should return expected list of Munros") {
                                expect(actual) == expected
                            }
                        }
                        
                        context("Filter: min max specified") {
                            beforeEach {
                                expected = [
                                    .init(name: "Charlie", hillCategory: .munro, height: 75),
                                    .init(name: "India", hillCategory: .munro, height: 99),
                                ]
                                actual = sut.fetch(
                                    data,
                                    sortType: .height(.ascending),
                                    hillCategory: .munro,
                                    minHeight: 20,
                                    maxHeight: 99
                                )
                            }
                            
                            it("should return expected list of Munros") {
                                expect(actual) == expected
                            }
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
                            actual = sut.fetch(
                                data,
                                sortType: .height(.descending),
                                hillCategory: .munro
                            )
                        }
                        
                        it("should return expected list of Munros") {
                            expect(actual) == expected
                        }
                        
                        context("Filter: min specified") {
                            beforeEach {
                                expected = [
                                    .init(name: "Hotel", hillCategory: .munro, height: 500),
                                    .init(name: "Alpha", hillCategory: .munro, height: 100),
                                    .init(name: "India", hillCategory: .munro, height: 99),
                                    .init(name: "Charlie", hillCategory: .munro, height: 75),
                                ]
                                actual = sut.fetch(
                                    data,
                                    sortType: .height(.descending),
                                    hillCategory: .munro,
                                    minHeight: 20
                                )
                            }
                            
                            it("should return expected list of Munros") {
                                expect(actual) == expected
                            }
                        }
                        
                        context("Filter: max specified") {
                            beforeEach {
                                expected = [
                                    .init(name: "India", hillCategory: .munro, height: 99),
                                    .init(name: "Charlie", hillCategory: .munro, height: 75),
                                    .init(name: "Echo", hillCategory: .munro, height: 10),
                                ]
                                actual = sut.fetch(
                                    data,
                                    sortType: .height(.descending),
                                    hillCategory: .munro,
                                    maxHeight: 99
                                )
                            }
                            
                            it("should return expected list of Munros") {
                                expect(actual) == expected
                            }
                        }
                        
                        context("Filter: min max specified") {
                            beforeEach {
                                expected = [
                                    .init(name: "India", hillCategory: .munro, height: 99),
                                    .init(name: "Charlie", hillCategory: .munro, height: 75),
                                ]
                                actual = sut.fetch(
                                    data,
                                    sortType: .height(.descending),
                                    hillCategory: .munro,
                                    minHeight: 20,
                                    maxHeight: 99
                                )
                            }
                            
                            it("should return expected list of Munros") {
                                expect(actual) == expected
                            }
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
                            actual = sut.fetch(
                                data,
                                sortType: .name(.ascending),
                                hillCategory: .munroTop
                            )
                        }
                        
                        it("should return expected list of Munros") {
                            expect(actual) == expected
                        }
                        
                        context("Filter: min specified") {
                            beforeEach {
                                expected = [
                                    .init(name: "Delta", hillCategory: .munroTop, height: 1000),
                                    .init(name: "Foxtrot", hillCategory: .munroTop, height: 250),
                                    .init(name: "Juliet", hillCategory: .munroTop, height: 375),
                                ]
                                actual = sut.fetch(
                                    data,
                                    sortType: .name(.ascending),
                                    hillCategory: .munroTop,
                                    minHeight: 80
                                )
                            }
                            
                            it("should return expected list of Munros") {
                                expect(actual) == expected
                            }
                        }
                        
                        context("Filter: max specified") {
                            beforeEach {
                                expected = [
                                    .init(name: "Bravo", hillCategory: .munroTop, height: 1),
                                    .init(name: "Golf", hillCategory: .munroTop, height: 34),
                                ]
                                actual = sut.fetch(
                                    data,
                                    sortType: .name(.ascending),
                                    hillCategory: .munroTop,
                                    maxHeight: 99
                                )
                            }
                            
                            it("should return expected list of Munros") {
                                expect(actual) == expected
                            }
                        }
                        
                        context("Filter: min max specified") {
                            beforeEach {
                                expected = [
                                    .init(name: "Golf", hillCategory: .munroTop, height: 34),
                                ]
                                actual = sut.fetch(
                                    data,
                                    sortType: .name(.ascending),
                                    hillCategory: .munroTop,
                                    minHeight: 20,
                                    maxHeight: 99
                                )
                            }
                            
                            it("should return expected list of Munros") {
                                expect(actual) == expected
                            }
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
                            actual = sut.fetch(
                                data,
                                sortType: .name(.descending),
                                hillCategory: .munroTop
                            )
                        }
                        
                        it("should return expected list of Munros") {
                            expect(actual) == expected
                        }
                        
                        context("Filter: min specified") {
                            beforeEach {
                                expected = [
                                    .init(name: "Juliet", hillCategory: .munroTop, height: 375),
                                    .init(name: "Foxtrot", hillCategory: .munroTop, height: 250),
                                    .init(name: "Delta", hillCategory: .munroTop, height: 1000),
                                ]
                                actual = sut.fetch(
                                    data,
                                    sortType: .name(.descending),
                                    hillCategory: .munroTop,
                                    minHeight: 80
                                )
                            }
                            
                            it("should return expected list of Munros") {
                                expect(actual) == expected
                            }
                        }
                        
                        context("Filter: max specified") {
                            beforeEach {
                                expected = [
                                    .init(name: "Golf", hillCategory: .munroTop, height: 34),
                                    .init(name: "Bravo", hillCategory: .munroTop, height: 1),
                                ]
                                actual = sut.fetch(
                                    data,
                                    sortType: .name(.descending),
                                    hillCategory: .munroTop,
                                    maxHeight: 99
                                )
                            }
                            
                            it("should return expected list of Munros") {
                                expect(actual) == expected
                            }
                        }
                        
                        context("Filter: min max specified") {
                            beforeEach {
                                expected = [
                                    .init(name: "Golf", hillCategory: .munroTop, height: 34),
                                ]
                                actual = sut.fetch(
                                    data,
                                    sortType: .name(.descending),
                                    hillCategory: .munroTop,
                                    minHeight: 20,
                                    maxHeight: 99
                                )
                            }
                            
                            it("should return expected list of Munros") {
                                expect(actual) == expected
                            }
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
                            actual = sut.fetch(
                                data,
                                sortType: .height(.ascending),
                                hillCategory: .munroTop
                            )
                        }
                        
                        it("should return expected list of Munros") {
                            expect(actual) == expected
                        }
                        
                        context("Filter: min specified") {
                            beforeEach {
                                expected = [
                                    .init(name: "Foxtrot", hillCategory: .munroTop, height: 250),
                                    .init(name: "Juliet", hillCategory: .munroTop, height: 375),
                                    .init(name: "Delta", hillCategory: .munroTop, height: 1000),
                                ]
                                actual = sut.fetch(
                                    data,
                                    sortType: .height(.ascending),
                                    hillCategory: .munroTop,
                                    minHeight: 80
                                )
                            }
                            
                            it("should return expected list of Munros") {
                                expect(actual) == expected
                            }
                        }
                        
                        context("Filter: max specified") {
                            beforeEach {
                                expected = [
                                    .init(name: "Bravo", hillCategory: .munroTop, height: 1),
                                    .init(name: "Golf", hillCategory: .munroTop, height: 34),
                                ]
                                actual = sut.fetch(
                                    data,
                                    sortType: .height(.ascending),
                                    hillCategory: .munroTop,
                                    maxHeight: 99
                                )
                            }
                            
                            it("should return expected list of Munros") {
                                expect(actual) == expected
                            }
                        }
                        
                        context("Filter: min max specified") {
                            beforeEach {
                                expected = [
                                    .init(name: "Golf", hillCategory: .munroTop, height: 34),
                                ]
                                actual = sut.fetch(
                                    data,
                                    sortType: .height(.ascending),
                                    hillCategory: .munroTop,
                                    minHeight: 20,
                                    maxHeight: 99
                                )
                            }
                            
                            it("should return expected list of Munros") {
                                expect(actual) == expected
                            }
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
                            actual = sut.fetch(
                                data,
                                sortType: .height(.descending),
                                hillCategory: .munroTop
                            )
                        }
                        
                        it("should return expected list of Munros") {
                            expect(actual) == expected
                        }
                        
                        context("Filter: min specified") {
                            beforeEach {
                                expected = [
                                    .init(name: "Delta", hillCategory: .munroTop, height: 1000),
                                    .init(name: "Juliet", hillCategory: .munroTop, height: 375),
                                    .init(name: "Foxtrot", hillCategory: .munroTop, height: 250),
                                ]
                                actual = sut.fetch(
                                    data,
                                    sortType: .height(.descending),
                                    hillCategory: .munroTop,
                                    minHeight: 80
                                )
                            }
                            
                            it("should return expected list of Munros") {
                                expect(actual) == expected
                            }
                        }
                        
                        context("Filter: max specified") {
                            beforeEach {
                                expected = [
                                    .init(name: "Golf", hillCategory: .munroTop, height: 34),
                                    .init(name: "Bravo", hillCategory: .munroTop, height: 1),
                                ]
                                actual = sut.fetch(
                                    data,
                                    sortType: .height(.descending),
                                    hillCategory: .munroTop,
                                    maxHeight: 99
                                )
                            }
                            
                            it("should return expected list of Munros") {
                                expect(actual) == expected
                            }
                        }
                        
                        context("Filter: min max specified") {
                            beforeEach {
                                expected = [
                                    .init(name: "Golf", hillCategory: .munroTop, height: 34),
                                ]
                                actual = sut.fetch(
                                    data,
                                    sortType: .height(.descending),
                                    hillCategory: .munroTop,
                                    minHeight: 20,
                                    maxHeight: 99
                                )
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
        hillCategory: Munro.HillCategory? = nil,
        minHeight: Double? = nil,
        maxHeight: Double? = nil
    ) -> [Munro] {
        var results = data
        
        if let hillCategory = hillCategory {
            results = Filter.byHillCategory(munros: data, hillCategory: hillCategory)
        }
        
        results = Filter.byHeight(
            munros: results,
            min: minHeight,
            max: maxHeight,
            limit: nil
        )
        
        switch sortType {
        case let .name(direction):
            results = Sort.byName(munros: results, orderBy: direction)
        case let .height(direction):
            results = Sort.byHeight(munros: results, orderBy: direction)
        }
        
        return results
    }
}

