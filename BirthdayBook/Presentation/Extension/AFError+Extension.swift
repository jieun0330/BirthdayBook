//
//  AFError+extension.swift
//  BirthdayBook
//
//  Created by 박지은 on 3/17/24.
//

import Foundation
import Alamofire

extension AFError {
    func handleError(_ error: AFError) {
        switch error {
            
        case .createUploadableFailed(error: let error):
            print("여기서부턴 어떻게 해야되죠~")
        case .createURLRequestFailed(error: let error):
            print("여기서부턴 어떻게 해야되죠~")
        case .downloadedFileMoveFailed(error: let error, source: let source, destination: let destination):
            print("여기서부턴 어떻게 해야되죠~")
        case .explicitlyCancelled:
            print("여기서부턴 어떻게 해야되죠~")
        case .invalidURL(url: let url):
            print("여기서부턴 어떻게 해야되죠~")
        case .multipartEncodingFailed(reason: let reason):
            print("여기서부턴 어떻게 해야되죠~")
        case .parameterEncodingFailed(reason: let reason):
            print("여기서부턴 어떻게 해야되죠~")
        case .parameterEncoderFailed(reason: let reason):
            print("여기서부턴 어떻게 해야되죠~")
        case .requestAdaptationFailed(error: let error):
            print("여기서부턴 어떻게 해야되죠~")
        case .requestRetryFailed(retryError: let retryError, originalError: let originalError):
            print("여기서부턴 어떻게 해야되죠~")
        case .responseValidationFailed(reason: let reason):
            print("여기서부턴 어떻게 해야되죠~")
        case .responseSerializationFailed(reason: let reason):
            print("여기서부턴 어떻게 해야되죠~")
        case .serverTrustEvaluationFailed(reason: let reason):
            print("여기서부턴 어떻게 해야되죠~")
        case .sessionDeinitialized:
            print("여기서부턴 어떻게 해야되죠~")
        case .sessionInvalidated(error: let error):
            print("여기서부턴 어떻게 해야되죠~")
        case .sessionTaskFailed(error: let error):
            print("여기서부턴 어떻게 해야되죠~")
        case .urlRequestValidationFailed(reason: let reason):
            print("여기서부턴 어떻게 해야되죠~")
        }
    }
}
