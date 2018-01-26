//
//  GoJekServiceManager.swift
//  GoJekContact
//
//  Created by muttavarapu on 25/01/18.
//  Copyright © 2018 Muttavarapu. All rights reserved.
//

import Foundation
enum NetworkError: Error {
    
    case generic
    case invalidURL
}

public class GoJekServiceManager {
    
    // Shared instance of GoJekServiceManager
    public static let shared: GoJekServiceManager = {
        return GoJekServiceManager()
    }()
    
    let session: URLSession!
    
    init() {
        
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)
        configuration.timeoutIntervalForRequest = 10.0
        
        session = URLSession(configuration: configuration)
    }

    
    public func fetchContactList(_ completion: @escaping (_ ids: Array<Any>?, _ error: Error?) -> Void) {
        sendRequest(path: ContactsURL, method: "GET", params: nil) { (data, response, error) in
            do {
                if  error == nil
                {
                    let json = try JSONSerialization.jsonObject(with: data!) as! Array<Any>
                    completion(json,error)
                }else{
                    completion(nil,error)
                }
            } catch let error as NSError {
                print("json error: \(error.localizedDescription)")
            }
        }
    }
    
    
    func sendRequest(path:URL?,method: String,params: [String: Any]?, completion: @escaping (Data?, URLResponse?, Error?) -> ())
    {
        
        guard let url = path else {
            completion(nil, nil, NetworkError.invalidURL)
            return
        }
        var nsURL = URLRequest(url:url)
        if method == "POST"
        {
            nsURL.httpMethod = "POST"
        }else if method == "GET" {
            nsURL.httpMethod = "GET"
        }
        else if method == "PUT" {
            nsURL.httpMethod = "PUT"
        }
        
        if method == "PUT" || method == "POST"
        {
            guard let parameters = params else {
                completion(nil, nil, NetworkError.invalidURL)
                return
            }
            if let postData = (try? JSONSerialization.data(withJSONObject: parameters, options: [])) {
                nsURL.httpBody = postData
            }
        }
        session.dataTask(with: nsURL) { data, response, error in
            DispatchQueue.main.async {
                completion(data, response, error)
            }
            }.resume()
    }
}

extension GoJekServiceManager {
    
    public var baseURL: URL {
        return URL(string: "http://gojek-contacts-app.herokuapp.com")!
    }
    public var ContactsURL: URL {
        return baseURL.appendingPathComponent("/contacts.json")
    }
    public func GetContactURL(id: String) -> URL {
        return baseURL.appendingPathComponent("/contacts/\(id).json")
    }
}