//
//  AuthenticationMiddleware.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 10/22/24.
//

import OpenAPIRuntime
import Foundation
import HTTPTypes

struct AuthenticationMiddleware: ClientMiddleware {
    let apiKey: String
    
    func intercept(
        _ request: HTTPRequest,
        body: HTTPBody?,
        baseURL: URL,
        operationID _: String,
        next: (HTTPRequest, HTTPBody?, URL) async throws -> (HTTPResponse, HTTPBody?)
    ) async throws -> (HTTPResponse, HTTPBody?) {
        var request = request
        
        request.headerFields[.authorization] = "\(apiKey)"
        
        return try await next(request, body, baseURL)
    }
}
