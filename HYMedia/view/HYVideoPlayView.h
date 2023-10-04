//
//  HYVideoPlayView.h
//  HYMedia
//
//  Created by oceanMAC on 2023/9/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@class HYVideoPlayView;

@protocol HYVideoPlayViewDelegate <NSObject>

@optional

- (void)currentTime:(NSInteger)currentTime;

@end

@interface HYVideoPlayView : UIView


@property (nonatomic, weak) id <HYVideoPlayViewDelegate> delegate;

@property (nonatomic, copy) NSString *playUrl;
@property (nonatomic, strong) UIColor *bGColor;
@property (nonatomic, assign) NSTimeInterval currentPosition;

- (void)startPlayUrl:(NSString *)playUrl startPosition:(NSTimeInterval)startPosition;

- (void)removeView;

- (void)pause;

- (void)startPlay;

- (NSTimeInterval)getDuration;


@end

NS_ASSUME_NONNULL_END
