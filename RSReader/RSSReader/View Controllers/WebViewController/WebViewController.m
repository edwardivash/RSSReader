//
//  WebViewController.m
//  RSSReader
//
//  Created by Eduard Ivash on 15.02.21.
//

#import "WebViewController.h"

NSString *const kBackButton = @"backButton";
NSString *const kForwardButton = @"forwardButton";
NSString *const kRefreshButton = @"refreshButton";
NSString *const kStopButton = @"stopButton";
NSString *const kSafariButton = @"safariButton";

@interface WebViewController () <UIWebViewDelegate>

@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) UIBarButtonItem *backButton;
@property (nonatomic, retain) UIBarButtonItem *forwardButton;
@property (nonatomic, retain) UIBarButtonItem *refreshButton;
@property (nonatomic, retain) UIBarButtonItem *stopButton;
@property (nonatomic, retain) UIBarButtonItem *safariButton;
@property (nonatomic, retain) UIBarButtonItem *barButtonsSeparater;

@end

@implementation WebViewController

#pragma mark - ViewController Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customizeWebViewInWebViewVC];
    
    [self setToolbarItems:[NSArray arrayWithObjects:self.backButton,self.barButtonsSeparater,
                           self.forwardButton,self.barButtonsSeparater,
                           self.refreshButton,self.barButtonsSeparater,
                           self.stopButton,self.barButtonsSeparater,
                           self.safariButton,nil]];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[self.stringWithURL objectAtIndex:0]]]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setToolbarHidden:NO animated:NO];
}

#pragma mark - Getters

- (UIBarButtonItem *)backButton {
    if (!_backButton) {
        _backButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:kBackButton] style:UIBarButtonItemStylePlain target:self.webView action:@selector(goBack)];
    }
    return _backButton;
}

- (UIBarButtonItem *)forwardButton {
    if (!_forwardButton) {
        _forwardButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:kForwardButton] style:UIBarButtonItemStylePlain target:self.webView action:@selector(goForward)];
    }
    return _forwardButton;
}

- (UIBarButtonItem *)refreshButton {
    if (!_refreshButton) {
        _refreshButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:kRefreshButton] style:UIBarButtonItemStylePlain target:self.webView action:@selector(reload)];
    }
    return _refreshButton;
}

- (UIBarButtonItem *)stopButton {
    if (!_stopButton) {
        _stopButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:kStopButton] style:UIBarButtonItemStylePlain target:self.webView action:@selector(stopLoading)];
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
        _barButtonsSeparater = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    }
    return _barButtonsSeparater;
}

- (NSMutableArray *)stringWithURL {
    if (!_stringWithURL) {
        _stringWithURL = [[NSMutableArray alloc]init];
    }
    return _stringWithURL;
}

#pragma mark - ToolBarButton action

-(void)safariAction {
    [self.navigationController popToRootViewControllerAnimated:YES];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[_stringWithURL objectAtIndex:0]] options:@{} completionHandler:^(BOOL openUrl) {
        NSLog(@"%@", openUrl ? @"Open URL":@"Can't open URL");
    }];
}

#pragma mark - WebView customize

- (void)customizeWebViewInWebViewVC {
    if (!_webView) {
        _webView = [UIWebView new];
        [_webView setBackgroundColor:[UIColor whiteColor]];
        _webView.delegate = self;
        _webView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:_webView];
        [NSLayoutConstraint activateConstraints:@[
            [_webView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
            [_webView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
            [_webView.topAnchor constraintEqualToAnchor:self.view. safeAreaLayoutGuide.topAnchor],
            [_webView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor]
        ]];
    }
}


- (void)dealloc
{
    [_stringWithURL release];
    [_webView release];
    [_backButton release];
    [_forwardButton release];
    [_stopButton release];
    [_refreshButton release];
    [_safariButton release];
    [_barButtonsSeparater release];
    [super dealloc];
}

@end
