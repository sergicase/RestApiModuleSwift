//
//  ApiRequest.swift
//  api-module
//
//  Copyright © 2016 Sergi Case Massana. All rights reserved.
//

import Foundation

class ApiRequestModule{
    
    var domain: String;
    var headers: [String:String];
    
    var url = NSURL();
    var request = NSMutableURLRequest();
    
    
    init (domain: String,headers: [String:String])
    {
        self.domain = domain
        self.headers = headers
    }
    
    func get(resource: String, completion: @escaping (_ response: String) -> ())
    {
        
        self.setUrl(resource: resource)
        self.initHeaders(headers: self.headers)
        
        request.httpMethod = "GET"
        trytask(){ response in completion(response)}
        
    }
    
    
    func post(resource: String,params: [String:AnyObject], completion: @escaping (_ response: String) -> ())
    {
        
        
        if(JSONSerialization.isValidJSONObject(params))
        {
            self.setUrl(resource: resource)
            self.initHeaders(headers: self.headers)
            
            request.httpMethod = "POST"
            do {
                let jsonTodo = try JSONSerialization.data(withJSONObject: params, options: [])
                request.httpBody = jsonTodo
                
            } catch {
                print("Error: Couldn't create the Json")
                return
            }
            trytask(){ response in completion(response)}
        } else {
            print("Invalid Json Object")
        }
        
    }
    
    func put(resource: String,params: [String:AnyObject], completion: @escaping (_ response: String) -> ())
    {
        
        if(JSONSerialization.isValidJSONObject(params))
        {
            self.setUrl(resource: resource)
            self.initHeaders(headers: self.headers)
            
            request.httpMethod = "PUT"
            do {
                let json = try JSONSerialization.data(withJSONObject: params, options: [])
                request.httpBody = json
                
            } catch {
                print("Error: Couldn't create the Json")
                return
            }
            trytask(){ response in completion(response)}
        } else {
            print("Invalid Json Object")
        }
        
    }
    
    func delete(resource: String, completion: @escaping (_ response: String) -> ())
    {
        self.setUrl(resource: resource)
        self.initHeaders(headers: self.headers)
        
        request.httpMethod = "DELETE"
        trytask(){ response in completion(response)}
        
        
    }
    
    func setHeaders(headers: [String:String])
    {
        self.headers = headers
        
    }
    
    
    private func setUrl(resource: String) -> Void
    {
        self.request = NSMutableURLRequest(url: NSURL(string: self.domain + resource)! as URL)
        
    }
    
    private func checkUrl(url: String) -> Bool
    {
        if (NSURL(string: url) != nil)
        {
            return true
            
        } else {
            return false
        }
        
    }
    
    private func trytask(completion:@escaping (_ response:String)->())    {
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if let data = data,
                let jsonString = String(data: data, encoding: String.Encoding.utf8), error == nil {
                jsonString
                completion(jsonString)
            } else {
                print("error=\(error!.localizedDescription)")
                
            }
        }
        task.resume()
    }
    
    private func initHeaders(headers: [String: String]){
        
        for header in headers {
            request.addValue(header.1, forHTTPHeaderField: header.0)
        }
    }
}
