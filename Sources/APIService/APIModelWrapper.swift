//
//  APIModelWrapper.swift
//  TestDemo
//
//  Created by MacMini on 2022/7/22.
//

import Foundation

/// 网络请求结果最外层Model
public protocol APIModelWrapper: APIParsable {

    associatedtype DataType: Decodable

    var code: String { get }

    var message: String { get }

    var data: DataType? { get }
    
    func isOk() -> Bool
}

/// 默认的返回结果实现
public struct DefaultResponseModel<T>: APIModelWrapper, APIParsable where T: Decodable {
    
    public var code: String
    public var message: String
    public var data: T?
    
    public func isOk() -> Bool {
        return code == "0"
    }
}
