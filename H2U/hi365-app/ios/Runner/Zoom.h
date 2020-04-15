//
//  zoom.h
//  Runner
//
//  Created by ZaneChen_陳震陽 on 2019/8/20.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MobileRTC/MobileRTC.h>

NS_ASSUME_NONNULL_BEGIN

@interface Zoom : UIResponder <UIApplicationDelegate, MobileRTCAuthDelegate>
- (void) joinMeeting: (NSString*) meetingNo;
@end

NS_ASSUME_NONNULL_END
