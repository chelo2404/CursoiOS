//
//  LoginViewController.m
//  EjercicioTwitter
//
//  Created by Gerardo Fernandez on 1/5/16.
//  Copyright © 2016 Gerardo Fernandez. All rights reserved.
//

#import "AppSearchViewController.h"
#import "Masonry.h"
#import "iTunesAPI.h"
#import "AppSearchResultsViewController.h"

@interface AppSearchViewController ()
@property UITextField *searchTextField;
@end

@implementation AppSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIGestureRecognizer *tapper;
    tapper = [[UITapGestureRecognizer alloc]
              initWithTarget:self action:@selector(handleSingleTap:)];
    tapper.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapper];
    
    // Do any additional setup after loading the view.
    
    [self.navigationItem setTitle:@"Search"];
    
    UIColor *lightBlueColor = [UIColor colorWithRed: 108.0/255.0 green: 221.0/255.0 blue:255.0/255.0 alpha: 1.0];
    
    [self.view setBackgroundColor:lightBlueColor];
    
    UIEdgeInsets padding = UIEdgeInsetsMake(20, 20, 20, 20);
    
    UIView *searchForm = [[UIView alloc] init];
    
    [self.view addSubview:searchForm];
    
    [searchForm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(self.view.mas_height).with.multipliedBy(0.5);
        make.centerY.equalTo(self.view.mas_centerY);
    }];
    
    
    // Instructions label
    UILabel *instructionsLabel = [[UILabel alloc] init];
    
    [searchForm addSubview:instructionsLabel];
    
    [instructionsLabel setText:@"Please enter a keyword in order to search related media"];
    [instructionsLabel setTextColor:[UIColor blackColor]];
    [instructionsLabel setTextAlignment:NSTextAlignmentCenter];
    [instructionsLabel setNumberOfLines:0];
    [instructionsLabel sizeToFit];
    
    [instructionsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(searchForm.mas_top);
        make.width.equalTo(searchForm.mas_width).with.multipliedBy(0.75);
        make.centerX.equalTo(searchForm.mas_centerX);
    }];
    
    // Username text field
    self.searchTextField = [[UITextField alloc] init];
    
    [searchForm addSubview:self.searchTextField];
    
    [self.searchTextField setPlaceholder:@"Keyword"];
    [self.searchTextField setTextColor:[UIColor blackColor]];
    [self.searchTextField setTextAlignment:NSTextAlignmentCenter];
    [self.searchTextField setBackgroundColor:[UIColor whiteColor]];
    
    self.searchTextField.layer.borderColor = [UIColor blackColor].CGColor;
    self.searchTextField.layer.borderWidth = 1;
    self.searchTextField.layer.cornerRadius = 5;
    
    [self.searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(instructionsLabel.mas_bottom).with.offset(padding.top);
        make.width.equalTo(searchForm.mas_width).with.multipliedBy(0.5);
        make.centerX.equalTo(searchForm.mas_centerX);
    }];
    
    // Login button
    UIButton *loginButton = [[UIButton alloc] init];
    
    [searchForm addSubview:loginButton];
    
    [loginButton setTitle:@"Search" forState:UIControlStateNormal];
    [loginButton setBackgroundColor:[UIColor blueColor]];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    loginButton.layer.borderColor = [UIColor blackColor].CGColor;
    loginButton.layer.borderWidth = 1;
    loginButton.layer.cornerRadius = 10;
    
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchTextField.mas_bottom).with.offset(padding.top);
        make.width.equalTo(searchForm.mas_width).with.multipliedBy(0.5);
        make.centerX.equalTo(searchForm.mas_centerX);
    }];
    
    [loginButton addTarget: self action:@selector(doSearch) forControlEvents:UIControlEventTouchUpInside];
}

- (void) doSearch {
    if(self.searchTextField.text.length != 0) {
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self.view addSubview: activityIndicator];
        
        [activityIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.centerY.equalTo(self.view.mas_centerY);
        }];
        
        [activityIndicator startAnimating];
        
        // login to twitter
        [iTunesAPI searchMediaByKeyword:self.searchTextField.text success:^(NSMutableArray *results) {
            //NSLog(@"Entering success callback with results: %@", results);
            AppSearchResultsViewController* searchResultsView = [[AppSearchResultsViewController alloc] init];
            searchResultsView.resultsData = results;
            [activityIndicator stopAnimating];
            [[self navigationController] pushViewController:searchResultsView animated:YES];
        } failure:^(NSString *errorMessage) {
            NSLog(@"Entering failure callback with errorMessage: %@", errorMessage);
        }];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Enter a keyword to search"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"OK",nil];
        [alert show];
    }
}

- (void)handleSingleTap:(UITapGestureRecognizer *) sender
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
