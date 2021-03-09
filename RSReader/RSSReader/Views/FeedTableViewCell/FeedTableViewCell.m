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

CGFloat kHeightTextViewConstraintPripority = 999;
CGFloat kAnimationDuration = 0.7;

@interface FeedTableViewCell ()

@property (strong, nonatomic) IBOutlet UIButton *descriptionButton;
@property (strong, nonatomic) IBOutlet UILabel *feedLabel;
@property (strong, nonatomic) IBOutlet UILabel *pubDateLabel;
@property (strong, nonatomic) IBOutlet UITextView *descTextView;
@property (strong, nonatomic) NSLayoutConstraint *heightTextViewConstraint;
@property (copy, nonatomic) void(^didTapHandler)(void);
@property (strong, nonatomic) SelectedButtonsStateModel *selectedButtonsModel;

@end

@implementation FeedTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
        
    [self setDescTextViewLayout];
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

#pragma mark - Button Tap

- (IBAction)didTapAction:(UIButton *)sender {
    
    NSInteger buttonIdentificator = self.descriptionButton.tag;
    BOOL isContained = [self.selectedButtonsModel.selectedButtons containsIndex:buttonIdentificator];
    isContained ? [self.selectedButtonsModel.selectedButtons removeIndex:buttonIdentificator] : [self.selectedButtonsModel.selectedButtons addIndex:buttonIdentificator];
    self.descriptionButton.selected = !isContained;
    isContained = !isContained;
        
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.heightTextViewConstraint.constant = isContained ? self.descTextView.contentSize.height : 0;
        self.descTextView.hidden = !isContained;
        [self.contentView layoutIfNeeded];
    }];
    
    if (self.didTapHandler) {
        self.didTapHandler();
    }
}

#pragma mark - Configure Feed Item

- (void)configureFeedItem:(Feeds *)feed indexPath:(NSIndexPath *)indexPath selectedButtonsInRows:(NSMutableIndexSet *)selectedButtons handler:(void(^)(void)) didTapHandler {
    
    self.didTapHandler = didTapHandler;
    
    self.feedLabel.text = feed.feedsTitle;
    self.pubDateLabel.text = feed.feedsPubDate;
    self.descTextView.text = [NSString getDescriptionsSubstringFromRSSDescription:feed.feedsDescription];
    self.descriptionButton.tag = indexPath.row;
    self.selectedButtonsModel.selectedButtons = selectedButtons;
    
    BOOL isContained = [selectedButtons containsIndex:indexPath.row];
    self.descriptionButton.selected = isContained;
    self.descTextView.hidden = !isContained;
    self.heightTextViewConstraint.constant = isContained ? self.descTextView.contentSize.height : 0;
}

#pragma mark - Layout

- (void)setDescTextViewLayout {
    self.heightTextViewConstraint = [self.descTextView.heightAnchor constraintEqualToConstant:0];
    self.heightTextViewConstraint.priority = kHeightTextViewConstraintPripority;
    self.heightTextViewConstraint.active = YES;
}

@end
