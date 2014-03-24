//
//  todoTableViewCell.m
//  TodoList
//
//  Created by Sachin Soni on 2/27/14.
//  Copyright (c) 2014 sachin. All rights reserved.
//

#import "todoTableViewCell.h"

@implementation todoTableViewCell

@synthesize deleteButton,todoTextLabel,strikeFontLabel,record_Id,isComplete;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTaskComplete:(BOOL)complete{
    
    dispatch_async(dispatch_get_main_queue(),^ (void){
        if (complete) {
            [self.strikeFontLabel setHidden:NO];
            NSString *string = self.todoTextLabel.text;
            NSDictionary *attributes = @{NSFontAttributeName:self.todoTextLabel.font};
            CGSize stringSize = [string sizeWithAttributes:attributes];
            CGRect buttonFrame = self.todoTextLabel.frame;
            CGRect labelFrame = CGRectMake(buttonFrame.origin.x ,
                                           buttonFrame.origin.y+3 + stringSize.height/2,
                                           stringSize.width, 2);
            [self.strikeFontLabel setFrame:labelFrame];
            self.strikeFontLabel.backgroundColor = [UIColor blackColor];
        }else{
            [self.strikeFontLabel setHidden:YES];
            [self.strikeFontLabel setText:@""];
        }
    });

    
    
}

@end
