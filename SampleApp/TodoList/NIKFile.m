#import "NIKFile.h"

@implementation NIKFile

@synthesize name = _name;
@synthesize mimeType = _mimeType;
@synthesize data = _data;

- (id) init {
    self = [super init];
    return self;
}

- (id) initWithNameData: (NSString*) filename
               mimeType: (NSString*) fileMimeType
                   data: (NSData*) fdata {
	self = [super init];
	if(self) {
		_name = filename;
		_mimeType = fileMimeType;
		_data = fdata;
	}
	return self;
}

@end