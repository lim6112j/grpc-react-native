//
//  CielClient.m
//  RNGrpcApp
//
//  Created by byeong cheol lim on 2023/02/22.
//

#import <Foundation/Foundation.h>
#import "React/RCTBridgeModule.h"
@interface RCT_EXTERN_MODULE(CielClient, NSObject)
  RCT_EXTERN_METHOD(init)
  RCT_EXTERN_METHOD(
    getUserState: (NSString *) str
    resolve: (RCTPromiseResolveBlock) resolve
    rejecter: (RCTPromiseRejectBlock) reject
  )
@end
