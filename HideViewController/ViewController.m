//
//  ViewController.m
//  HideViewController
//
//  Created by CzJ on 2018/12/6.
//  Copyright © 2018 CzJ. All rights reserved.
//

#import "ViewController.h"
#import "NewViewController.h"
#import "AppDelegate.h"
@interface ViewController ()
@property(nonatomic ,assign) BOOL showNewVc;
@property(nonatomic ,assign) BOOL isTouch;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (_isTouch) {
        return;
    }
   
    // 设置新的rootviewController
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    // 获取根控制器
    
    UIViewController *rootVc = appdelegate.window.rootViewController;
    
    // 设置新的根控制器
    UIViewController *tmpController = [[UIViewController alloc] init];
    appdelegate.window.rootViewController = tmpController;
    
    // 新的视图
    NewViewController *newVc = [[NewViewController alloc] init];
    
    [tmpController addChildViewController:rootVc];
    [tmpController addChildViewController:newVc];
    [tmpController.view addSubview:rootVc.view];
    
    // 显示新的视图
    [tmpController transitionFromViewController:rootVc toViewController:newVc duration:0.1 options:UIViewAnimationOptionTransitionNone animations:^{
    } completion:^(BOOL finished){
        self.showNewVc = YES;
        self.isTouch = YES;
    }];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 100, 150, 100)];
    btn.backgroundColor = [UIColor blueColor];
    [btn setTitle:@"切换视图" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(touchWay) forControlEvents:UIControlEventTouchUpInside];
    [appdelegate.window addSubview:btn];
    
}
- (void) touchWay {
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIViewController *rootVc = appdelegate.window.rootViewController;
    UIViewController *firstVc = [rootVc.childViewControllers firstObject];
    UIViewController *secondVc = [rootVc.childViewControllers lastObject];
    if (_showNewVc) {
        [rootVc transitionFromViewController:secondVc toViewController:firstVc duration:0.1 options:UIViewAnimationOptionTransitionNone animations:nil completion:nil];
        _showNewVc = NO;
    } else {
        [rootVc transitionFromViewController:firstVc toViewController:secondVc duration:0.1 options:UIViewAnimationOptionTransitionNone animations:nil completion:nil];
        _showNewVc = YES;
    }
}
@end
