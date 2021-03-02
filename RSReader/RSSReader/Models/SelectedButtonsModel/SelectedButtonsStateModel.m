//
//  SelectedButtonsStateModel.m
//  RSSReader
//
//  Created by Eduard Ivash on 22.02.21.
//

#import "SelectedButtonsStateModel.h"

@implementation SelectedButtonsStateModel

- (NSMutableIndexSet *)selectedButtons {
    if (!_selectedButtons) {
        _selectedButtons = [[NSMutableIndexSet alloc] init];
    }
    return _selectedButtons;
}

- (void)dealloc
{
    [_selectedButtons release];
    [super dealloc];
}

@end
