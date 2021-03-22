import Nimble
import Quick
import Foundation
@testable import Shared

class MunroServiceSpec: QuickSpec {
    override func spec() {
        describe("MunroService") {
            var sut: MunroService!
            var actual: [Munro]!
            var expected: [Munro]!
            
            let data: [Munro] = [
                .make(name: "Bravo", hillCategory: .munroTop, height: 1),
                .make(name: "Echo", hillCategory: .munro, height: 10),
                .make(name: "Charlie", hillCategory: .munro, height: 75),
                .make(name: "Alpha", hillCategory: .munro, height: 100),
                .make(name: "Delta", hillCategory: .munroTop, height: 1000),
                .make(name: "Foxtrot", hillCategory: .munroTop, height: 250),
                .make(name: "Juliet", hillCategory: .munroTop, height: 375),
                .make(name: "Golf", hillCategory: .munroTop, height: 34),
                .make(name: "India", hillCategory: .munro, height: 99),
                .make(name: "Hotel", hillCategory: .munro, height: 500),
            ]
            
            beforeEach {
                sut = MunroService()
                actual = nil
                expected = nil
            }
            
            context("fetch") {
                context("invalid query") {
                    var actual: Error!
                    var expected: String!
                    
                    context("when results count is 0") {
                        beforeEach {
                            expected = "No results found, try expanding your search parameters"
                            sut.fetch(data, minHeight: 10000) { result in
                                switch result {
                                case let .failure(error): actual = error
                                default:
                                    break
                                }
                            }
                        }
                        
                        it("should return error with appropriate localized description") {
                            expect(actual.localizedDescription) == expected
                        }
                    }
                    
                    context("invalid params") {
                        context("when max height is less than the minimum height") {
                            beforeEach {
                                expected = "minHeight cannot be greater than or equal to maxHeight"
                                sut.fetch(data, minHeight: 100, maxHeight: 50) { result in
                                    switch result {
                                    case let .failure(error): actual = error
                                    default:
                                        break
                                    }
                                }
                            }

                            it("should return an error") {
                                expect(actual.localizedDescription) == expected
                            }
                        }
                        
                        context("when max height is less than the minimum height") {
                            beforeEach {
                                expected = "minHeight cannot be greater than or equal to maxHeight"
                                sut.fetch(data, minHeight: 100, maxHeight: 50) { result in
                                    switch result {
                                    case let .failure(error): actual = error
                                    default:
                                        break
                                    }
                                }
                            }

                            it("should return an error") {
                                expect(actual.localizedDescription) == expected
                            }
                        }
                        
                        context("when min height is 0") {
                            beforeEach {
                                expected = "minHeight cannot be 0"
                                sut.fetch(data, minHeight: 0) { result in
                                    switch result {
                                    case let .failure(error): actual = error
                                    default:
                                        break
                                    }
                                }
                            }

                            it("should return an error") {
                                expect(actual.localizedDescription) == expected
                            }
                        }
                    }
                }
                
                context("default params") {
                    beforeEach {
                        expected = [
                            .make(name: "Alpha", hillCategory: .munro, height: 100),
                            .make(name: "Bravo", hillCategory: .munroTop, height: 1),
                            .make(name: "Charlie", hillCategory: .munro, height: 75),
                            .make(name: "Delta", hillCategory: .munroTop, height: 1000),
                            .make(name: "Echo", hillCategory: .munro, height: 10),
                            .make(name: "Foxtrot", hillCategory: .munroTop, height: 250),
                            .make(name: "Golf", hillCategory: .munroTop, height: 34),
                            .make(name: "Hotel", hillCategory: .munro, height: 500),
                            .make(name: "India", hillCategory: .munro, height: 99),
                            .make(name: "Juliet", hillCategory: .munroTop, height: 375),
                        ]
                        
                        sut.fetch(data) { result in
                            switch result {
                            case let .success(result): actual = result
                            default: break
                            }
                        }
                    }
                    
                    it("should return expected list of Munros") {
                        expect(actual) == expected
                    }
                    
                    context("with limit") {
                        context("below the results count") {
                            beforeEach {
                                expected = [
                                    .make(name: "Alpha", hillCategory: .munro, height: 100),
                                    .make(name: "Bravo", hillCategory: .munroTop, height: 1),
                                    .make(name: "Charlie", hillCategory: .munro, height: 75),
                                    .make(name: "Delta", hillCategory: .munroTop, height: 1000),
                                    .make(name: "Echo", hillCategory: .munro, height: 10),
                                ]
                                sut.fetch(data, limit: 5) { result in
                                    switch result {
                                    case let .success(result): actual = result
                                    default: break
                                    }
                                }
                            }
                            
                            it("should return correct number of Munros") {
                                expect(actual) == expected
                            }
                        }
                        
                        context("above the results count") {
                            beforeEach {
                                expected = [
                                    .make(name: "Alpha", hillCategory: .munro, height: 100),
                                    .make(name: "Bravo", hillCategory: .munroTop, height: 1),
                                    .make(name: "Charlie", hillCategory: .munro, height: 75),
                                    .make(name: "Delta", hillCategory: .munroTop, height: 1000),
                                    .make(name: "Echo", hillCategory: .munro, height: 10),
                                    .make(name: "Foxtrot", hillCategory: .munroTop, height: 250),
                                    .make(name: "Golf", hillCategory: .munroTop, height: 34),
                                    .make(name: "Hotel", hillCategory: .munro, height: 500),
                                    .make(name: "India", hillCategory: .munro, height: 99),
                                    .make(name: "Juliet", hillCategory: .munroTop, height: 375),
                                ]
                                sut.fetch(data, limit: 1000) { result in
                                    switch result {
                                    case let .success(result): actual = result
                                    default: break
                                    }
                                }
                            }
                            
                            it("should not limit the list of Munros") {
                                expect(actual) == expected
                            }
                        }
                       
                    }
                }
                
                context("Hill Category Munro") {
                    context("Sort: name ascending") {
                        beforeEach {
                            expected = [
                                .make(name: "Alpha", hillCategory: .munro, height: 100),
                                .make(name: "Charlie", hillCategory: .munro, height: 75),
                                .make(name: "Echo", hillCategory: .munro, height: 10),
                                .make(name: "Hotel", hillCategory: .munro, height: 500),
                                .make(name: "India", hillCategory: .munro, height: 99),
                            ]
                            sut.fetch(
                                data,
                                sortType: .name(.ascending),
                                hillCategory: .munro
                            ) { result in
                                switch result {
                                case let .success(result): actual = result
                                default: break
                                }
                            }
                        }
                        
                        it("should return expected list of Munros") {
                            expect(actual) == expected
                        }
                        
                        context("Filter: min specified") {
                            beforeEach {
                                expected = [
                                    .make(name: "Alpha", hillCategory: .munro, height: 100),
                                    .make(name: "Hotel", hillCategory: .munro, height: 500),
                                    .make(name: "India", hillCategory: .munro, height: 99),
                                ]
                                sut.fetch(
                                    data,
                                    sortType: .name(.ascending),
                                    hillCategory: .munro,
                                    minHeight: 80
                                ) { result in
                                    switch result {
                                    case let .success(result): actual = result
                                    default: break
                                    }
                                }
                            }
                            
                            it("should return expected list of Munros") {
                                expect(actual) == expected
                            }
                        }
                        
                        context("Filter: max specified") {
                            beforeEach {
                                expected = [
                                    .make(name: "Charlie", hillCategory: .munro, height: 75),
                                    .make(name: "Echo", hillCategory: .munro, height: 10),
                                    .make(name: "India", hillCategory: .munro, height: 99),
                                ]
                                sut.fetch(
                                    data,
                                    sortType: .name(.ascending),
                                    hillCategory: .munro,
                                    maxHeight: 99
                                ) { result in
                                    switch result {
                                    case let .success(result): actual = result
                                    default: break
                                    }
                                }
                            }
                            
                            it("should return expected list of Munros") {
                                expect(actual) == expected
                            }
                        }
                        
                        context("Filter: min max specified") {
                            beforeEach {
                                expected = [
                                    .make(name: "Charlie", hillCategory: .munro, height: 75),
                                    .make(name: "India", hillCategory: .munro, height: 99),
                                ]
                                sut.fetch(
                                    data,
                                    sortType: .name(.ascending),
                                    hillCategory: .munro,
                                    minHeight: 20,
                                    maxHeight: 99
                                ) { result in
                                    switch result {
                                    case let .success(result): actual = result
                                    default: break
                                    }
                                }
                            }
                            
                            it("should return expected list of Munros") {
                                expect(actual) == expected
                            }
                        }
                    }
                    
                    context("Sort: name descending") {
                        beforeEach {
                            expected = [
                                .make(name: "India", hillCategory: .munro, height: 99),
                                .make(name: "Hotel", hillCategory: .munro, height: 500),
                                .make(name: "Echo", hillCategory: .munro, height: 10),
                                .make(name: "Charlie", hillCategory: .munro, height: 75),
                                .make(name: "Alpha", hillCategory: .munro, height: 100),
                            ]
                            sut.fetch(
                                data,
                                sortType: .name(.descending),
                                hillCategory: .munro
                            ) { result in
                                switch result {
                                case let .success(result): actual = result
                                default: break
                                }
                            }
                        }
                        
                        it("should return expected list of Munros") {
                            expect(actual) == expected
                        }
                        
                        context("Filter: min specified") {
                            beforeEach {
                                expected = [
                                    .make(name: "India", hillCategory: .munro, height: 99),
                                    .make(name: "Hotel", hillCategory: .munro, height: 500),
                                    .make(name: "Alpha", hillCategory: .munro, height: 100),
                                ]
                                sut.fetch(
                                    data,
                                    sortType: .name(.descending),
                                    hillCategory: .munro,
                                    minHeight: 80
                                ) { result in
                                    switch result {
                                    case let .success(result): actual = result
                                    default: break
                                    }
                                }
                            }
                            
                            it("should return expected list of Munros") {
                                expect(actual) == expected
                            }
                        }
                        
                        context("Filter: max specified") {
                            beforeEach {
                                expected = [
                                    .make(name: "India", hillCategory: .munro, height: 99),
                                    .make(name: "Echo", hillCategory: .munro, height: 10),
                                    .make(name: "Charlie", hillCategory: .munro, height: 75),
                                ]
                                sut.fetch(
                                    data,
                                    sortType: .name(.descending),
                                    hillCategory: .munro,
                                    maxHeight: 99
                                ) { result in
                                    switch result {
                                    case let .success(result): actual = result
                                    default: break
                                    }
                                }
                            }
                            
                            it("should return expected list of Munros") {
                                expect(actual) == expected
                            }
                        }
                        
                        context("Filter: min max specified") {
                            beforeEach {
                                expected = [
                                    .make(name: "India", hillCategory: .munro, height: 99),
                                    .make(name: "Charlie", hillCategory: .munro, height: 75),
                                ]
                                sut.fetch(
                                    data,
                                    sortType: .name(.descending),
                                    hillCategory: .munro,
                                    minHeight: 20,
                                    maxHeight: 99
                                ) { result in
                                    switch result {
                                    case let .success(result): actual = result
                                    default: break
                                    }
                                }
                            }
                            
                            it("should return expected list of Munros") {
                                expect(actual) == expected
                            }
                        }
                    }
                    
                    context("Sort: height ascending") {
                        beforeEach {
                            expected = [
                                .make(name: "Echo", hillCategory: .munro, height: 10),
                                .make(name: "Charlie", hillCategory: .munro, height: 75),
                                .make(name: "India", hillCategory: .munro, height: 99),
                                .make(name: "Alpha", hillCategory: .munro, height: 100),
                                .make(name: "Hotel", hillCategory: .munro, height: 500),
                            ]
                            sut.fetch(
                                data,
                                sortType: .height(.ascending),
                                hillCategory: .munro
                            ) { result in
                                switch result {
                                case let .success(result): actual = result
                                default: break
                                }
                            }
                        }
                        
                        it("should return expected list of Munros") {
                            expect(actual) == expected
                        }
                        
                        context("Filter: min specified") {
                            beforeEach {
                                expected = [
                                    .make(name: "Charlie", hillCategory: .munro, height: 75),
                                    .make(name: "India", hillCategory: .munro, height: 99),
                                    .make(name: "Alpha", hillCategory: .munro, height: 100),
                                    .make(name: "Hotel", hillCategory: .munro, height: 500),
                                ]
                                sut.fetch(
                                    data,
                                    sortType: .height(.ascending),
                                    hillCategory: .munro,
                                    minHeight: 20
                                ) { result in
                                    switch result {
                                    case let .success(result): actual = result
                                    default: break
                                    }
                                }
                            }
                            
                            it("should return expected list of Munros") {
                                expect(actual) == expected
                            }
                        }
                        
                        context("Filter: max specified") {
                            beforeEach {
                                expected = [
                                    .make(name: "Echo", hillCategory: .munro, height: 10),
                                    .make(name: "Charlie", hillCategory: .munro, height: 75),
                                    .make(name: "India", hillCategory: .munro, height: 99),
                                ]
                                sut.fetch(
                                    data,
                                    sortType: .height(.ascending),
                                    hillCategory: .munro,
                                    maxHeight: 99
                                ) { result in
                                    switch result {
                                    case let .success(result): actual = result
                                    default: break
                                    }
                                }
                            }
                            
                            it("should return expected list of Munros") {
                                expect(actual) == expected
                            }
                        }
                        
                        context("Filter: min max specified") {
                            beforeEach {
                                expected = [
                                    .make(name: "Charlie", hillCategory: .munro, height: 75),
                                    .make(name: "India", hillCategory: .munro, height: 99),
                                ]
                                sut.fetch(
                                    data,
                                    sortType: .height(.ascending),
                                    hillCategory: .munro,
                                    minHeight: 20,
                                    maxHeight: 99
                                ) { result in
                                    switch result {
                                    case let .success(result): actual = result
                                    default: break
                                    }
                                }
                            }
                            
                            it("should return expected list of Munros") {
                                expect(actual) == expected
                            }
                        }
                    }
                    
                    context("Sort: height descending") {
                        beforeEach {
                            expected = [
                                .make(name: "Hotel", hillCategory: .munro, height: 500),
                                .make(name: "Alpha", hillCategory: .munro, height: 100),
                                .make(name: "India", hillCategory: .munro, height: 99),
                                .make(name: "Charlie", hillCategory: .munro, height: 75),
                                .make(name: "Echo", hillCategory: .munro, height: 10),
                            ]
                            sut.fetch(
                                data,
                                sortType: .height(.descending),
                                hillCategory: .munro
                            ) { result in
                                switch result {
                                case let .success(result): actual = result
                                default: break
                                }
                            }
                        }
                        
                        it("should return expected list of Munros") {
                            expect(actual) == expected
                        }
                        
                        context("Filter: min specified") {
                            beforeEach {
                                expected = [
                                    .make(name: "Hotel", hillCategory: .munro, height: 500),
                                    .make(name: "Alpha", hillCategory: .munro, height: 100),
                                    .make(name: "India", hillCategory: .munro, height: 99),
                                    .make(name: "Charlie", hillCategory: .munro, height: 75),
                                ]
                                sut.fetch(
                                    data,
                                    sortType: .height(.descending),
                                    hillCategory: .munro,
                                    minHeight: 20
                                ) { result in
                                    switch result {
                                    case let .success(result): actual = result
                                    default: break
                                    }
                                }
                            }
                            
                            it("should return expected list of Munros") {
                                expect(actual) == expected
                            }
                        }
                        
                        context("Filter: max specified") {
                            beforeEach {
                                expected = [
                                    .make(name: "India", hillCategory: .munro, height: 99),
                                    .make(name: "Charlie", hillCategory: .munro, height: 75),
                                    .make(name: "Echo", hillCategory: .munro, height: 10),
                                ]
                                sut.fetch(
                                    data,
                                    sortType: .height(.descending),
                                    hillCategory: .munro,
                                    maxHeight: 99
                                ) { result in
                                    switch result {
                                    case let .success(result): actual = result
                                    default: break
                                    }
                                }
                            }
                            
                            it("should return expected list of Munros") {
                                expect(actual) == expected
                            }
                        }
                        
                        context("Filter: min max specified") {
                            beforeEach {
                                expected = [
                                    .make(name: "India", hillCategory: .munro, height: 99),
                                    .make(name: "Charlie", hillCategory: .munro, height: 75),
                                ]
                                sut.fetch(
                                    data,
                                    sortType: .height(.descending),
                                    hillCategory: .munro,
                                    minHeight: 20,
                                    maxHeight: 99
                                ) { result in
                                    switch result {
                                    case let .success(result): actual = result
                                    default: break
                                    }
                                }
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
                                .make(name: "Bravo", hillCategory: .munroTop, height: 1),
                                .make(name: "Delta", hillCategory: .munroTop, height: 1000),
                                .make(name: "Foxtrot", hillCategory: .munroTop, height: 250),
                                .make(name: "Golf", hillCategory: .munroTop, height: 34),
                                .make(name: "Juliet", hillCategory: .munroTop, height: 375),
                            ]
                            sut.fetch(
                                data,
                                sortType: .name(.ascending),
                                hillCategory: .munroTop
                            ) { result in
                                switch result {
                                case let .success(result): actual = result
                                default: break
                                }
                            }
                        }
                        
                        it("should return expected list of Munros") {
                            expect(actual) == expected
                        }
                        
                        context("Filter: min specified") {
                            beforeEach {
                                expected = [
                                    .make(name: "Delta", hillCategory: .munroTop, height: 1000),
                                    .make(name: "Foxtrot", hillCategory: .munroTop, height: 250),
                                    .make(name: "Juliet", hillCategory: .munroTop, height: 375),
                                ]
                                sut.fetch(
                                    data,
                                    sortType: .name(.ascending),
                                    hillCategory: .munroTop,
                                    minHeight: 80
                                ) { result in
                                    switch result {
                                    case let .success(result): actual = result
                                    default: break
                                    }
                                }
                            }
                            
                            it("should return expected list of Munros") {
                                expect(actual) == expected
                            }
                        }
                        
                        context("Filter: max specified") {
                            beforeEach {
                                expected = [
                                    .make(name: "Bravo", hillCategory: .munroTop, height: 1),
                                    .make(name: "Golf", hillCategory: .munroTop, height: 34),
                                ]
                                sut.fetch(
                                    data,
                                    sortType: .name(.ascending),
                                    hillCategory: .munroTop,
                                    maxHeight: 99
                                ) { result in
                                    switch result {
                                    case let .success(result): actual = result
                                    default: break
                                    }
                                }
                            }
                            
                            it("should return expected list of Munros") {
                                expect(actual) == expected
                            }
                        }
                        
                        context("Filter: min max specified") {
                            beforeEach {
                                expected = [
                                    .make(name: "Golf", hillCategory: .munroTop, height: 34),
                                ]
                                sut.fetch(
                                    data,
                                    sortType: .name(.ascending),
                                    hillCategory: .munroTop,
                                    minHeight: 20,
                                    maxHeight: 99
                                ) { result in
                                    switch result {
                                    case let .success(result): actual = result
                                    default: break
                                    }
                                }
                            }
                            
                            it("should return expected list of Munros") {
                                expect(actual) == expected
                            }
                        }
                    }
                    
                    context("Sort: name descending") {
                        beforeEach {
                            expected = [
                                .make(name: "Juliet", hillCategory: .munroTop, height: 375),
                                .make(name: "Golf", hillCategory: .munroTop, height: 34),
                                .make(name: "Foxtrot", hillCategory: .munroTop, height: 250),
                                .make(name: "Delta", hillCategory: .munroTop, height: 1000),
                                .make(name: "Bravo", hillCategory: .munroTop, height: 1),
                            ]
                            sut.fetch(
                                data,
                                sortType: .name(.descending),
                                hillCategory: .munroTop
                            ) { result in
                                switch result {
                                case let .success(result): actual = result
                                default: break
                                }
                            }
                        }
                        
                        it("should return expected list of Munros") {
                            expect(actual) == expected
                        }
                        
                        context("Filter: min specified") {
                            beforeEach {
                                expected = [
                                    .make(name: "Juliet", hillCategory: .munroTop, height: 375),
                                    .make(name: "Foxtrot", hillCategory: .munroTop, height: 250),
                                    .make(name: "Delta", hillCategory: .munroTop, height: 1000),
                                ]
                                sut.fetch(
                                    data,
                                    sortType: .name(.descending),
                                    hillCategory: .munroTop,
                                    minHeight: 80
                                ) { result in
                                    switch result {
                                    case let .success(result): actual = result
                                    default: break
                                    }
                                }
                            }
                            
                            it("should return expected list of Munros") {
                                expect(actual) == expected
                            }
                        }
                        
                        context("Filter: max specified") {
                            beforeEach {
                                expected = [
                                    .make(name: "Golf", hillCategory: .munroTop, height: 34),
                                    .make(name: "Bravo", hillCategory: .munroTop, height: 1),
                                ]
                                sut.fetch(
                                    data,
                                    sortType: .name(.descending),
                                    hillCategory: .munroTop,
                                    maxHeight: 99
                                ) { result in
                                    switch result {
                                    case let .success(result): actual = result
                                    default: break
                                    }
                                }
                            }
                            
                            it("should return expected list of Munros") {
                                expect(actual) == expected
                            }
                        }
                        
                        context("Filter: min max specified") {
                            beforeEach {
                                expected = [
                                    .make(name: "Golf", hillCategory: .munroTop, height: 34),
                                ]
                                sut.fetch(
                                    data,
                                    sortType: .name(.descending),
                                    hillCategory: .munroTop,
                                    minHeight: 20,
                                    maxHeight: 99
                                ) { result in
                                    switch result {
                                    case let .success(result): actual = result
                                    default: break
                                    }
                                }
                            }
                            
                            it("should return expected list of Munros") {
                                expect(actual) == expected
                            }
                        }
                    }
                    
                    context("Sort: height ascending") {
                        beforeEach {
                            expected = [
                                .make(name: "Bravo", hillCategory: .munroTop, height: 1),
                                .make(name: "Golf", hillCategory: .munroTop, height: 34),
                                .make(name: "Foxtrot", hillCategory: .munroTop, height: 250),
                                .make(name: "Juliet", hillCategory: .munroTop, height: 375),
                                .make(name: "Delta", hillCategory: .munroTop, height: 1000),
                            ]
                            sut.fetch(
                                data,
                                sortType: .height(.ascending),
                                hillCategory: .munroTop
                            ) { result in
                                switch result {
                                case let .success(result): actual = result
                                default: break
                                }
                            }
                        }
                        
                        it("should return expected list of Munros") {
                            expect(actual) == expected
                        }
                        
                        context("Filter: min specified") {
                            beforeEach {
                                expected = [
                                    .make(name: "Foxtrot", hillCategory: .munroTop, height: 250),
                                    .make(name: "Juliet", hillCategory: .munroTop, height: 375),
                                    .make(name: "Delta", hillCategory: .munroTop, height: 1000),
                                ]
                                sut.fetch(
                                    data,
                                    sortType: .height(.ascending),
                                    hillCategory: .munroTop,
                                    minHeight: 80
                                ) { result in
                                    switch result {
                                    case let .success(result): actual = result
                                    default: break
                                    }
                                }
                            }
                            
                            it("should return expected list of Munros") {
                                expect(actual) == expected
                            }
                        }
                        
                        context("Filter: max specified") {
                            beforeEach {
                                expected = [
                                    .make(name: "Bravo", hillCategory: .munroTop, height: 1),
                                    .make(name: "Golf", hillCategory: .munroTop, height: 34),
                                ]
                                sut.fetch(
                                    data,
                                    sortType: .height(.ascending),
                                    hillCategory: .munroTop,
                                    maxHeight: 99
                                ) { result in
                                    switch result {
                                    case let .success(result): actual = result
                                    default: break
                                    }
                                }
                            }
                            
                            it("should return expected list of Munros") {
                                expect(actual) == expected
                            }
                        }
                        
                        context("Filter: min max specified") {
                            beforeEach {
                                expected = [
                                    .make(name: "Golf", hillCategory: .munroTop, height: 34),
                                ]
                                sut.fetch(
                                    data,
                                    sortType: .height(.ascending),
                                    hillCategory: .munroTop,
                                    minHeight: 20,
                                    maxHeight: 99
                                ) { result in
                                    switch result {
                                    case let .success(result): actual = result
                                    default: break
                                    }
                                }
                            }
                            
                            it("should return expected list of Munros") {
                                expect(actual) == expected
                            }
                        }
                    }
                    
                    context("Sort: height descending") {
                        beforeEach {
                            expected = [
                                .make(name: "Delta", hillCategory: .munroTop, height: 1000),
                                .make(name: "Juliet", hillCategory: .munroTop, height: 375),
                                .make(name: "Foxtrot", hillCategory: .munroTop, height: 250),
                                .make(name: "Golf", hillCategory: .munroTop, height: 34),
                                .make(name: "Bravo", hillCategory: .munroTop, height: 1),
                            ]
                            sut.fetch(
                                data,
                                sortType: .height(.descending),
                                hillCategory: .munroTop
                            ) { result in
                                switch result {
                                case let .success(result): actual = result
                                default: break
                                }
                            }
                        }
                        
                        it("should return expected list of Munros") {
                            expect(actual) == expected
                        }
                        
                        context("Filter: min specified") {
                            beforeEach {
                                expected = [
                                    .make(name: "Delta", hillCategory: .munroTop, height: 1000),
                                    .make(name: "Juliet", hillCategory: .munroTop, height: 375),
                                    .make(name: "Foxtrot", hillCategory: .munroTop, height: 250),
                                ]
                                sut.fetch(
                                    data,
                                    sortType: .height(.descending),
                                    hillCategory: .munroTop,
                                    minHeight: 80
                                ) { result in
                                    switch result {
                                    case let .success(result): actual = result
                                    default: break
                                    }
                                }
                            }
                            
                            it("should return expected list of Munros") {
                                expect(actual) == expected
                            }
                        }
                        
                        context("Filter: max specified") {
                            beforeEach {
                                expected = [
                                    .make(name: "Golf", hillCategory: .munroTop, height: 34),
                                    .make(name: "Bravo", hillCategory: .munroTop, height: 1),
                                ]
                                sut.fetch(
                                    data,
                                    sortType: .height(.descending),
                                    hillCategory: .munroTop,
                                    maxHeight: 99
                                ) { result in
                                    switch result {
                                    case let .success(result): actual = result
                                    default: break
                                    }
                                }
                            }
                            
                            it("should return expected list of Munros") {
                                expect(actual) == expected
                            }
                        }
                        
                        context("Filter: min max specified") {
                            beforeEach {
                                expected = [
                                    .make(name: "Golf", hillCategory: .munroTop, height: 34),
                                ]
                                sut.fetch(
                                    data,
                                    sortType: .height(.descending),
                                    hillCategory: .munroTop,
                                    minHeight: 20,
                                    maxHeight: 99
                                ) { result in
                                    switch result {
                                    case let .success(result): actual = result
                                    default: break
                                    }
                                }
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
