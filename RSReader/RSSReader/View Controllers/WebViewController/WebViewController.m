//
//  WebViewController.m
//  RSSReader
//
//  Created by Eduard Ivash on 15.12.20.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

-(UIWebView *)webView {
    _webView = [[UIWebView alloc]init];
    [self.view addSubview:_webView];
    return _webView;
}

@end
