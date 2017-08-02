//
//  APSSiriViewController.m
//  AppServices
//
//  Created by Xu Peng on 2017/8/2.
//  Copyright © 2017年 lilac. All rights reserved.
//

#import "APSSiriViewController.h"
#import <Intents/Intents.h>
#import <Masonry/Masonry.h>

@interface APSSiriViewController ()

@property (nonatomic, strong) UILabel *authorizationLabel;

@end

@implementation APSSiriViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.view setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
    [self requestSiriAuthorization];
}

- (void)setupUI
{
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    nameLabel.text = @"Siri 授权状态：";
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.font = [UIFont systemFontOfSize:14.0f];
    [nameLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [self.view addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(self.view).offset(100);
    }];
    
    self.authorizationLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.authorizationLabel.backgroundColor = [UIColor clearColor];
    self.authorizationLabel.textColor = [UIColor blackColor];
    self.authorizationLabel.font = [UIFont systemFontOfSize:14.0f];
    self.authorizationLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:self.authorizationLabel];
    [self.authorizationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_right).offset(10);
        make.top.equalTo(nameLabel);
        make.right.equalTo(self.view).offset(-10);
    }];
}

- (void)requestSiriAuthorization
{
    [INPreferences requestSiriAuthorization:^(INSiriAuthorizationStatus status) {
        [self configLabelStatus:status];
    }];
}

- (void)configLabelStatus:(INSiriAuthorizationStatus)status
{
    switch (status) {
        case INSiriAuthorizationStatusAuthorized:
            self.authorizationLabel.text = @"已授权";
            break;
        case INSiriAuthorizationStatusRestricted:
            self.authorizationLabel.text = @"受限制";
            break;
        case INSiriAuthorizationStatusDenied:
            self.authorizationLabel.text = @"被否定";
            break;
        case INSiriAuthorizationStatusNotDetermined:
            self.authorizationLabel.text = @"没有决定";
            break;
        default:
            break;
    }
}


@end
