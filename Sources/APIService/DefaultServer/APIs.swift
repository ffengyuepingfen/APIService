//
//  APIs.swift
//  APIService
//
//  Created by Laowang on 2023/11/23.
//

import Foundation

public struct DefaultConstants {
    
    private var baseUrl: URL
    
    private var header: [String: String]
    
    private var plugins: [APIPlugin] = []
    
    public init(baseUrl: URL, header: [String : String], plugins: [APIPlugin]? = nil) {
        self.baseUrl = baseUrl
        self.header = header
        if let plugins {
            self.plugins = plugins
        }
    }
    /// 创建 请求
    public func request<S>(path: String, param: [String: Any]? = nil, taskType: APIRequestTaskType = .request, dataType: S.Type) -> DefaultAPIRequest<DefaultResponseModel<S>> {
        DefaultAPIRequest(baseUrl: baseUrl, headers: header, path: path, param: param, taskType: taskType, dataType: dataType)
    }
}

extension DefaultConstants {
    
    public func sendRequest<T: APIRequest>(
        _ request: T,
//        plugins: [APIPlugin] = [],
        isShowMessage: Bool = false,
        encoding: APIParameterEncoding? = nil,
        progressHandler: APIProgressHandler? = nil
    ) async throws -> T.Response.DataType {
        
        try await withCheckedThrowingContinuation({ continuation in
            APIService.sendRequest(request, plugins: plugins) { reponse in
                var msg = "出现错误，请稍后重试"
                switch reponse.result {
                case let .success(res):
                    
                    if res.isOk() {
                        if let result = res.data {
                            continuation.resume(returning: result)
                        }else{
                            if let result = "result" as? T.Response.DataType {
                                continuation.resume(returning: result)
                            }else{
                                continuation.resume(throwing:  DefaultAPIError.customError(res.code, res.message))
                            }
                        }
                        msg = res.message
                    } else {
                        if res.message != "" {
                            msg = res.message
                        }
                        continuation.resume(throwing: DefaultAPIError.customError(res.code, msg))
                    }
                case let .failure(apiError):
                    continuation.resume(throwing: apiError)
                }
                if isShowMessage {
                    DefaultConstants.dealError(message: msg)
                }
            }
        })
    }
    
    static func dealError(message: String) {
        
        DispatchQueue.main.async {
            if let rootvc = k_keyWindow()?.rootViewController {
                rootvc.showToast(message: message)
            }
        }
    }
}
