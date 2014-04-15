//
//  OptionsLayer.h
//  RPS
//
//  Created by chibitotoro on 12-03-08.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <GameKit/GameKit.h>
#import "cocos2d.h"

@interface OptionsLayer : CCLayer{
    
    CCSprite * sprBackground;
    CCSprite * sprHeader;
    
    CCLabelTTF * lblSFX;
    CCLabelTTF * lblMusic;
    
    
    CCMenuItemImage * itmReturn;
    CCMenuItemImage * itmMusicOn;
    CCMenuItemImage * itmMusicOff;
    CCMenuItemImage * itmSFXOn;
    CCMenuItemImage * itmSFXOff;
    CCMenu * menu;
}
+(CCScene *) scene;
@end
