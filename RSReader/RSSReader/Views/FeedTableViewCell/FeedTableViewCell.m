//
//  FeedTableViewCell.m
//  RSSReader
//
//  Created by Eduard Ivash on 18.11.20.
//

#import "FeedTableViewCell.h"
#import "Feeds.h"
#import "FeedListVC.h"
#import "NSString+GetSubstringFromDescription.h"

NSString *const kSelectedImageName = @"buttonActive";
NSString *const kDisabledImageName = @"buttonDisabled";
CGFloat descTextViewFontSize = 20;
CGFloat heightTextViewConstraintPripority = 999;

@interface FeedTableViewCell ()

@property (retain, nonatomic) IBOutlet UIButton *descriptionButton;
@property (retain, nonatomic) IBOutlet UILabel *feedLabel;
@property (retain, nonatomic) IBOutlet UILabel *pubDateLabel;
@property (retain, nonatomic) UITextView *descTextView;
@property (retain, nonatomic) NSLayoutConstraint *heightTextViewConstraint;
@property (copy, nonatomic) void(^feedItemConfiguration)(UITableViewCell *cell, NSError *error);
@property (retain, nonatomic) NSMutableArray<NSIndexPath *> *selectedButtons;

@end

@implementation FeedTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
        
    [self setDescTextViewLayout];
    [self.descriptionButton addTarget:self action:@selector(didTapButton) forControlEvents:UIControlEventTouchUpInside];
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
        _descTextView.font = [UIFont systemFontOfSize:descTextViewFontSize weight:UIFontWeightMedium];
        _descTextView.textAlignment = NSTextAlignmentCenter;
        [_descTextView setHidden:YES];
    }
    return _descTextView;
}

- (UIButton *)descriptionButton {
    if (!_descriptionButton) {
        _descriptionButton = [[UIButton alloc] init];
        [_descriptionButton setImage:[UIImage imageNamed:kDisabledImageName] forState:UIControlStateNormal];
    }
    return _descriptionButton;
}

- (NSMutableArray *)selectedButtons {
    if (!_selectedButtons) {
        _selectedButtons = [[NSMutableArray alloc] init];
    }
    return _selectedButtons;
}

- (void (^)(UITableViewCell *, NSError *error))feedItemConfiguration {
    return _feedItemConfiguration;
}

- (NSLayoutConstraint *)heightTextViewConstraint {
    if (!_heightTextViewConstraint) {
        _heightTextViewConstraint = [NSLayoutConstraint new];
    }
    return _heightTextViewConstraint;
}

#pragma mark - Button Tap

- (void)didTapButton {
    NSIndexPath *indPath = [[[NSIndexPath alloc] initWithIndex:self.descriptionButton.tag] autorelease];
    BOOL isContains = [self.selectedButtons containsObject:indPath];
    isContains ? [self.selectedButtons removeObject:indPath] : [self.selectedButtons addObject:indPath];
    isContains = !isContains;
    
    UIImage *img = isContains ? [UIImage imageNamed:kSelectedImageName] : [UIImage imageNamed:kDisabledImageName];
    [self.descriptionButton setImage:img forState:UIControlStateNormal];
    
    CGSize textViewFrameSize = [self.descTextView sizeThatFits:self.descTextView.frame.size];
    isContains ? [self.heightTextViewConstraint setConstant:textViewFrameSize.height]  : [self.heightTextViewConstraint setConstant:0];
    isContains ? [self.descTextView setHidden:NO] : [self.descTextView setHidden:YES];
    
    self.feedItemConfiguration(self,nil);
}


#pragma mark - Configure Feed Item

- (void)configureFeedItem:(Feeds *)feed arrayOfRows:(NSMutableArray *)selectedRows indP:(NSIndexPath *)indexPath completion:(void(^)(UITableViewCell *cell, NSError *error)) feedItemConfiguration {

    self.feedItemConfiguration = feedItemConfiguration;
    
    self.feedLabel.text = feed.feedsTitle;
    self.pubDateLabel.text = feed.feedsPubDate;
    self.descTextView.text = [NSString getDescriptionsSubstringFromRSSDescription:feed.feedsDescription];
    self.descriptionButton.tag = indexPath.row;
    
    BOOL isContained = [selectedRows containsObject:indexPath];
    UIImage *image = isContained ? [UIImage imageNamed:kSelectedImageName] : [UIImage imageNamed:kDisabledImageName];
    [self.descriptionButton setImage:image forState:UIControlStateNormal];
    
    CGSize textViewFrameSize = [self.descTextView sizeThatFits:self.descTextView.frame.size];
    isContained ? [self.heightTextViewConstraint setConstant:textViewFrameSize.height]  : [self.heightTextViewConstraint setConstant:0];
    
    isContained ? [self.descTextView setHidden:NO] : [self.descTextView setHidden:YES];
}

#pragma mark - Layout

- (void)setDescTextViewLayout {
    [self.contentView addSubview:self.descTextView];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.descTextView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor],
        [self.descTextView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor],
        [self.descTextView.topAnchor constraintEqualToAnchor:self.feedLabel.bottomAnchor],
        [self.descTextView.bottomAnchor constraintEqualToAnchor:self.pubDateLabel.topAnchor]
    ]];
    
    self.heightTextViewConstraint =
                           [NSLayoutConstraint constraintWithItem:self.descTextView
                           attribute:NSLayoutAttributeHeight
                           relatedBy:NSLayoutRelationEqual
                           toItem:nil
                           attribute:NSLayoutAttributeNotAnAttribute
                           multiplier:0.f
                           constant:0];
    
    self.heightTextViewConstraint.priority = heightTextViewConstraintPripority;
    [self addConstraint:self.heightTextViewConstraint];
}

- (void)dealloc {
    [_feedLabel release];
    [_pubDateLabel release];
    [_descTextView release];
    [_descriptionButton release];
    [_selectedButtons release];
    [_feedItemConfiguration release];
    [_heightTextViewConstraint release];
    [super dealloc];
}

@end
