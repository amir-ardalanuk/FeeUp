# Network

### APIManagerProtocol
First Layer is `APIManagerProtocol` which use `RequestProtocol`and call an api to get the response as pure `Data`. this is private class in the `NetworkSession` module.

- APIManagerProtocol is a protocol that defines a contract for an API manager. It includes a perform method that takes a RequestProtocol and an optional authorization token. It performs the specified request and returns the response data. It throws an error if the request fails or the server response is invalid.
#### Steps: 
- APIManager is a concrete implementation of APIManagerProtocol for performing network requests. It uses a URLSession internally for making the network calls.

- The APIManager class has an initializer that allows you to provide a custom URLSession, but it also provides a default initializer that uses a shared URLSession instance.

The perform method in APIManager implements the perform method from APIManagerProtocol. It creates a URL request using the provided RequestProtocol and authorization token. It then uses the URLSession to perform the request asynchronously and retrieve the response data.

- The method checks the HTTP response status code to ensure it is 200 (indicating a successful response). If the response status code is not 200, it throws a NetworkError.invalidServerResponse error.

- The response data is returned if the request is successful.

 
Next Layer that use `APIManagerProtocol` is `RequestManager`. `RequestManager``get Data from `APIManagerProtocol`and decode to generic and requested model and this class from the `NetworkSession` is available for outside of the module. 
- It has an initializer that allows you to provide a custom APIManagerProtocol, but it also provides a default initializer that uses a default APIManager instance.
- The perform method in RequestManager implements the perform method from RequestManagerProtocol.
- It first calls the perform method of the apiManager to get the response data.
- It then uses the decoder specified in the request to decode the response data into the specified type T.
- If an error occurs during the request or decoding, it checks if the error is of type NetworkError.
- If it is an invalidServerResponse error, it tries to decode the data into a ServerError object and throws a NetworkError.ServerError error with the server error details.
- For other network errors or non-network errors, it rethrows the error.
- The response object of type T is returned if the request and decoding are successful.
This code represents a request manager that leverages an APIManager to perform network requests and uses the decoder specified in the request to decode the response data into the desired type. It handles different network errors and provides flexibility to handle server error responses as well.   

and an Important protocol: RequstProtocol. which is builder for our request url 
- RequestProtocol is a protocol that defines the contract for a request. It includes properties for host, path, headers, params, urlParams, addAuthorizationToken, requestType, and decoder.

- RequestType is an enumeration representing the HTTP request types (GET and POST). Dont worry about rest of them (PUT or DELETE easily can use them too).

## The extension for RequestProtocol provides default implementations for the protocol properties.

addAuthorizationToken defaults to false.
params defaults to an empty dictionary.
urlParams defaults to an empty dictionary.
headers defaults to an empty dictionary.
decoder defaults to the defaultDecoder set previously.

### Another extension for RequestProtocol provides a method called createURLRequest(authToken:) that creates a URLRequest based on the properties of the request.

It constructs the URL using the host, path, and urlParams.
The request method is set based on the requestType property.
The headers are set on the URL request.
If addAuthorizationToken is true, the provided authToken is set in the request's "Authorization" header.
The "Content-Type" header is set to "application/json".
If params is not empty, the request body is set with JSON data generated from the params dictionary.
These components provide a protocol and extensions for creating and configuring network request objects. The RequestProtocol defines the contract for a request, and the extensions provide default implementations for the properties and a method to create a URLRequest based on the request properties. The defaultDecoder variable allows you to specify the default decoder to use for decoding the response data.
