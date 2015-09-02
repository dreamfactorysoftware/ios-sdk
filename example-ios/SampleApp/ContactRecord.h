#ifndef example_ios_ContactRecord_h
#define example_ios_ContactRecord_h

// contact model
@interface ContactRecord : NSObject

@property(nonatomic, retain) NSNumber* Id;
@property(nonatomic, retain) NSString* FirstName;
@property(nonatomic, retain) NSString* LastName;
@property(nonatomic, retain) NSString* Notes;
@property(nonatomic, retain) NSString* Skype;
@property(nonatomic, retain) NSString* Twitter;
@property(nonatomic, retain) NSString* ImageUrl;

@end
#endif
