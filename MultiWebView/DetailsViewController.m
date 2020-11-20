//
//  DetailsViewController.m
//  MultiWebView
//
//  Created by Lonny Gomes on 11/18/20.
//

#import "DetailsViewController.h"
#import "WebKit/Webkit.h"
@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // layout anchors
    // https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/ProgrammaticallyCreatingConstraints.html
    
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    UIBarButtonItem *button1 = [[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStyleDone target:self action:@selector(sendAction)];

    UIBarButtonItem *button2=[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(cancelAction)];

    // https://www.thinkandbuild.it/learn-to-love-auto-layout-programmatically/
    [toolbar setItems:[[NSArray alloc] initWithObjects:button1,button2, nil]];
    [toolbar setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    WKWebView *wv = [self loadContent];
    // [wv setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSDictionary *viewsDictionary = @{@"webView":wv, @"toolbarView": toolbar};
    
    
    NSArray *constraintToolbarV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[toolbarView(50)]"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:viewsDictionary];
        
    NSArray *constraintToolbarH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[toolbarView(350)]"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:viewsDictionary];
    [toolbar addConstraints:constraintToolbarV];
    [toolbar addConstraints:constraintToolbarH];
    
    [self.view addSubview:toolbar];
}

-(void)sendAction {
    NSLog(@"Send");
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)cancelAction {
    NSLog(@"Cancel");
}

- (WKWebView *)loadContent {
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    CGRect wvFrame = self.view.frame;
    // wvFrame.origin.y = 50;
    WKWebView *webView = [[WKWebView alloc] initWithFrame:wvFrame configuration: theConfiguration];
    
    // webView.navigationDelegate = self;
    
    NSURL *nsurl=[NSURL URLWithString:@"http://www.apple.com"];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    
    [webView loadRequest:nsrequest];
    [self.view addSubview:webView];
    
    return webView;
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
