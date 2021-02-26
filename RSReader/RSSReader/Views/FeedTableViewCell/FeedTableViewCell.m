//
//  FeedTableViewCell.m
//  RSSReader
//
//  Created by Eduard Ivash on 18.11.20.
//

#import "FeedTableViewCell.h"
#import "Feeds.h"
#import "FeedListVC.h"
#import "SelectedButtonsStateModel.h"
#import "NSString+GetSubstringFromDescription.h"

NSString *const kSelectedImageName = @"buttonActive";
NSString *const kDisabledImageName = @"buttonDisabled";
CGFloat kHeightTextViewConstraintPripority = 999;

@interface FeedTableViewCell ()

@property (retain, nonatomic) IBOutlet UIButton *descriptionButton;
@property (retain, nonatomic) IBOutlet UILabel *feedLabel;
@property (retain, nonatomic) IBOutlet UILabel *pubDateLabel;
@property (retain, nonatomic) IBOutlet UITextView *descTextView;
@property (retain, nonatomic) NSLayoutConstraint *heightTextViewConstraint;
@property (copy, nonatomic) void(^feedItemConfiguration)(void);
@property (retain, nonatomic) SelectedButtonsStateModel *selectedButtonsModel;

@end

@implementation FeedTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
        
    [self setDescTextViewLayout];
    [self.descriptionButton addTarget:self action:@selector(didTapButton) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Getters

- (SelectedButtonsStateModel *)selectedButtonsModel {
    if (!_selectedButtonsModel) {
        _selectedButtonsModel = [SelectedButtonsStateModel new];
    }
    return _selectedButtonsModel;
}

- (UIButton *)descriptionButton {
    if (!_descriptionButton) {
        _descriptionButton = [[UIButton alloc] init];
    }
    return _descriptionButton;
}

- (void (^)(void))feedItemConfiguration {
    return _feedItemConfiguration;
}

#pragma mark - Button Tap

- (void)didTapButton {
    
    NSIndexPath *buttonIdentificator = [NSIndexPath indexPathWithIndex:self.descriptionButton.tag];
    BOOL isContained = [self.selectedButtonsModel.selectedButtons containsObject:buttonIdentificator];
    isContained ? [self.selectedButtonsModel.selectedButtons removeObject:buttonIdentificator] : [self.selectedButtonsModel.selectedButtons addObject:buttonIdentificator];
    isContained = !isContained;
    
    UIImage *img = isContained ? [UIImage imageNamed:kSelectedImageName] : [UIImage imageNamed:kDisabledImageName];
    [self.descriptionButton setImage:img forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.7 animations:^{
        isContained ? [self.heightTextViewConstraint setConstant:self.descTextView.contentSize.height]  : [self.heightTextViewConstraint setConstant:0];
        [self.descTextView setHidden:!isContained];
        [self.contentView layoutIfNeeded];
    }];
    
    self.feedItemConfiguration();
}

#pragma mark - Configure Feed Item

- (void)configureFeedItem:(Feeds *)feed indP:(NSIndexPath *)indexPath selectedButtonsInRows:(NSMutableArray *)selectedButtons completion:(void(^)(void)) feedItemConfiguration {
    
    self.feedItemConfiguration = feedItemConfiguration;
    
    self.feedLabel.text = feed.feedsTitle;
    self.pubDateLabel.text = feed.feedsPubDate;
    self.descTextView.text = [NSString getDescriptionsSubstringFromRSSDescription:feed.feedsDescription];
    self.descriptionButton.tag = indexPath.row;
    self.selectedButtonsModel.selectedButtons = selectedButtons;
    
    BOOL isContained = [selectedButtons containsObject:indexPath];
    UIImage *image = isContained ? [UIImage imageNamed:kSelectedImageName] : [UIImage imageNamed:kDisabledImageName];
    [self.descriptionButton setImage:image forState:UIControlStateNormal];
    [self.descTextView setHidden:!isContained];
    isContained ? [self.heightTextViewConstraint setConstant:self.descTextView.contentSize.height]  : [self.heightTextViewConstraint setConstant:0];
}

#pragma mark - Layout

- (void)setDescTextViewLayout {
    self.heightTextViewConstraint =
                           [NSLayoutConstraint constraintWithItem:self.descTextView
                           attribute:NSLayoutAttributeHeight
                           relatedBy:NSLayoutRelationEqual
                           toItem:nil
                           attribute:NSLayoutAttributeHeight
                           multiplier:0.f
                           constant:0];
    
    self.heightTextViewConstraint.priority = kHeightTextViewConstraintPripority;
    self.heightTextViewConstraint.active = YES;
}

- (void)dealloc {
    [_feedLabel release];
    [_pubDateLabel release];
    [_descTextView release];
    [_descriptionButton release];
    [_selectedButtonsModel release];
    [_feedItemConfiguration release];
    [_heightTextViewConstraint release];
    [_selectedButtonsModel release];
    [super dealloc];
}

@end
