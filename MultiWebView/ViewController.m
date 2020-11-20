//
//  ViewController.m
//  MultiWebView
//
//  Created by Lonny Gomes on 11/18/20.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) MainViewController *mainController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.mainController = [[MainViewController alloc] init];
    
    //navController = [[UINavigationController alloc] initWithRootViewController:self.mainController];
    
    [self.view addSubview:self.mainController.view];
}

- (IBAction)btnClick:(id)sender {
    NSLog(@"here we go");
    detailsController = [[DetailsViewController alloc] init];
    [navController pushViewController:detailsController animated:YES];
}

@end
