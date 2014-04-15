//
//  HowToPlayLayer.h
//  RPS
//
//  Created by chibitotoro on 12-04-25.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HowToPlayLayer : CCLayer {
    CCSprite * sprBackground;
    
    CCSprite * sprHeader;
    CCLabelTTF * lblTotalPages;
    CCLabelTTF * lblCurrentPage;
    
    NSMutableArray * pages;
    
    
    CCMenuItemImage * itmReturn;
    CCMenuItemImage * itmPrev;
    CCMenuItemImage * itmNext;
    
    CCMenu * menu;
    
    
    int currentPage;
    
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;
-(void) showPage:(int) number;

@end