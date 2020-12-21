//
//  UIAlertController+ShowAlertController.m
//  RSSReader
//
//  Created by Eduard Ivash on 4.12.20.
//

#import "UIAlertController+ShowAlertController.h"

@implementation UIAlertController (ShowAlertController)

+(UIAlertController *)showAlertController:(NSError *)error {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@", error] message:@"Check your internet connection." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okAction];
    return alert;
}

@end
