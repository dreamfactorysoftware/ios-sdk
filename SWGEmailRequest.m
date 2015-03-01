#import "NIKDate.h"
#import "SWGEmailRequest.h"

@implementation SWGEmailRequest

-(id)template: (NSString*) template
    template_id: (NSNumber*) template_id
    to: (NSArray*) to
    cc: (NSArray*) cc
    bcc: (NSArray*) bcc
    subject: (NSString*) subject
    body_text: (NSString*) body_text
    body_html: (NSString*) body_html
    from_name: (NSString*) from_name
    from_email: (NSString*) from_email
    reply_to_name: (NSString*) reply_to_name
    reply_to_email: (NSString*) reply_to_email
{
  _template = template;
  _template_id = template_id;
  _to = to;
  _cc = cc;
  _bcc = bcc;
  _subject = subject;
  _body_text = body_text;
  _body_html = body_html;
  _from_name = from_name;
  _from_email = from_email;
  _reply_to_name = reply_to_name;
  _reply_to_email = reply_to_email;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        _template = dict[@"template"]; 
        _template_id = dict[@"template_id"]; 
        id to_dict = dict[@"to"];
        if([to_dict isKindOfClass:[NSArray class]]) {

            NSMutableArray * objs = [[NSMutableArray alloc] initWithCapacity:[(NSArray*)to_dict count]];

            if([(NSArray*)to_dict count] > 0) {
                for (NSDictionary* dict in (NSArray*)to_dict) {
                    SWGEmailAddress* d = [[SWGEmailAddress alloc] initWithValues:dict];
                    [objs addObject:d];
                }
                
                _to = [[NSArray alloc] initWithArray:objs];
            }
            else {
                _to = [[NSArray alloc] init];
            }
        }
        else {
            _to = [[NSArray alloc] init];
        }
        id cc_dict = dict[@"cc"];
        if([cc_dict isKindOfClass:[NSArray class]]) {

            NSMutableArray * objs = [[NSMutableArray alloc] initWithCapacity:[(NSArray*)cc_dict count]];

            if([(NSArray*)cc_dict count] > 0) {
                for (NSDictionary* dict in (NSArray*)cc_dict) {
                    SWGEmailAddress* d = [[SWGEmailAddress alloc] initWithValues:dict];
                    [objs addObject:d];
                }
                
                _cc = [[NSArray alloc] initWithArray:objs];
            }
            else {
                _cc = [[NSArray alloc] init];
            }
        }
        else {
            _cc = [[NSArray alloc] init];
        }
        id bcc_dict = dict[@"bcc"];
        if([bcc_dict isKindOfClass:[NSArray class]]) {

            NSMutableArray * objs = [[NSMutableArray alloc] initWithCapacity:[(NSArray*)bcc_dict count]];

            if([(NSArray*)bcc_dict count] > 0) {
                for (NSDictionary* dict in (NSArray*)bcc_dict) {
                    SWGEmailAddress* d = [[SWGEmailAddress alloc] initWithValues:dict];
                    [objs addObject:d];
                }
                
                _bcc = [[NSArray alloc] initWithArray:objs];
            }
            else {
                _bcc = [[NSArray alloc] init];
            }
        }
        else {
            _bcc = [[NSArray alloc] init];
        }
        _subject = dict[@"subject"]; 
        _body_text = dict[@"body_text"]; 
        _body_html = dict[@"body_html"]; 
        _from_name = dict[@"from_name"]; 
        _from_email = dict[@"from_email"]; 
        _reply_to_name = dict[@"reply_to_name"]; 
        _reply_to_email = dict[@"reply_to_email"]; 
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_template != nil) dict[@"template"] = _template ;
    if(_template_id != nil) dict[@"template_id"] = _template_id ;
    if(_to != nil){
        if([_to isKindOfClass:[NSArray class]]){
            NSMutableArray * array = [[NSMutableArray alloc] init];
            for( SWGEmailAddress *to in (NSArray*)_to) {
                [array addObject:[(NIKSwaggerObject*)to asDictionary]];
            }
            dict[@"to"] = array;
        }
        else if(_to && [_to isKindOfClass:[NIKDate class]]) {
            NSString * dateString = [(NIKDate*)_to toString];
            if(dateString){
                dict[@"to"] = dateString;
            }
        }
    }
    else {
    if(_to != nil) dict[@"to"] = [(NIKSwaggerObject*)_to asDictionary];
    }
    if(_cc != nil){
        if([_cc isKindOfClass:[NSArray class]]){
            NSMutableArray * array = [[NSMutableArray alloc] init];
            for( SWGEmailAddress *cc in (NSArray*)_cc) {
                [array addObject:[(NIKSwaggerObject*)cc asDictionary]];
            }
            dict[@"cc"] = array;
        }
        else if(_cc && [_cc isKindOfClass:[NIKDate class]]) {
            NSString * dateString = [(NIKDate*)_cc toString];
            if(dateString){
                dict[@"cc"] = dateString;
            }
        }
    }
    else {
    if(_cc != nil) dict[@"cc"] = [(NIKSwaggerObject*)_cc asDictionary];
    }
    if(_bcc != nil){
        if([_bcc isKindOfClass:[NSArray class]]){
            NSMutableArray * array = [[NSMutableArray alloc] init];
            for( SWGEmailAddress *bcc in (NSArray*)_bcc) {
                [array addObject:[(NIKSwaggerObject*)bcc asDictionary]];
            }
            dict[@"bcc"] = array;
        }
        else if(_bcc && [_bcc isKindOfClass:[NIKDate class]]) {
            NSString * dateString = [(NIKDate*)_bcc toString];
            if(dateString){
                dict[@"bcc"] = dateString;
            }
        }
    }
    else {
    if(_bcc != nil) dict[@"bcc"] = [(NIKSwaggerObject*)_bcc asDictionary];
    }
    if(_subject != nil) dict[@"subject"] = _subject ;
    if(_body_text != nil) dict[@"body_text"] = _body_text ;
    if(_body_html != nil) dict[@"body_html"] = _body_html ;
    if(_from_name != nil) dict[@"from_name"] = _from_name ;
    if(_from_email != nil) dict[@"from_email"] = _from_email ;
    if(_reply_to_name != nil) dict[@"reply_to_name"] = _reply_to_name ;
    if(_reply_to_email != nil) dict[@"reply_to_email"] = _reply_to_email ;
    NSDictionary* output = [dict copy];
    return output;
}

@end

