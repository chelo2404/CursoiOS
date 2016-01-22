//
//  AppDelegate.h
//  EjercicioTwitter
//
//  Created by Gerardo Fernandez on 12/16/15.
//  Copyright © 2015 Gerardo Fernandez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppSearchViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) AppSearchViewController *searchViewController;


@end

