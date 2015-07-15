#import <Foundation/Foundation.h>

/*
 *  Use this object when building a request with a file. Pass it
 *  in as the body of the request to ensure that the file is built
 *  and sent up properly, especially with images.
 */
@interface NIKFile : NSObject {
    
@private
    NSString* name;
    NSString* mimeType;
    NSData* data;
}

@property(nonatomic, readonly) NSString* name;
@property(nonatomic, readonly) NSString* mimeType;
@property(nonatomic, readonly) NSData* data;

- (id) initWithNameData: (NSString*) filename
               mimeType: (NSString*) mimeType
                   data: (NSData*) data;
    
@end