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
    
    NSString *inputData =  @"{\"title\": \"Value for title that is very long so we can test if it truncates\", \"isDarkMode\": true, \"orientation\": \"landscape\" }";
    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[inputData dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];

    if (error) {
        // could not parse, so set defaults
        json = @{@"title": @"", @"isDarkMode": @NO, @"orientation": @"landscape"};
    }
    
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

    CGRect tbFrame = CGRectMake(0, 0, self.view.frame.size.width, 45.0);
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:tbFrame];

    UIBarButtonItem *button1 = [[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStyleDone target:self action:@selector(sendAction)];

    UILabel *labelTxt = [[UILabel alloc] init];
    [labelTxt setText:[json valueForKey:@"title"]];
    [labelTxt setFont:[UIFont fontWithName:@"Georgia-Bold" size:18.0]];
    //[labelTxt setTextColor:[UIColor blackColor]];
    UIBarButtonItem *label = [[UIBarButtonItem alloc] initWithCustomView:labelTxt];
    NSNumber *isDarkMode = (NSNumber *)[json valueForKey:@"isDarkMode"];
    
    if ([isDarkMode boolValue] == YES) {
        [toolbar setTintColor:[UIColor whiteColor]];
        [toolbar setBackgroundColor:[UIColor blackColor]];
    }
    
//    for( NSString *strFamilyName in [UIFont familyNames] ) {
//      for( NSString *strFontName in [UIFont fontNamesForFamilyName:strFamilyName] ) {
//        NSLog(@"%@", strFontName);
//      }
//    }

    // https://www.thinkandbuild.it/learn-to-love-auto-layout-programmatically/
    [toolbar setItems:[[NSArray alloc] initWithObjects:button1, spacer, label, nil]];
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
