//
//  RSSCell.m
//  RSSReader
//
//  Created by Eduard Ivash on 28.12.20.
//

#import "RSSCell.h"

NSString *const kRssImageName = @"RSS_Image";

@interface RSSCell ()

@property (strong, nonatomic) IBOutlet UIImageView *rssCellImage;
@property (strong, nonatomic) IBOutlet UILabel *rssCellTitle;

@end

@implementation RSSCell

- (void)configureRssChannels:(NSString *)rssString {
    self.rssCellTitle.text = rssString;
    self.rssCellImage.image = [UIImage imageNamed:kRssImageName];
}

@end
