#ifndef example_ios_ContactDetailRecord_h
#define example_ios_ContactDetailRecord_h

#import <Foundation/Foundation.h>

// contact info model
@interface ContactDetailRecord : NSObject

@property(nonatomic, retain) NSNumber* Id;

@property(nonatomic, retain) NSString* Type;

@property(nonatomic, retain) NSString* Phone;
@property(nonatomic, retain) NSString* Email;

@property(nonatomic, retain) NSString* State;
@property(nonatomic, retain) NSString* Zipcode;
@property(nonatomic, retain) NSString* Country;
@property(nonatomic, retain) NSString* City;
@property(nonatomic, retain) NSString* Address;

@property(nonatomic, retain) NSNumber* ContactId;

@end
#endif
