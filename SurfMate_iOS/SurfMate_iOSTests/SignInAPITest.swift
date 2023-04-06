//
//  SignInAPITest.swift
//  SurfMate_iOSTests
//
//  Created by Jun on 2023/04/06.
//

import XCTest
import Moya
@testable import SurfMate_iOS


class SignInAPITest: XCTestCase {

    let signInAPI = MoyaProvider<SignInAPI>()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testNoPhNum() throws {
       
        let promise = expectation(description: "Status code: 200")
        
        signInAPI.request(.checkAcount(num: "01082836380")) { result in
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
        
        signInAPI.request(.checkAcount(num: "01027570146")) { result in
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
    
    func testPasswordChange() throws {
        
        let promise = expectation(description: "Status code: 200")
        
        signInAPI.request(.passwordChange(phNum: "01027570146", newPassword: "asdfasdf12")) {
            result in
            
            switch result {
            case .success(let response):
                let decoder = JSONDecoder()
                
                if let result = try? decoder.decode(DataResponse.self, from: response.data) {
                    if result.message == "성공" {
                        promise.fulfill()
                    } else {
                        XCTFail(result.message)
                    }
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
