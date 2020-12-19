//
//  FeedTableViewCell.m
//  RSSReader
//
//  Created by Eduard Ivash on 18.11.20.
//

#import "FeedTableViewCell.h"
#import "Feeds.h"
#import "NSString+GetSubstringFromDescription.h"

@interface FeedTableViewCell ()

@property (retain, nonatomic) IBOutlet UILabel *feedLabel;
@property (retain, nonatomic) IBOutlet UILabel *pubDateLabel;

@end

@implementation FeedTableViewCell

- (void)configureFeedItem:(Feeds *)feed {
    self.feedLabel.text = feed.feedsTitle;
    self.pubDateLabel.text = feed.feedsPubDate;
    self.descTextView.text = [NSString descriptionsSubstring:feed.feedsDescription];
}

- (UITextView *)descTextView { 
    if (!_descTextView) {
        _descTextView = [UITextView new];
        _descTextView.translatesAutoresizingMaskIntoConstraints = NO;
        _descTextView.backgroundColor = [UIColor clearColor];
        _descTextView.selectable = NO;
        _descTextView.scrollEnabled = NO;
        _descTextView.userInteractionEnabled = NO;
        _descTextView.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
        [_descTextView setHidden:YES];
        [self.contentView addSubview:_descTextView];
        
        NSLayoutConstraint *heighConstraint = [_descTextView.heightAnchor constraintEqualToConstant:_descTextView.frame.size.height];
        heighConstraint.priority = 999;
        [NSLayoutConstraint activateConstraints:@[
            [_descTextView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:5],
            [_descTextView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:5],
            [_descTextView.topAnchor constraintEqualToAnchor:self.feedLabel.bottomAnchor],
            [_descTextView.bottomAnchor constraintEqualToAnchor:self.pubDateLabel.topAnchor]
        ]];
    }
    return _descTextView;
}

- (void)dealloc {
    [_feedLabel release];
    [_pubDateLabel release];
    [_descTextView release];
    [_descriptionButton release];
    [super dealloc];
}

@end
