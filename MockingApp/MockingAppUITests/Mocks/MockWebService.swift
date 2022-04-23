//
//  MockWebService.swift
//  MockingApp
//
//  Created by Christopher Hicks on 4/23/22.
//

import Foundation

class MockWebSerivce: NetworkService {
    func login(username: String, password: String, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        
        if username == "JohnDoe" && password == "Password" {
            completion(.success(()))
        } else {
            completion(.failure(.notAuthenticated))
        }
        
    }
    
    
}
