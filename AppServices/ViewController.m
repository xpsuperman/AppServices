//
//  ViewController.m
//  AppServices
//
//  Created by Xu Peng on 2017/8/2.
//  Copyright © 2017年 lilac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *appServicesTableView;
@property (nonatomic, copy) NSArray *dataArray;

@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupData];
    [self setupUI];
}

- (void)setupData
{
    _dataArray = @[
                   @[@"Siri Helper", @"Test Siri", @"APSSiriViewController"]
                   ];
}

- (void)setupUI
{
    self.navigationItem.title = @"App Services";
}

#pragma mark -
#pragma mark UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"AppServicesCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSArray *contentArray = self.dataArray[indexPath.row];
    cell.textLabel.text = contentArray[0];
    cell.detailTextLabel.text = contentArray[1];
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *contentArray = self.dataArray[indexPath.row];
    NSString *clsString = contentArray[2];
    UIViewController *vc = [[NSClassFromString(clsString) alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
