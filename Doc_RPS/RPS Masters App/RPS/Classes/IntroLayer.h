//
//  IntroLayer.h
//  RPS
//
//  Created by chibitotoro on 12-03-08.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <GameKit/GameKit.h>
#import "cocos2d.h"

@interface IntroLayer : CCLayer{
    
    bool transitioning;
}



+(CCScene *) scene;
@end
