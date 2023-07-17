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
    
    /// Makes network calls to the backend server
    /// - Parameters:
    ///   - returnType: A `Codable` response type expected to be returned from the server
    ///   - path: The endpoint to make the request to
    ///   - method: The `HTTPMethod` for the request. Defaults to `GET`
    ///   - params: `[String:Any]` dictionary of parameters for the request
    ///   - completion: A `ResultAction` completion handler to process the request response
    func makeRequest<T: Codable>(
        returnType: T.Type,
        path: RemotePath,
        method: HTTPMethod = .get,
        params: Parameters? = nil,
        completion: ResultAction<T>?
    ) {
        _print("Request URL: \(path.requestURL)", .success)
        _print("Request Parameters:\n \(String(describing: params))", .success)
        
        AF.request(
            path.requestURL,
            method: method,
            parameters: params
        )
        .validate()
        .responseDecodable(of: returnType) { response in
            switch response.result {
            case let .success(model):
                _print(model.prettyJson, isJson: true)
                completion?(.success(model))
            case let .failure(error):
                completion?(.failure(.custom(error.localizedDescription)))
            }
        }
    }
}
