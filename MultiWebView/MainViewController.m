//
//  MainViewController.m
//  MultiWebView
//
//  Created by Lonny Gomes on 11/18/20.
//
// References:
// Load local web files
// - https://stackoverflow.com/questions/49638653/load-local-web-files-resources-in-wkwebview


#import "MainViewController.h"
#import "DetailsViewController.h"
#import <WebKit/WebKit.h>

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    
    [userContentController addScriptMessageHandler:self name:@"btnClicked"];
    
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    [theConfiguration setUserContentController:userContentController];
    
    [theConfiguration.preferences setValue:@"TRUE" forKey:@"allowFileAccessFromFileURLs"];
    //[theConfiguration `]
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration: theConfiguration];
    
    // webView.navigationDelegate = self;
//    NSURL *htmlUrl = [[[NSBundle mainBundle] URLForResource:@"main-view" withExtension:@"html" subdirectory:@"assets"]];
//
    
    // NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"html" inDirectory:@"content"];
    NSURL *htmlUrl = [[NSBundle mainBundle] URLForResource:@"main-view" withExtension:@"html"];
    
    [webView loadFileURL:htmlUrl allowingReadAccessToURL:[htmlUrl URLByDeletingLastPathComponent]];
    
    [self.view addSubview:webView];
}

- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"We got this %@", message.body);
    
    DetailsViewController *controller = [[DetailsViewController alloc] init];
    
    [self presentViewController:controller animated:YES completion:nil];
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
