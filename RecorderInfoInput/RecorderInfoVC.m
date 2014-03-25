//
//  RecorderInfoVC.m
//  RecorderInfoInput
//
//  Created by Phu Nguyen on 3/25/14.
//  Copyright (c) 2014 Green Global. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "RecorderInfoVC.h"
#import "ViewerDetailsMoreInfoCell.h"
#import "LabelTextkit.h"
#import "Common.h"

#define NUMBER_OF_ITEMS 4
#define TEXTFIELD_WIDTH 245.0

@interface RecorderInfoVC () <UITableViewDataSource, UITableViewDelegate> {
    __weak IBOutlet UITableView *_tbvRecorderInfo;
    __weak IBOutlet UIView *_tagsView;
    __weak IBOutlet UIScrollView *_scvTags;
    __weak IBOutlet UITextField *_txfAddTag;
    __weak IBOutlet UIButton *_btnAddTag;
    
    NSArray *_arrTags;
}

- (IBAction)addTag: (id)sender;

@end

@implementation RecorderInfoVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [_tbvRecorderInfo.layer setMasksToBounds:YES];
    [_tbvRecorderInfo.layer setCornerRadius:5.0];
    [_tbvRecorderInfo.layer setBorderColor: [UIColor lightGrayColor].CGColor];
    [_tbvRecorderInfo.layer setBorderWidth:1.5];
    
    // add tag view as subview
    [_tagsView removeFromSuperview];
    _tagsView.frame = CGRectMake(0.0, 275.0, 320.0, 86.0);
    [self.view addSubview:_tagsView];

    _arrTags = [[NSArray alloc] initWithObjects:@"Nature", @"Nomakeup", @"Notdead", @"Naildead", @"Common", @"Method", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return NUMBER_OF_ITEMS;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"ViewerDetailsMoreInfoCell";
    ViewerDetailsMoreInfoCell *cell = (ViewerDetailsMoreInfoCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    cell.lblContent.font = FONT_LATO_LIGHT(13.0);
    
    switch (indexPath.row) {
        case 0: {
            cell.lblContent.text = @"Title";
            break;
        }
            
        case 1:
            cell.lblContent.text = @"San Francisco, CA";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.lblContent.textColor = [UIColor grayColor];
            break;
            
        case 2:
            cell.lblContent.text = @"Tags";
            break;
            
        case 3:
            cell.lblContent.text = @"Description";
            break;
            
        default:
            break;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 2) {
        float x = 0.0;
        // init scroll view items
        for (NSString *tag in _arrTags) {
            if (tag && ![tag isEqualToString:@""]) {
                NSString *tagString = [NSString stringWithFormat:@"#%@", tag];
                CGSize tagSize = [Common sizeOfString:tagString inFont:FONT_LATO_REGULAR(13.0) maxWidth:TEXTFIELD_WIDTH];
                // init button
                UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x, 0, tagSize.width + 5, 30.0)];
                [button setTitle:tagString forState:UIControlStateNormal];
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                button.titleLabel.font = FONT_LATO_REGULAR(13.0);
                [button addTarget:self action:@selector(chooseTag:) forControlEvents:UIControlEventTouchUpInside];
                [_scvTags addSubview:button];
                x += tagSize.width + 5;
            }
        }
        
        [_scvTags setContentSize:CGSizeMake(x + 20, 30)];
        
    } else {
        
    }
    
}

#pragma mark - Actions

- (IBAction)addTag: (id)sender {
    
}

- (IBAction)chooseTag: (id)sender {
    
    UIButton *button = (UIButton *) sender;
    _txfAddTag.text = button.titleLabel.text;
    
}

#pragma mark - Private methods

- (void) initializeTagsView {
    
    // init scroll view
    
}

@end
