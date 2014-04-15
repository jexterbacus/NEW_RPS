//
//  RestaurantStage.m
//  RPS
//
//  Created by chibitotoro on 12-04-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Restaurant.h"

@implementation Restaurant
@synthesize fan,fanSpriteSheet;
@synthesize chef,pan,waitress;
-(id)init{
    if((self=[super init])){
        
        sprBackground=[[CCSprite spriteWithFile: @"restaurant.png"] retain];
        sprBackground.position=ccp(240,160);
        bgMusic=@"Restaurant.mp3";
        
        CCDirector *director = [CCDirector sharedDirector];

        NSMutableArray *fanAnimFrames = [NSMutableArray array];        //fan animation frames
        NSString * suffix=@"";
        if([director enableRetinaDisplay:YES] ){
            suffix=@"-hd";
        }
        

        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"fan%@.plist",suffix]];
        
        fanSpriteSheet = [CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"fan%@.png",suffix]];
        
        
        for(int i = 1; i <= 3; ++i) {
            [fanAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"rest-fan%d%@.png", i,suffix]]];
        }
        
        fan=[[CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"rest-fan1%@.png",suffix]] retain];
        
        
        //non retina info
        fan.position=ccp(240,294);
        fanAnimation = [[CCAnimation 
                         animationWithFrames:fanAnimFrames delay:1.f/4.f] retain];
        
        fanSpinAction=[[CCRepeatForever actionWithAction:
            [CCAnimate actionWithAnimation:fanAnimation restoreOriginalFrame:NO]]retain];
        [fan runAction:fanSpinAction];
        [fanSpriteSheet addChild:fan];
        
        chef=[[Chef alloc]init];
        chef.sprCharacter.position=ccp(215,153);

        pan=[[Pan alloc]init];
        pan.sprCharacter.position=ccp(180,140);
        
        waitress=[[Waitress alloc]init];
        waitress.sprCharacter.position=ccp(234,84);
        
    }
    
    return self;
}

-(void) pause{
    [super pause];
    //[[ActionManager sharedManager] pauseAllActionsForTarget:fan];

}
-(void) resume{
    [super resume];
    
}

-(void) dealloc{
[pan release];
    [waitress release];
    [chef release];
    [fan release];
    [fanSpinAction release];
    [fanAnimation release];
    [super dealloc];
}

@end
