#import <Foundation/Foundation.h>
#import "CustomNavBar.h"

@interface CustomNavBar ()
@property(nonatomic) BOOL isShowEdit;
@property(nonatomic) BOOL isShowAdd;
@property(nonatomic) BOOL isShowDone;
@end

@implementation CustomNavBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.isShowAdd = NO;
        self.isShowEdit = NO;
        self.isShowDone = NO;
        [self setBackgroundColor:[UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1]];
        [self setOpaque:YES];
        // need to set a background image for the view to appear
        [self setBackgroundImage:[UIImage imageNamed:@"phone1.png"] forToolbarPosition:UIBarPositionTop barMetrics:UIBarMetricsDefault];
    }
    return self;
}

- (void) buildButtons{
    self.backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.backButton.frame = CGRectMake(self.frame.size.width * .1, 20, 50, 20);
    [self.backButton setTitleColor:[UIColor colorWithRed:216/255.0f green:122/255.0f blue:39/255.0f alpha:1] forState:UIControlStateNormal];
    [self.backButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Regular" size: 17.0]];
    [self.backButton setTitle:@"Back" forState:UIControlStateNormal];
    self.backButton.center = CGPointMake(self.frame.size.width * .1, 40);
    
    [self addSubview:self.backButton];
    [self showBackButton:NO];
    
    
    self.addButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.addButton.frame = CGRectMake(self.frame.size.width * .85, 20, 50, 40);
    [self.addButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size: 30.0]];
    [self.addButton setTitleColor: [UIColor colorWithRed:107/255.0f green:170/255.0f blue:178/255.0f alpha:1] forState:UIControlStateNormal];
    [self.addButton setTitle:@"+" forState:UIControlStateNormal];
    self.addButton.center = CGPointMake(self.frame.size.width * .82, 38);
    
    [self addSubview:self.addButton];
    [self showAddButton:NO];
    
    
    self.editButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.editButton.frame = CGRectMake(self.frame.size.width * .8, 20, 50, 40);
    [self.editButton setTitleColor:[UIColor colorWithRed:241/255.0f green:141/255.0f blue:42/255.0f alpha:1] forState:UIControlStateNormal];

    [self.editButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Regular" size: 17.0] ];
    [self.editButton setTitle:@"Edit" forState:UIControlStateNormal];
    self.editButton.center = CGPointMake(self.frame.size.width * .93, 40);
    
    [self addSubview:self.editButton];
    [self showEditButton:NO];
    
    
    self.doneButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.doneButton.frame = CGRectMake(self.frame.size.width * .8, 20, 50, 40);
    [self.doneButton setTitleColor: [UIColor colorWithRed:102/255.0f green:187/255.0f blue:176/255.0f alpha:1] forState:UIControlStateNormal];
    [self.doneButton setTitleColor:[UIColor colorWithRed:241/255.0f green:141/255.0f blue:42/255.0f alpha:1] forState:UIControlStateNormal];
    [self.doneButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size: 17.0]];
    [self.doneButton setTitle:@"Done" forState:UIControlStateNormal];
    self.doneButton.center = CGPointMake(self.frame.size.width * .93, 40);

    [self addSubview:self.doneButton];
    [self showDoneButton:NO];
}

- (void) buildLogo{
    UIImage* dfLogo = [UIImage imageNamed:@"DreamFactory-logo-horiz-filled.png"];
    // calc new size
    // new height = (imagewidth / newWidth) * imageheight
    UIImage* resizable = [dfLogo resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    
    UIImageView* logoView = [[UIImageView alloc] initWithImage:resizable];
    
    logoView.frame = CGRectMake(0, 0, self.frame.size.width * .45, dfLogo.size.height* dfLogo.size.width / (self.frame.size.width * .5));
    
    logoView.contentMode = UIViewContentModeScaleAspectFit;
    
    [logoView setCenter:CGPointMake(self.frame.size.width * 0.48, self.frame.size.height * 0.6)];
    
    [self addSubview:logoView];
}

- (void) showAddButton:(BOOL)show{
    [self.addButton setHidden:!show];
}

- (void) showBackButton:(BOOL)show {
    [self.backButton setHidden:!show];
}

- (void) showEditButton:(BOOL)show {
    [self.editButton setHidden:!show];
}

- (void) showDoneButton:(BOOL)show{
    [self.doneButton setHidden:!show];
}
- (void) showAdd {
    [self showAddButton:YES];
    [self showDoneButton:NO];
    [self showEditButton:NO];
}

- (void) showEditAndAdd{
    [self showDoneButton:NO];
    [self showEditButton:YES];
    [self showAddButton:YES];
    [self showAddButton:YES];
}
- (void) showDone {
    [self showDoneButton:YES];
    [self showEditButton:NO];
    [self showAddButton:NO];
}

- (void) showEdit {
    [self showDoneButton:NO];
    [self showEditButton:YES];
    [self showAddButton:NO];
}

- (void) disableAllTouch {
    [self.backButton setUserInteractionEnabled:NO];
    [self.addButton setUserInteractionEnabled:NO];
    [self.editButton setUserInteractionEnabled:NO];
    [self.doneButton setUserInteractionEnabled:NO];
}

- (void) enableAllTouch {
    [self.backButton setUserInteractionEnabled:YES];
    [self.addButton setUserInteractionEnabled:YES];
    [self.editButton setUserInteractionEnabled:YES];
    [self.doneButton setUserInteractionEnabled:YES];
    
}

@end