//
//  API+Alamofire.swift
//  LTXiOSUtils
//
//  Created by CoderStar on 2022/3/24.
//

import Alamofire
import Foundation

// MARK: - 别名

/// Method
public typealias APIRequestMethod = HTTPMethod
/// Header
public typealias APIRequestHeaders = HTTPHeaders
/// APIDataResponse
public typealias APIDataResponse = AFDataResponse
/// APIDownloadResponse
public typealias APIDownloadResponse = AFDownloadResponse
/// APIRequestAdapter
public typealias APIRequestAdapter = RequestAdapter
/// APIDownloadDestination
public typealias APIDownloadDestination = DownloadRequest.Destination

public typealias APIUploadDestination = UploadRequest

/// APIMultipartFormData
public typealias APIMultipartFormData = MultipartFormData
/// APIParameterEncoding
public typealias APIParameterEncoding = ParameterEncoding
/// APIJSONEncoding
public typealias APIJSONEncoding = JSONEncoding
/// APIURLEncoding
public typealias APIURLEncoding = URLEncoding
/// APINetworkReachabilityManager
public typealias APINetworkReachabilityManager = NetworkReachabilityManager

extension Request: APIRequestTask {}

// MARK: - AlamofireAPIClient

struct AlamofireAPIClient: APIClient {
   
    let sessionManager: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 20
        let sessionManager = Session(configuration: configuration, startRequestsImmediately: false)
        return sessionManager
    }()

    func createDataRequest(
        request: URLRequest,
        progressHandler: APIProgressHandler?,
        completionHandler: @escaping APIDataResponseCompletionHandler
    ) -> APIRequestTask {
        let request = sessionManager.request(request).validate().responseData { response in
            completionHandler(response)
        }
        if let tempProgressHandler = progressHandler {
            request.downloadProgress(closure: tempProgressHandler)
        }
        return request
    }

    func createDownloadRequest(
        request: URLRequest,
        to: @escaping APIDownloadDestination,
        progressHandler: APIProgressHandler?,
        completionHandler: @escaping APIDownloadResponseCompletionHandler
    ) -> APIRequestTask {
        let request = sessionManager.download(request, to: to).validate().responseData { response in
            completionHandler(response)
        }
        if let tempProgressHandler = progressHandler {
            request.downloadProgress(closure: tempProgressHandler)
        }
        return request
    }
    
    func createUpFileRequest(
        request: URLRequest,
        fileDatas: [Data],
        progressHandler: APIProgressHandler?,
        completionHandler: @escaping APIDataResponseCompletionHandler
    ) -> APIRequestTask {
        let multipartFormData = MultipartFormData()
        fileDatas.forEach {
            multipartFormData.append($0, withName: "file", fileName:"file.png", mimeType: "image/png")
        }
        let request = sessionManager.upload(multipartFormData: multipartFormData, with: request).validate().responseData { response in
            completionHandler(response)
        }

        if let tempProgressHandler = progressHandler {
            request.uploadProgress(closure: tempProgressHandler)
        }
        return request
    }
}
