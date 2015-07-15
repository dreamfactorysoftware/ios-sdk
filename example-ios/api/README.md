##DreamFactory iOS API

The DreamFactory iOS API is a super light wrapper on NSUrl HTTP requests. All of the request formating is exposed in case you want to roll your own code or use a third-party library to send requests.

The general form of a DreamFactory REST API call is: 

`<rest-verb> http[s]://<server-name>/rest/[<service-api-name>]/[<resource-path>][?<param-name>=<param-value>]`

The iOS API format is: 

```Objective-C
  NIKApiInvoker restPath: (NSString*) path
                  method: (NSString*) method
             queryParams: (NSDictionary*) queryParams
                    body: (id) body
            headerParams: (NSDictionary*) headerParams
             contentType: (NSString*) contentType
         completionBlock: (void (^)(NSDictionary*, NSError *))completionBlock;
```

Breaking down each parameter:
  - **path** Holds the value of `http[s]://<server-name>/rest/[<service-api-name>]/[<resource-path>]` from the generic call. You can include the query parameters here. However, it is easier and cleaner to pass in the query parameters as a dictionary than it is to format them into the url. 
  - **method** The REST verb.
  - **queryParams** Holds the query parameters.
  - **body** Request body, usually  a dictionary, array or NIKFile.
  - **headerParams** Users using 1.* need to include the session id and the application name.
  - **contentType** Either json or xml.
  - **completionBlock** Block to be run once the request is completed. 

####Additional Resources
Detailed instructions to setup and run the "Address Book" sample application as well as a list of API calls used by the "Address Book" sample application are located in the README [here](../SampleApp#example-api-calls-).

More detailed information on the DreamFactory REST API is available [here](https://github.com/dreamfactorysoftware/dsp-core/wiki/REST-API). 

The live API documentation included in the DreamFactory Admin Console is a great way to learn how the DreamFactory REST API works.
Check out how to use the live API docs [here](https://github.com/dreamfactorysoftware/dsp-core/wiki/API-Docs). You can view and test an example of the live API docs [here](https://dsp-sandman1.cloud.dreamfactory.com/swagger/).
