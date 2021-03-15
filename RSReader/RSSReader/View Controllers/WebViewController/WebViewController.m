//
//  WebViewController.m
//  RSSReader
//
//  Created by Eduard Ivash on 15.02.21.
//

#import <WebKit/WebKit.h>
#import "WebViewController.h"

NSString *const kBackButton = @"backButton";
NSString *const kForwardButton = @"forwardButton";
NSString *const kRefreshButton = @"refreshButton";
NSString *const kStopButton = @"stopButton";
NSString *const kSafariButton = @"safariButton";

@interface WebViewController () <WKUIDelegate>

@property (nonatomic, strong) WKWebView *inbuiltBrowserWebView;
@property (nonatomic, strong) UIBarButtonItem *backButton;
@property (nonatomic, strong) UIBarButtonItem *forwardButton;
@property (nonatomic, strong) UIBarButtonItem *refreshButton;
@property (nonatomic, strong) UIBarButtonItem *stopButton;
@property (nonatomic, strong) UIBarButtonItem *safariButton;
@property (nonatomic, strong) UIBarButtonItem *barButtonsSeparater;

@end

@implementation WebViewController

#pragma mark - ViewController Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupWebViewLayout];
    
    self.toolbarItems = @[self.backButton,self.barButtonsSeparater,
                          self.forwardButton,self.barButtonsSeparater,
                          self.refreshButton,self.barButtonsSeparater,
                          self.stopButton,self.barButtonsSeparater,
                          self.safariButton];
    
    [self.inbuiltBrowserWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[self.stringWithURL objectAtIndex:0]]]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setToolbarHidden:NO animated:NO];
}

#pragma mark - Getters

- (WKWebView *)inbuiltBrowserWebView {
    if (!_inbuiltBrowserWebView) {
        _inbuiltBrowserWebView = [WKWebView new];
        _inbuiltBrowserWebView.backgroundColor = [UIColor whiteColor];
        _inbuiltBrowserWebView.translatesAutoresizingMaskIntoConstraints = NO;
        _inbuiltBrowserWebView.allowsBackForwardNavigationGestures = YES;
    }
    return _inbuiltBrowserWebView;
}

- (UIBarButtonItem *)backButton {
    if (!_backButton) {
        _backButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:kBackButton] style:UIBarButtonItemStylePlain target:self.inbuiltBrowserWebView action:@selector(goBack)];
    }
    return _backButton;
}

- (UIBarButtonItem *)forwardButton {
    if (!_forwardButton) {
        _forwardButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:kForwardButton] style:UIBarButtonItemStylePlain target:self.inbuiltBrowserWebView action:@selector(goForward)];
    }
    return _forwardButton;
}

- (UIBarButtonItem *)refreshButton {
    if (!_refreshButton) {
        _refreshButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:kRefreshButton] style:UIBarButtonItemStylePlain target:self.inbuiltBrowserWebView action:@selector(reload)];
    }
    return _refreshButton;
}

- (UIBarButtonItem *)stopButton {
    if (!_stopButton) {
        _stopButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:kStopButton] style:UIBarButtonItemStylePlain target:self.inbuiltBrowserWebView action:@selector(stopLoading)];
    }
    return _stopButton;
}

- (UIBarButtonItem *)safariButton {
    if (!_safariButton) {
        _safariButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:kSafariButton] style:UIBarButtonItemStylePlain target:self action:@selector(safariAction)];
    }
    return _safariButton;
}

- (UIBarButtonItem *)barButtonsSeparater {
    if (!_barButtonsSeparater) {
        _barButtonsSeparater = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    }
    return _barButtonsSeparater;
}

- (NSMutableArray *)stringWithURL {
    if (!_stringWithURL) {
        _stringWithURL = [[NSMutableArray alloc] init];
    }
    return _stringWithURL;
}

#pragma mark - ToolBarButton action

-(void)safariAction {
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[self.stringWithURL objectAtIndex:0]] options:@{} completionHandler:^(BOOL openUrl) {
        NSLog(@"%@", openUrl ? @"Open URL":@"Can't open URL");
    }];
}

#pragma mark - WebView customize

- (void)setupWebViewLayout {
        [self.view addSubview:self.inbuiltBrowserWebView];
    
        [NSLayoutConstraint activateConstraints:@[
            [self.inbuiltBrowserWebView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
            [self.inbuiltBrowserWebView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
            [self.inbuiltBrowserWebView.topAnchor constraintEqualToAnchor:self.view. safeAreaLayoutGuide.topAnchor],
            [self.inbuiltBrowserWebView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor]
        ]];
}

@end
