//
//  RequestInfos.swift
//  alohomora
//
//  Created by Janine Leal on 16/07/26.
//

import Foundation

enum HTTPMethodType: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol RequestInfos {
    var baseURL: String { get }
    var endpoint: String { get }
    var parameters: [String : String]? { get }
    var body: [String :  String]? { get }
    var httpMethod: HTTPMethodType { get }
}

extension RequestInfos {
    var baseURL: String {
        "https://hp-api.onrender.com/api/"
    }

    var body: [String :  String]? {
        nil
    }

    var parameters: [String : String]? {
        nil
    }

    var httpMethod: HTTPMethodType {
        .get
    }
}
