//
//  RSSCell.m
//  RSSReader
//
//  Created by Eduard Ivash on 28.12.20.
//

#import "RSSCell.h"

NSString *const kRssImageName = @"RSS_Image";

@interface RSSCell ()

@property (retain, nonatomic) IBOutlet UIImageView *rssCellImage;
@property (retain, nonatomic) IBOutlet UILabel *rssCellTitle;

@end

@implementation RSSCell

- (void)configureRssChannels:(NSString *)rssString {
    self.rssCellTitle.text = rssString;
    self.rssCellImage.image = [UIImage imageNamed:kRssImageName];
}

- (void)dealloc {
    [_rssCellImage release];
    [_rssCellTitle release];
    [super dealloc];
}
@end
