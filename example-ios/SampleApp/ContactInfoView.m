#import <Foundation/Foundation.h>

#import "ContactInfoView.h"

@interface ContactInfoView ()<UITextFieldDelegate>

@property (nonatomic, retain) NSMutableDictionary* textFields;
@property (nonatomic, strong) NSArray *contactTypes;

@end

@implementation ContactInfoView

- (id) initWithFrame:(CGRect) frame{
    self = [super initWithFrame:frame];
    
    self.contactTypes = @[@"work",@"home",@"mobile",@"other"];
    
    [self buildContactTextFields:@[@"Type", @"Phone", @"Email", @"Address", @"City", @"State", @"Zip", @"Country"] y:0];
    
    // resize
    CGRect contentRect = CGRectZero;
    for (UIView *view in self.subviews) {
        contentRect = CGRectUnion(contentRect, view.frame);
    }
    
    CGRect oldFrame = self.frame;
    oldFrame.size.height = contentRect.size.height;
    self.frame = oldFrame;
    
    return self;
}

- (void) PutFieldIn:(NSString*)value key:(NSString*)key {
    if([value length] > 0){
        ((UITextField*)[self.textFields objectForKey:key]).text = value;
    }
    else{
        ((UITextField*)[self.textFields objectForKey:key]).text = @"";
    }
}


- (void) updateFields {
    [self PutFieldIn:self.record.Type key:@"Type"];
    [self PutFieldIn:self.record.Phone key:@"Phone" ];
    [self PutFieldIn:self.record.Email key:@"Email" ];
    [self PutFieldIn:self.record.Address key:@"Address" ];
    [self PutFieldIn:self.record.City key:@"City" ];
    [self PutFieldIn:self.record.State key:@"State" ];
    [self PutFieldIn:self.record.Zipcode key:@"Zip" ];
    [self PutFieldIn:self.record.Country key:@"Country" ];
    
    [self reloadInputViews];
    [self setNeedsDisplay];
}

- (NSString*) getTextValue:(NSString*) key {
    return ((UITextField*)[self.textFields objectForKey:key]).text;
}

- (void) updateRecord {
    self.record.Type = [self getTextValue:@"Type" ];
    self.record.Phone = [self getTextValue:@"Phone" ];
    self.record.Email = [self getTextValue:@"Email" ];
    self.record.Address = [self getTextValue:@"Address" ];
    self.record.City = [self getTextValue:@"City" ];
    self.record.State = [self getTextValue:@"State" ];
    self.record.Zipcode = [self getTextValue:@"Zip" ];
    self.record.Country = [self getTextValue:@"Country" ];
}

- (NSDictionary*) buildToDictionary{
    NSDictionary* dict = @{@"id":self.record.Id,
                           @"contact_id":self.record.ContactId,
                           @"info_type":self.record.Type,
                           @"phone":self.record.Phone,
                           @"email":self.record.Email,
                           @"address":self.record.Address,
                           @"city":self.record.City,
                           @"state":self.record.State,
                           @"zip":self.record.Zipcode,
                           @"country":self.record.Country
                           };
    return dict;
}

- (void) buildContactTextFields:(NSArray*)names y:(int)y {
    y += 30;

    self.textFields = [[NSMutableDictionary alloc] init];
    
    for(NSString* field in names){
        UITextField* textfield = [[UITextField alloc] initWithFrame:CGRectMake(self.frame.size.width * 0.05, y, self.frame.size.width * .9, 35)];
        [textfield setPlaceholder:field];
        [textfield setFont:[UIFont fontWithName:@"Helvetica Neue" size: 20.0]];
        textfield.backgroundColor = [UIColor whiteColor];
        
        textfield.layer.cornerRadius = 5;
        textfield.delegate = self;
   
        [self addSubview:textfield];
        
        [self.textFields setObject:textfield forKey:field];
        
        y += 40;
        
        if([field isEqualToString:@"Type"]) {
            textfield.enabled = NO;
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.frame = textfield.frame;
            [button setTitle:@"" forState:UIControlStateNormal];
            button.backgroundColor = [UIColor clearColor];
            [button addTarget:self action:@selector(onContactTypeClick) forControlEvents:UIControlEventTouchDown];
            [self addSubview:button];
            textfield.text = self.contactTypes[0];
        }
    }
}

- (void)onContactTypeClick
{
    [self.delegate onContactTypeClick:self withTypes:self.contactTypes];
}

- (void)setContactType:(NSString *)contactType
{
    _contactType = [contactType copy];
    ((UITextField *)self.textFields[@"Type"]).text = contactType;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end