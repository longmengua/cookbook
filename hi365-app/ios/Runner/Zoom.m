//
//  zoom.m
//  Runner
//
//  Created by ZaneChen_陳震陽 on 2019/8/20.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "Zoom.h"

#define kSDKAppKey      @"7xUAeamAMozVHqj2ekhRwwGfnkppA4XnlrTB"
#define kSDKAppSecret   @"u8KDZ7Mxu6oSvuBTvzjxys49143ybnfRz9aP"
#define kSDKDomain      @"zoom.us"
#define kSDKUserName    @"Superman" // TODO: Obrain from user info

@implementation Zoom

- (instancetype) init {
    if (self = [super init]) {
        // Set SDK Domain
        [[MobileRTC sharedRTC] setMobileRTCDomain:kSDKDomain];
        // Get Auth Service
        MobileRTCAuthService *authService = [[MobileRTC sharedRTC] getAuthService];
        NSLog(@"MobileRTC Version: %@", [[MobileRTC sharedRTC] mobileRTCVersion]);
        if (authService) {
            // Setup Auth Service
            authService.clientKey       = kSDKAppKey;
            authService.clientSecret    = kSDKAppSecret;
            // Call authentication function to initialize SDK
            [authService sdkAuth];
        }
        return self;
    }
    return nil;
}

- (void) onMobileRTCAuthReturn: (MobileRTCAuthError) returnValue {
    NSLog(@"onMobileRTCAuthReturn %d", returnValue);
    if (returnValue != MobileRTCAuthError_Success) {
        NSString *message = [NSString stringWithFormat:NSLocalizedString(@"SDK authentication failed, error code: %zd", @""), returnValue];
        NSLog(@"%@", message);
    }
}

- (void) joinMeeting: (NSString*) meetingNo {
    if(![meetingNo length]) {
        NSLog(@"Please enter a meeting number");
        return;
    } else {
        NSLog(@"meetingNO: %@", meetingNo);
        MobileRTCMeetingService *service = [[MobileRTC sharedRTC] getMeetingService];
        
        if (service) {
            // initialize a parameter dictionary to store parameters.
            NSDictionary *paramDict = @{
                kMeetingParam_Username: kSDKUserName,
                kMeetingParam_MeetingNumber:meetingNo
            };
            MobileRTCMeetError response = [service joinMeetingWithDictionary:paramDict];
            NSLog(@"onJoinMeeting, response: %d", response);
        }
    }
}

@end
