//
//  NetworkServiceFactory.swift
//  MockingApp
//
//  Created by Christopher Hicks on 4/23/22.
//

import Foundation

class NetworkServiceFactory {
    
    static func create() -> NetworkService {
        let environment = ProcessInfo.processInfo.environment["ENV"]
        
        if let environment = environment {
            if environment == "TEST" {
                return MockWebSerivce()
            } else {
                return Webservice()
            }
        } else {
            return Webservice()
        }
    }
}
