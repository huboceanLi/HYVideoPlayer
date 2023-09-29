//
//  HYVideoPlayView.h
//  HYMedia
//
//  Created by oceanMAC on 2023/9/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYVideoPlayView : UIView


- (instancetype)initWithFrame:(CGRect)frame playUrl:(NSString *)playUrl startPosition:(NSTimeInterval)startPosition;

@property (nonatomic, copy) NSString *playUrl;
@property (nonatomic, strong) UIColor *bGColor;
@property (nonatomic, assign) NSTimeInterval currentPosition;

- (void)removeView;

- (void)pause;

- (void)startPlay;


@end

NS_ASSUME_NONNULL_END
