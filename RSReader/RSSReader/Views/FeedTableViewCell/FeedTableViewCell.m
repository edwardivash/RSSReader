//
//  FeedTableViewCell.m
//  RSSReader
//
//  Created by Eduard Ivash on 18.11.20.
//

#import "FeedTableViewCell.h"
#import "Feeds.h"
#import "NSString+GetSubstringFromDescription.h"

NSString *const kSelectedImageName = @"buttonActive";
NSString *const kDisabledImageName = @"buttonDisabled";

@interface FeedTableViewCell ()

@property (retain, nonatomic) IBOutlet UIButton *descriptionButton;
@property (retain, nonatomic) IBOutlet UILabel *feedLabel;
@property (retain, nonatomic) IBOutlet UILabel *pubDateLabel;
@property (retain, nonatomic) UITextView *descTextView;

@end

@implementation FeedTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setDescTextViewLayout];
}

- (void)changeFeedTableCellButtonState:(NSIndexPath *)indexPath array:(NSMutableArray *)array block:(void (^)(UIButton *button)) blockName {
    
    self.descriptionButton.tag = indexPath.row;
    BOOL isContained = [array containsObject:indexPath];
    UIImage *image = isContained ? [UIImage imageNamed:kSelectedImageName] : [UIImage imageNamed:kDisabledImageName];
    [self.descriptionButton setImage:image forState:UIControlStateNormal];
    [self.descTextView setHidden: !isContained];
    
    typeof (self)weakSelf = self;
    blockName(weakSelf.descriptionButton);
}

#pragma mark - Getters

- (UITextView *)descTextView {
    if (!_descTextView) {
        _descTextView = [UITextView new];
        _descTextView.translatesAutoresizingMaskIntoConstraints = NO;
        _descTextView.backgroundColor = [UIColor clearColor];
        _descTextView.selectable = NO;
        _descTextView.scrollEnabled = NO;
        _descTextView.userInteractionEnabled = NO;
        _descTextView.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        [_descTextView setHidden:YES];
        [self.contentView addSubview:_descTextView];
    }
    return _descTextView;
}

- (UIButton *)descriptionButton {
    if (!_descriptionButton) {
        _descriptionButton = [[UIButton alloc] init];
    }
    return _descriptionButton;
}

#pragma mark - Private Method

- (void)setDescTextViewLayout {
    [NSLayoutConstraint activateConstraints:@[
        [self.descTextView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:1],
        [self.descTextView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:3],
        [self.descTextView.topAnchor constraintEqualToAnchor:self.feedLabel.bottomAnchor],
        [self.descTextView.bottomAnchor constraintEqualToAnchor:self.pubDateLabel.topAnchor]
    ]];
}

- (void)configureFeedItem:(Feeds *)feed {
    self.feedLabel.text = feed.feedsTitle;
    self.pubDateLabel.text = feed.feedsPubDate;
    self.descTextView.text = [NSString descriptionsSubstring:feed.feedsDescription];
}

- (void)dealloc {
    [_feedLabel release];
    [_pubDateLabel release];
    [_descTextView release];
    [_descriptionButton release];
    [super dealloc];
}

@end
