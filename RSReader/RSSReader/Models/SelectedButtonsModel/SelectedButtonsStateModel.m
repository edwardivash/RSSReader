//
//  SelectedButtonsStateModel.m
//  RSSReader
//
//  Created by Eduard Ivash on 22.02.21.
//

#import "SelectedButtonsStateModel.h"

@implementation SelectedButtonsStateModel

- (NSMutableArray *)selectedButtons {
    if (!_selectedButtons) {
        _selectedButtons = [[NSMutableArray alloc] init];
    }
    return _selectedButtons;
}

- (void)dealloc
{
    [_selectedButtons release];
    [super dealloc];
}

@end
