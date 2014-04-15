//
//  Stage.m
//  RPS
//
//  Created by chibitotoro on 12-04-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Stage.h"
#import "AppDelegate.h"
@implementation Stage

@synthesize sprBackground,sprKOBox,sprLeftLifeContainer,sprRightLifeContainer;
@synthesize sprLeftDPContainer,sprRightDPContainer,sprLeftLife,sprRightLife;
@synthesize sprLeftAvatar,sprRightAvatar;

-(id)init{
    
    if((self=[super init])){
        sprBackground=nil;
        bgMusic=nil;
        
        //life containers
        sprLeftLifeContainer=[[CCSprite spriteWithFile: @"left-life-container.png"] retain];
        sprLeftLifeContainer.position=ccp(136,296);
        
        sprRightLifeContainer=[[CCSprite spriteWithFile: @"right-life-container.png"] retain];
        sprRightLifeContainer.position=ccp(344,296);
        
        sprLeftLife=[[CCSprite spriteWithFile:@"left-life.png"] retain];
        sprLeftLife.position=ccp(204,296);
        
        sprRightLife=[[CCSprite spriteWithFile:@"right-life.png"] retain];
        sprRightLife.position=ccp(276,296);
        
        //KO Box
        
        sprKOBox=[[CCSprite spriteWithFile: @"kobox.png"] retain];
        sprKOBox.position=ccp(240,296);
        
        //display pictures
        sprLeftDPContainer=[[CCSprite spriteWithFile:@"frame.png"]retain];
        sprLeftDPContainer.position=ccp(33,287);
        
        sprRightDPContainer=[[CCSprite spriteWithFile:@"frame.png"] retain];
        sprRightDPContainer.position=ccp(447,287);
        
    }
    return self;
}

-(void) pause{
    
}
-(void) resume{
    
}
-(void) playBGM{
    AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];
    if(ad.playingBGM&&bgMusic!=nil){
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:bgMusic];
    }
}

-(void) dealloc{

    if(bgMusic!=nil) [bgMusic release];
        
    [sprLeftLife release];
    [sprRightLife release];
    
    [sprBackground release];
    
    [sprLeftLifeContainer release];
    [sprRightLifeContainer release];
    [sprKOBox release];
    
    [sprLeftDPContainer release];
    [sprRightDPContainer release];
    
    [sprLeftAvatar release];
    [sprRightAvatar release];
     
    [super dealloc];
}
@end
