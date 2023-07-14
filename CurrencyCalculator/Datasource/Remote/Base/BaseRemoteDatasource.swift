//
//  BaseRemoteDatasource.swift
//  CurrencyCalculator
//
//  Created by Isaac Iniongun on 14/07/2023.
//

import Foundation
import Alamofire
import SwiftyJSON

class BaseRemoteDatasource {
    func makeRequest<T: Codable>(
        returnType: T.Type,
        path: RemotePath,
        method: HTTPMethod = .get,
        params: Parameters? = nil,
        completion: ResultAction<T>?
    ) {
        _print("Request URL: \(path.requestURL)", .success)
        _print("Request Parameters:\n \(String(describing: params))", .success)
        
        AF.request(path.requestURL, method: method, parameters: params).validate().responseDecodable(of: returnType) { response in
            switch response.result {
            case let .success(model):
                completion?(.success(model))
            case let .failure(error):
                completion?(.failure(.custom(error.localizedDescription)))
            }
        }
    }
}
