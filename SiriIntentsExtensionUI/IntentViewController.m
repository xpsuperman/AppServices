//
//  IntentViewController.m
//  SiriIntentsExtensionUI
//
//  Created by Xu Peng on 2017/8/2.
//  Copyright © 2017年 lilac. All rights reserved.
//

#import "IntentViewController.h"
#import <Masonry/Masonry.h>
#import <Intents/Intents.h>

// As an example, this extension's Info.plist has been configured to handle interactions for INSendMessageIntent.
// You will want to replace this or add other intents as appropriate.
// The intents whose interactions you wish to handle must be declared in the extension's Info.plist.

// You can test this example integration by saying things to Siri like:
// "Send a message using <myApp>"

@interface IntentViewController ()

@end

@implementation IntentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

#pragma mark - INUIHostedViewControlling

// Prepare your view controller for the interaction to handle.
- (void)configureWithInteraction:(INInteraction *)interaction context:(INUIHostedViewContext)context completion:(void (^)(CGSize))completion {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"applepay"]];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.view addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(5);
        make.centerX.equalTo(self.view);
    }];
    
    if ([interaction.intent isKindOfClass:[INSendPaymentIntent class]]) {
        INSendPaymentIntent *paymentIntent = (INSendPaymentIntent *)interaction.intent;
        NSDecimalNumber *amount = paymentIntent.currencyAmount.amount;
        NSString *currency = paymentIntent.currencyAmount.currencyCode;
        NSString *name = paymentIntent.payee.displayName;
        if (amount && currency && name) {
            nameLabel.text = [NSString stringWithFormat:@"给%@ %@ %@", name, amount, currency];
        } else {
            if (completion) {
                completion(CGSizeZero);
            }
            return;
        }
    }
    
    if (completion) {
        completion([self desiredSize]);
    }
}

- (CGSize)desiredSize {
    return [self extensionContext].hostedViewMaximumAllowedSize;
}

- (BOOL)displaysPaymentTransaction
{
    return YES;
}

@end
