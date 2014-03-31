//
//  TabBarViewController.m
//  WildKingdom
//
//  Created by Aaron Dufall on 30/03/2014.
//  Copyright (c) 2014 Aaron Dufall. All rights reserved.
//

#import "TabBarViewController.h"
#import "ViewController.h"

@interface TabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation TabBarViewController

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//	// Do any additional setup after loading the view.
//}
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}


- (id)initWithCoder:(NSCoder *)aDecoder {
	if ( self == [super initWithCoder:aDecoder] ) {
		self.delegate = self;
	}
	return self;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(ViewController *)viewController {
	NSString *tag = tabBarController.selectedViewController.tabBarItem.title;
    [viewController seachFlickrFor:[tag lowercaseString]];
    
}

@end
