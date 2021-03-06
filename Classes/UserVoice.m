//
//  UserVoice.m
//  UserVoice
//
//  Created by UserVoice on 10/19/09.
//  Copyright 2009 UserVoice Inc. All rights reserved.
//

#import "UserVoice.h"
#import "UVConfig.h"
#import "UVClientConfig.h"
#import "UVWelcomeViewController.h"
#import "UVRootViewController.h"
#import "UVSession.h"
#import "UVNewTicketViewController.h"
#import "UVSuggestionListViewController.h"
#import "UVNavigationController.h"
#import "UVUtils.h"
#import "UVBabayaga.h"
#import "UVClientConfig.h"

@implementation UserVoice

+ (void)initialize:(UVConfig *)config {
    [[UVSession currentSession] clear];
    [UVBabayaga instance].userTraits = [config traits];
    [UVSession currentSession].config = config;
    [UVBabayaga track:VIEW_APP];
    // preload client config so that babayaga can flush
    [UVClientConfig getWithDelegate:self];
}

+ (void)didRetrieveClientConfig:(UVClientConfig *)clientConfig {
    [UVSession currentSession].clientConfig = clientConfig;
}

+ (void)presentUserVoiceControllers:(NSArray *)viewControllers forParentViewController:(UIViewController *)parentViewController {
    [UVBabayaga track:VIEW_CHANNEL];
    [UVSession currentSession].isModal = YES;
    UINavigationController *navigationController = [[[UVNavigationController alloc] init] autorelease];
    [UVUtils applyStylesheetToNavigationController:navigationController];
    navigationController.viewControllers = viewControllers;
    navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    [parentViewController presentModalViewController:navigationController animated:YES];
}

+ (void)presentUserVoiceController:(UIViewController *)viewController forParentViewController:(UIViewController *)parentViewController {
    [self presentUserVoiceControllers:[NSArray arrayWithObject:viewController] forParentViewController:parentViewController];
}

+ (void)presentUserVoiceModalViewControllerForParent:(UIViewController *)parentViewController andSite:(NSString *)site andKey:(NSString *)key andSecret:(NSString *)secret {
    UVConfig *config = [UVConfig configWithSite:site andKey:key andSecret:secret];
    [self presentUserVoiceInterfaceForParentViewController:parentViewController andConfig:config];
}

+ (void)presentUserVoiceModalViewControllerForParent:(UIViewController *)parentViewController andSite:(NSString *)site andKey:(NSString *)key andSecret:(NSString *)secret andSsoToken:(NSString *)token {
    UVConfig *config = [UVConfig configWithSite:site andKey:key andSecret:secret andSSOToken:token];
    [self presentUserVoiceInterfaceForParentViewController:parentViewController andConfig:config];
}

+ (void)presentUserVoiceModalViewControllerForParent:(UIViewController *)parentViewController andSite:(NSString *)site andKey:(NSString *)key andSecret:(NSString *)secret andEmail:(NSString *)email andDisplayName:(NSString *)displayName andGUID:(NSString *)guid {
    UVConfig *config = [UVConfig configWithSite:site andKey:key andSecret:secret andEmail:email andDisplayName:displayName andGUID:guid];
    [self presentUserVoiceInterfaceForParentViewController:parentViewController andConfig:config];
}

+ (void)presentUserVoiceInterfaceForParentViewController:(UIViewController *)parentViewController {
    UIViewController *viewController = [[[UVRootViewController alloc] initWithViewToLoad:@"welcome"] autorelease];
    [self presentUserVoiceController:viewController forParentViewController:parentViewController];
}

+ (void)presentUserVoiceContactUsFormForParentViewController:(UIViewController *)parentViewController {
    UIViewController *viewController = [[[UVRootViewController alloc] initWithViewToLoad:@"new_ticket"] autorelease];
    [self presentUserVoiceController:viewController forParentViewController:parentViewController];
}

+ (void)presentUserVoiceNewIdeaFormForParentViewController:(UIViewController *)parentViewController {
    UIViewController *viewController = [[[UVRootViewController alloc] initWithViewToLoad:@"new_suggestion"] autorelease];
    [self presentUserVoiceController:viewController forParentViewController:parentViewController];
}

+ (void)presentUserVoiceForumForParentViewController:(UIViewController *)parentViewController {
    UIViewController *viewController = [[[UVRootViewController alloc] initWithViewToLoad:@"suggestions"] autorelease];
    [self presentUserVoiceController:viewController forParentViewController:parentViewController];
}

+ (void)presentUserVoiceInterfaceForParentViewController:(UIViewController *)parentViewController andConfig:(UVConfig *)config {
    [self initialize:config];
    [self presentUserVoiceInterfaceForParentViewController:parentViewController];
}

+ (void)presentUserVoiceContactUsFormForParentViewController:(UIViewController *)parentViewController andConfig:(UVConfig *)config {
    [self initialize:config];
    [self presentUserVoiceContactUsFormForParentViewController:parentViewController];
}

+ (void)presentUserVoiceNewIdeaFormForParentViewController:(UIViewController *)parentViewController andConfig:(UVConfig *)config {
    [self initialize:config];
    [self presentUserVoiceNewIdeaFormForParentViewController:parentViewController];
}

+ (void)presentUserVoiceForumForParentViewController:(UIViewController *)parentViewController andConfig:(UVConfig *)config {
    [self initialize:config];
    [self presentUserVoiceForumForParentViewController:parentViewController];
}

+ (void)setExternalId:(NSString *)identifier forScope:(NSString *)scope {
    [[UVSession currentSession] setExternalId:identifier forScope:scope];
}

+ (void)track:(NSString *)event properties:(NSDictionary *)properties {
    [UVBabayaga track:event props:properties];
}

+ (void)track:(NSString *)event {
    [UVBabayaga track:event];
}

static id<UVDelegate> userVoiceDelegate;
+ (void)setDelegate:(id<UVDelegate>)delegate {
    userVoiceDelegate = delegate;
}

+ (id<UVDelegate>)delegate {
    return userVoiceDelegate;
}

+ (NSString *)version {
    return @"2.0.13";
}


@end
