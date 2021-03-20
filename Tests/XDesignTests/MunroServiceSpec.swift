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
                context("default params") {
                    beforeEach {
                        expected = [
                            .init(name: "Alpha", hillCategory: .munro, height: 100),
                            .init(name: "Bravo", hillCategory: .munroTop, height: 1),
                            .init(name: "Charlie", hillCategory: .munro, height: 75),
                            .init(name: "Delta", hillCategory: .munroTop, height: 1000),
                            .init(name: "Echo", hillCategory: .munro, height: 10),
                            .init(name: "Foxtrot", hillCategory: .munroTop, height: 250),
                            .init(name: "Golf", hillCategory: .munroTop, height: 34),
                            .init(name: "Hotel", hillCategory: .munro, height: 500),
                            .init(name: "India", hillCategory: .munro, height: 99),
                            .init(name: "Juliet", hillCategory: .munroTop, height: 375),
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
                }
                
                context("invalid params") {
                    context("when max height is less than the minimum height") {
                        var actual: Error!
                        let expected = "minHeight cannot be greater than or equal to maxHeight"
                        
                        beforeEach {
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
                        var actual: Error!
                        let expected = "minHeight cannot be greater than or equal to maxHeight"
                        
                        beforeEach {
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
                }
                
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
                                    .init(name: "Alpha", hillCategory: .munro, height: 100),
                                    .init(name: "Hotel", hillCategory: .munro, height: 500),
                                    .init(name: "India", hillCategory: .munro, height: 99),
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
                                    .init(name: "Charlie", hillCategory: .munro, height: 75),
                                    .init(name: "Echo", hillCategory: .munro, height: 10),
                                    .init(name: "India", hillCategory: .munro, height: 99),
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
                                    .init(name: "Charlie", hillCategory: .munro, height: 75),
                                    .init(name: "India", hillCategory: .munro, height: 99),
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
                                .init(name: "India", hillCategory: .munro, height: 99),
                                .init(name: "Hotel", hillCategory: .munro, height: 500),
                                .init(name: "Echo", hillCategory: .munro, height: 10),
                                .init(name: "Charlie", hillCategory: .munro, height: 75),
                                .init(name: "Alpha", hillCategory: .munro, height: 100),
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
                                    .init(name: "India", hillCategory: .munro, height: 99),
                                    .init(name: "Hotel", hillCategory: .munro, height: 500),
                                    .init(name: "Alpha", hillCategory: .munro, height: 100),
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
                                    .init(name: "India", hillCategory: .munro, height: 99),
                                    .init(name: "Echo", hillCategory: .munro, height: 10),
                                    .init(name: "Charlie", hillCategory: .munro, height: 75),
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
                                    .init(name: "India", hillCategory: .munro, height: 99),
                                    .init(name: "Charlie", hillCategory: .munro, height: 75),
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
                                .init(name: "Echo", hillCategory: .munro, height: 10),
                                .init(name: "Charlie", hillCategory: .munro, height: 75),
                                .init(name: "India", hillCategory: .munro, height: 99),
                                .init(name: "Alpha", hillCategory: .munro, height: 100),
                                .init(name: "Hotel", hillCategory: .munro, height: 500),
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
                                    .init(name: "Charlie", hillCategory: .munro, height: 75),
                                    .init(name: "India", hillCategory: .munro, height: 99),
                                    .init(name: "Alpha", hillCategory: .munro, height: 100),
                                    .init(name: "Hotel", hillCategory: .munro, height: 500),
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
                                    .init(name: "Echo", hillCategory: .munro, height: 10),
                                    .init(name: "Charlie", hillCategory: .munro, height: 75),
                                    .init(name: "India", hillCategory: .munro, height: 99),
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
                                    .init(name: "Charlie", hillCategory: .munro, height: 75),
                                    .init(name: "India", hillCategory: .munro, height: 99),
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
                                .init(name: "Hotel", hillCategory: .munro, height: 500),
                                .init(name: "Alpha", hillCategory: .munro, height: 100),
                                .init(name: "India", hillCategory: .munro, height: 99),
                                .init(name: "Charlie", hillCategory: .munro, height: 75),
                                .init(name: "Echo", hillCategory: .munro, height: 10),
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
                                    .init(name: "Hotel", hillCategory: .munro, height: 500),
                                    .init(name: "Alpha", hillCategory: .munro, height: 100),
                                    .init(name: "India", hillCategory: .munro, height: 99),
                                    .init(name: "Charlie", hillCategory: .munro, height: 75),
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
                                    .init(name: "India", hillCategory: .munro, height: 99),
                                    .init(name: "Charlie", hillCategory: .munro, height: 75),
                                    .init(name: "Echo", hillCategory: .munro, height: 10),
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
                                    .init(name: "India", hillCategory: .munro, height: 99),
                                    .init(name: "Charlie", hillCategory: .munro, height: 75),
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
                                .init(name: "Bravo", hillCategory: .munroTop, height: 1),
                                .init(name: "Delta", hillCategory: .munroTop, height: 1000),
                                .init(name: "Foxtrot", hillCategory: .munroTop, height: 250),
                                .init(name: "Golf", hillCategory: .munroTop, height: 34),
                                .init(name: "Juliet", hillCategory: .munroTop, height: 375),
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
                                    .init(name: "Delta", hillCategory: .munroTop, height: 1000),
                                    .init(name: "Foxtrot", hillCategory: .munroTop, height: 250),
                                    .init(name: "Juliet", hillCategory: .munroTop, height: 375),
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
                                    .init(name: "Bravo", hillCategory: .munroTop, height: 1),
                                    .init(name: "Golf", hillCategory: .munroTop, height: 34),
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
                                    .init(name: "Golf", hillCategory: .munroTop, height: 34),
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
                                .init(name: "Juliet", hillCategory: .munroTop, height: 375),
                                .init(name: "Golf", hillCategory: .munroTop, height: 34),
                                .init(name: "Foxtrot", hillCategory: .munroTop, height: 250),
                                .init(name: "Delta", hillCategory: .munroTop, height: 1000),
                                .init(name: "Bravo", hillCategory: .munroTop, height: 1),
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
                                    .init(name: "Juliet", hillCategory: .munroTop, height: 375),
                                    .init(name: "Foxtrot", hillCategory: .munroTop, height: 250),
                                    .init(name: "Delta", hillCategory: .munroTop, height: 1000),
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
                                    .init(name: "Golf", hillCategory: .munroTop, height: 34),
                                    .init(name: "Bravo", hillCategory: .munroTop, height: 1),
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
                                    .init(name: "Golf", hillCategory: .munroTop, height: 34),
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
                                .init(name: "Bravo", hillCategory: .munroTop, height: 1),
                                .init(name: "Golf", hillCategory: .munroTop, height: 34),
                                .init(name: "Foxtrot", hillCategory: .munroTop, height: 250),
                                .init(name: "Juliet", hillCategory: .munroTop, height: 375),
                                .init(name: "Delta", hillCategory: .munroTop, height: 1000),
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
                                    .init(name: "Foxtrot", hillCategory: .munroTop, height: 250),
                                    .init(name: "Juliet", hillCategory: .munroTop, height: 375),
                                    .init(name: "Delta", hillCategory: .munroTop, height: 1000),
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
                                    .init(name: "Bravo", hillCategory: .munroTop, height: 1),
                                    .init(name: "Golf", hillCategory: .munroTop, height: 34),
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
                                    .init(name: "Golf", hillCategory: .munroTop, height: 34),
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
                                .init(name: "Delta", hillCategory: .munroTop, height: 1000),
                                .init(name: "Juliet", hillCategory: .munroTop, height: 375),
                                .init(name: "Foxtrot", hillCategory: .munroTop, height: 250),
                                .init(name: "Golf", hillCategory: .munroTop, height: 34),
                                .init(name: "Bravo", hillCategory: .munroTop, height: 1),
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
                                    .init(name: "Delta", hillCategory: .munroTop, height: 1000),
                                    .init(name: "Juliet", hillCategory: .munroTop, height: 375),
                                    .init(name: "Foxtrot", hillCategory: .munroTop, height: 250),
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
                                    .init(name: "Golf", hillCategory: .munroTop, height: 34),
                                    .init(name: "Bravo", hillCategory: .munroTop, height: 1),
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
                                    .init(name: "Golf", hillCategory: .munroTop, height: 34),
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
