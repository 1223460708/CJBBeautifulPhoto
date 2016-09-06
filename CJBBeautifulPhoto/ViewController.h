//
//  ViewController.h
//  CJBBeautifulPhoto
//
//  Created by 炳神 on 16/8/30.
//  Copyright © 2016年 as2482199. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    GPUIMAGE_saturation, //饱和度
    GPUIMAGE_GAUSSIAN_POSITION,  // 高斯
    GPUIMAGE_PERLINNOISE, // 发亮  大理石纹
    GPUIMAGE_BILATERAL, // 双边
    GPUIMAGE_exposure, // 曝光
    GPUIMAGE_RGB, // RGB
    GPUIMAGE_mosaic, // 马赛克
    GPUIMAGE_whitebalance, // 白平衡
    GPUIMAGE_monochrome,  // 黑白
    GPUIMAGE_falsecolor,  // 假色
    GPUIMAGE_sharpen,  //  削尖
    GPUIMAGE_unsharpmask,  // 锐化
    GPUIMAGE_transform,  // 转变
    GPUIMAGE_transform3D,  // 3D转变
    GPUIMAGE_crop,  //  裁剪
    GPUIMAGE_BULGE,  //  膨胀
    GPUIMAGE_LOWPASS,  // 低通
    GPUIMAGE_tonecurve, // 色调曲线
    GPUIMAGE_highlightshadow, // 阴影高亮
    GPUIMAGE_haze, // 模糊
} GPUImageShowFilterType;


@interface ViewController : UIViewController




@end

