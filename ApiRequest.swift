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
    
    func get(resource: String, completion: (response: String) -> ())
    {

        self.setUrl(resource)
        self.initHeaders(self.headers)

        request.HTTPMethod = "GET"
        trytask(){ response in completion(response:response)}
        
    }
    
    
    func post(resource: String,params: [String:AnyObject], completion: (response: String) -> ())
    {
        
        
        if(NSJSONSerialization.isValidJSONObject(params))
        {
            self.setUrl(resource)
            self.initHeaders(self.headers)
            
            request.HTTPMethod = "POST"
            do {
                let jsonTodo = try NSJSONSerialization.dataWithJSONObject(params, options: [])
                request.HTTPBody = jsonTodo

            } catch {
                print("Error: Couldn't create the Json")
                return
            }
            trytask(){ response in completion(response:response)}
        } else {
            print("Invalid Json Object")
        }
        
    }
    
    func put(resource: String,params: [String:AnyObject], completion: (response: String) -> ())
    {
        
        if(NSJSONSerialization.isValidJSONObject(params))
        {
            self.setUrl(resource)
            self.initHeaders(self.headers)

            request.HTTPMethod = "PUT"
            do {
                let json = try NSJSONSerialization.dataWithJSONObject(params, options: [])
                request.HTTPBody = json
                
            } catch {
                print("Error: Couldn't create the Json")
                return
            }
            trytask(){ response in completion(response:response)}
        } else {
            print("Invalid Json Object")
        }
        
    }
    
    func delete(resource: String, completion: (response: String) -> ())
    {
            self.setUrl(resource)
            self.initHeaders(self.headers)

            request.HTTPMethod = "DELETE"
            trytask(){ response in completion(response:response)}
        
        
    }

    func setHeaders(headers: [String:String])
    {
        self.headers = headers

    }
    
    
    private func setUrl(resource: String) -> Void
    {
        self.request = NSMutableURLRequest(URL: NSURL(string: self.domain + resource)!)
        
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
    
    private func trytask(completion:(response:String)->())    {
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            if let data = data,
                jsonString = String(data: data, encoding: NSUTF8StringEncoding)
                where error == nil {
                jsonString
                completion(response: jsonString)
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