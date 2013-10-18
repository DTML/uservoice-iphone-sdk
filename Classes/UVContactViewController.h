//
//  UVContactViewController.h
//  UserVoice
//
//  Created by Austin Taylor on 10/18/13.
//  Copyright (c) 2013 UserVoice Inc. All rights reserved.
//

#import "UVBaseViewController.h"
#import "UVInstantAnswerManager.h"

@interface UVContactViewController : UVBaseViewController<UVInstantAnswersDelegate,UITextViewDelegate>

@property (nonatomic,retain) UVInstantAnswerManager *instantAnswerManager;

@end
