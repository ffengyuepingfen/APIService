//
//  DefaultAPIRequest.swift
//  APIService
//
//  Created by Laowang on 2023/11/23.
//

import Foundation
///  驱动的默认实现
public struct DefaultAPIRequest<T: APIModelWrapper>: APIRequest {
    
    public var baseURL: URL
    
    public var path: String
    
    public var method: APIRequestMethod = .post
    
    public var parameters: [String: Any]?
    
    public var headers: APIRequestHeaders?
    
    public var taskType: APIRequestTaskType = .request
    
    public var encoding: APIParameterEncoding = APIJSONEncoding.default
    
    public typealias Response = T
}


// MARK: - 构造函数
extension DefaultAPIRequest {
    
    public init<S>(baseUrl: URL, headers: [String: String], path: String, param: [String: Any]? = nil, taskType: APIRequestTaskType = .request, dataType: S.Type) where DefaultResponseModel<S> == T {
        self.baseURL = baseUrl
        self.headers = APIRequestHeaders(headers)
        self.path = path
        self.parameters = param
        self.taskType = taskType
    }
}
