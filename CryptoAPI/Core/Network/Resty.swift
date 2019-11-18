//
//  Resty.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 11/16/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

import Foundation

/// The protocol used to define the specifications necessary for a `Restly`.
public protocol Resty {
    /// The host, conforming to RFC 1808.
    var host: String { get }

    /// The path, conforming to RFC 1808
    var path: String { get }

    /// The HTTP method used in the request.
    var method: HTTPMethod { get }

    /// The HTTP request parameters.
    var bodyParameters: [String: Any]? { get }
    
    var queryParameters: [String: String]? { get }

    /// A dictionary containing all the HTTP header fields
    var headers: [String: String]? { get }
}

/// HTTP Methods
public enum HTTPMethod: String {
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case connect = "CONNECT"
    case options = "OPTIONS"
    case trace = "TRACE"
    case patch = "PATCH"
}

/// Resty Errors
enum RestyError: Error {
    case badURL
    case emptyResponse
}

extension Resty {
    /// The URL of the receiver.
    fileprivate var url: String {
        return host + path + (queryParameters?.stringFromHttpParameters() ?? "")
    }

    func request<T: Codable>(type: T.Type, session: URLSession = .shared, completionHandler: @escaping (Result<T, CryptoApiError>) -> Void) {
        guard let url = URL(string: url) else {
            completionHandler(.failure(CryptoApiError.innerError(RestyError.badURL)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData

        if let parameters = bodyParameters {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                completionHandler(.failure(CryptoApiError.innerError(error)))
                return
            }
        }

        let dataTask = session.dataTask(with: request) { data, response, error -> Void in
            if let error = error {
                completionHandler(.failure(CryptoApiError.innerError(error)))
                return
            }
            if let httpResponse = response as? HTTPURLResponse, let data = data {
                if httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 {
                    do {
                          print("""
                              ------------
                              \(String(describing: String(data: data, encoding: .utf8)))
                              ----------
                              """)
                          completionHandler(.success(try JSONDecoder().decode(type, from: data)))
                      } catch let error {
                          print("""
                                ------------
                                \(error)
                                ----------
                                """)
                          completionHandler(.failure(CryptoApiError.innerError(error)))
                          return
                      }
                } else {
                    do {
                        print("""
                              ------------
                              \(String(describing: String(data: data, encoding: .utf8)))
                              ----------
                              """)
                        if let error = try? JSONDecoder().decode(CryptoApiTypedErrors.self, from: data) {
                            completionHandler(.failure(CryptoApiError.customErrorList(error)))
                        } else {
                            let error = try JSONDecoder().decode(CryptoApiTypedError.self, from: data)
                            completionHandler(.failure(CryptoApiError.customError(error)))
                        }
                      } catch let error {
                          print("""
                                ------------
                                \(error)
                                ----------
                                """)
                        completionHandler(.failure(CryptoApiError.innerError(error)))
                          return
                      }
                }
                print(httpResponse.statusCode)
            } else {
                completionHandler(.failure(CryptoApiError.innerError(RestyError.emptyResponse)))
            }
        }

        dataTask.resume()
    }
}
