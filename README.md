# RestApiModuleSwift

### Description

This class-module is for use as API Rest for connect with API's, I did for the purpose to be easy of implement and easy to 
understand , and too for know more how to connect with servers and practice my swift knowledges.

### Usage


**Initiate the module**
 
If your API use headers you can put it on the init.

```sh
            let headers = ["Authorization": "my-auth-token",
                           "Content-Type":"application/json"]

            let apimodule =  ApiRequestModule(domain: "http://you-api-domain/",headers: headers)
        

```
**GET**

```sh
          
        apimodule.get("users"){
            response in
            print(response)
        
        };

```

**POST**

```sh
          
        let params = ["name": "test-put"];
        apimodule.post("users",params: params){
            response in
            print(response)
        
        };

```

**PUT**

```sh
          
        let params = ["name": "test-put"];
        apimodule.put("users/1",params: params){
            response in
            print(response)
        
        };

```

**DELETE**

```sh
          
        apimodule.delete("users/1"){
            response in
            print(response)
        
        };

```

### Nexts Steps

The nexts steps that I'll implement will be cache the responses using Core Data, that could be good if the user 
lost the conection or just they are in area that the internet isn't available, for load esential data from the last
Api Call




