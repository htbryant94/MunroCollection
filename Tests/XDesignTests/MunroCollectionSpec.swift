import Nimble
import Quick
@testable import Shared

class MunroCollectionSpec: QuickSpec {
    override func spec() {
        describe("MunroCollection") {
            var sut: MunroCollection!
            
            context("get") {
                context("initialised with valid CSV file path") {
                    var actual: [Munro]!
                    
                    context("default query") {
                        beforeEach {
                            sut = MunroCollection()
                            sut.get { result in
                                switch result {
                                case let .success(munros): actual = munros
                                default: break
                                }
                            }
                        }
                        
                        it("should return correct list of results") {
                            expect(actual.count) == 509
                        }
                    }
                    
                    context("valid query") {
                        beforeEach {
                            sut = MunroCollection()
                            sut.get(
                                sortType: .height(.ascending),
                                hillCategory: .munroTop,
                                minHeight: 100,
                                maxHeight: 1000
                            ) { result in
                                switch result {
                                case let .success(munros): actual = munros
                                default: break
                                }
                            }
                        }
                        
                        it("should return correct list of results") {
                            expect(actual.count) == 144
                        }
                    }
                    
                    context("invalid query") {
                        beforeEach {
                            sut = MunroCollection()
                            sut.get { result in
                                switch result {
                                case let .success(munros): actual = munros
                                default: break
                                }
                            }
                        }
                    }
                }
                
                context("initialised with invalid CSV file path") {
                    var actual: Error!
                    var expected: String!

                    beforeEach {
                        sut = MunroCollection(filePath: "some/invalid/path")
                        sut.get { result in
                            switch result {
                            case let .failure(error): actual = error
                            default: break
                            }
                        }
                        expected = "The file “path” couldn’t be opened because there is no such file."
                    }

                    it("should return error") {
                        expect(actual.localizedDescription) == expected
                    }
                }
            }
        }
    }
}
