//
//  SurfMate_iOSTests.swift
//  SurfMate_iOSTests
//
//  Created by Jun on 2022/11/30.
//

import XCTest
import Moya
@testable import SurfMate_iOS

final class SignUpAPITest: XCTestCase {
    
    let signUpAPI = MoyaProvider<SignUpAPI>()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testNoNickName() throws {
       
        let promise = expectation(description: "Status code: 200")
        
        signUpAPI.request(.checkNickname(name: "머식")) { result in
            switch result {
            case .success(let response):
                
                let decoder = JSONDecoder()
                
                if let result = try? decoder.decode(DataResponse.self, from: response.data) {
                    print(result)
                    promise.fulfill()
                } else {
                    XCTFail("JSON 에러")
                }
                
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
                return
            }
        }
        
        wait(for: [promise], timeout: 5)
        
    }
    
    func testDuplicatedNickName() throws {
       
        let promise = expectation(description: "Status code: 200")
        
        signUpAPI.request(.checkNickname(name: "testUser")) { result in
            switch result {
            case .success(let response):
                
                let decoder = JSONDecoder()
                
                if let str = String(data: response.data, encoding: .utf8) {
                    print(str)
                }
                
                if let result = try? decoder.decode(DataResponse.self, from: response.data) {
                    print(result)
                    promise.fulfill()
                } else {
                    XCTFail("JSON 에러")
                }
                
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
                return
            }
        }
        
        wait(for: [promise], timeout: 5)
        
    }
    
    func testNoPhNum() throws {
       
        let promise = expectation(description: "Status code: 200")
        
        signUpAPI.request(.checkAcount(num: "01082836380")) { result in
            switch result {
            case .success(let response):
                
                let decoder = JSONDecoder()
                
                if let result = try? decoder.decode(DataResponse.self, from: response.data) {
                    print(result)
                    promise.fulfill()
                } else {
                    XCTFail("JSON 에러")
                }
                
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
                return
            }
        }
        
        wait(for: [promise], timeout: 5)
        
    }
    
    func testDuplicatedPhoneNum() throws {
        
        let promise = expectation(description: "Status code: 200")
        
        signUpAPI.request(.checkAcount(num: "01027570146")) { result in
            switch result {
            case .success(let response):
                
                let decoder = JSONDecoder()
                
                if let result = try? decoder.decode(DataResponse.self, from: response.data) {
                    print(result)
                    promise.fulfill()
                } else {
                    XCTFail("JSON 에러")
                }
                
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
                return
            }
        }
        
        wait(for: [promise], timeout: 5)
        
    }
    
    
    
    
}
