//
//  ViewController.m
//  CJBBeautifulPhoto
//
//  Created by 炳神 on 16/8/30.
//  Copyright © 2016年 as2482199. All rights reserved.
//

#import "ViewController.h"
#import <GPUImage/GPUImage.h>
#import <AVFoundation/AVFoundation.h>
#import "CJBKindCollectionViewCell.h"
#import "CJBShowImageVC.h"
#define MainWidth self.view.frame.size.width
#define MainHright self.view.frame.size.height
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning>


@property (weak, nonatomic) IBOutlet UIImageView *photoView;


@property (nonatomic,strong)GPUImageVideoCamera *videoCamera;

@property (nonatomic,strong)GPUImageView *filterView;

@property (nonatomic,strong)GPUImageOutput<GPUImageInput> *filter; //各种滤镜的的对象

@property (nonatomic,strong)GPUImageHSBFilter *hsbFilter;

@property (nonatomic,strong)UICollectionView *collectionView;

@property (nonatomic,strong)UICollectionViewFlowLayout *flowlayout;

@property (nonatomic,strong)GPUImageStillCamera *stillCamera;

@property (nonatomic,strong)NSArray *filterArray;

@property (nonatomic,strong)UIView *showImage_View;

@property (nonatomic,assign)BOOL isPresnent;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.filterArray = @[@"饱和度",@"高斯",@"大理石纹",@"双边",@"曝光",@"RGB",@"马赛克",@"白平衡",@"黑白",@"假色",@"削尖",@"锐化",@"转变",@"3D转变",@"裁剪",@"膨胀",@"低通",@"色调曲线",@"阴影高亮",@"模糊"];

    /**指定滤镜  处理静态图像
     
    UIImage *inputImage = [UIImage imageNamed:@"5683e4908b168_1024.jpg"];
    
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:inputImage];
    GPUImageSepiaFilter *stillImageFilter = [[GPUImageSepiaFilter alloc] init];
    
    [stillImageSource addTarget:stillImageFilter];
    [stillImageFilter useNextFrameForImageCapture];
    [stillImageSource processImage];
    
    UIImage *currentFilteredVideoFrame = [stillImageFilter imageFromCurrentFramebuffer];
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:self.view.frame];
    
    imageview.image = currentFilteredVideoFrame;
    
    [self.view addSubview:imageview];
     
     */
    
    
   
    
    /**
      //  创建照相机  但不能拍照  相当于给视频添加滤镜 - /
    self.videoCamera = [[GPUImageVideoCamera alloc]initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionBack];

    //- 图像上下左右变化 -/
    self.videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    
    self.videoCamera.horizontallyMirrorFrontFacingCamera = YES;

    //-  调节 色调 - 饱和度- 亮度  /
    GPUImageHSBFilter  *hsbFilter = [[GPUImageHSBFilter alloc] init];
    [hsbFilter adjustBrightness:1.5];  // - 亮度 范围 0~2 - /
    [hsbFilter adjustSaturation:0.5];  // - 饱和度 范围 0~2 - /
    
    [self.videoCamera addTarget:hsbFilter];
   
    self.filterView = [[GPUImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 450)];
    
    self.filterView.center = self.view.center;
    
    [self.view addSubview:self.filterView];
    
    [hsbFilter addTarget:self.filterView];
    
    [self.videoCamera startCameraCapture];
    
    */
    
    
    
   
   /**   混合颜色  注 ： 还没研究出来
    
     GPUImageFilter *customFilter = [[GPUImageFilter alloc] initWithFragmentShaderFromString:@"CustomShader"];

     [self.videoCamera addTarget:customFilter];
     
     [customFilter addTarget:self.filterView];
    */

    
    
    
    
    
    /** 截取静态图像并添加滤镜 相机 */
    /* 步骤 : 1.先创建相机(GPUImageStillCamera 这只是其中一个 还有例如:GPUImageVideoCamera 这个只是给视频渲染滤镜，不能拍照)  和 GPUImageView(可视视图)
             2. 创建某种滤镜
             3. 把滤镜加载到相机上
             4. 再把 创建好的GPUImageView放在滤镜上
             5. 开启相机 (调用执行这句代码 startCameraCapture)
     */
//    self.stillCamera = [[GPUImageStillCamera alloc] initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionBack];
//    
//    self.stillCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
//    
//    //滤镜的一种
//    self.filter = [[GPUImageHSBFilter alloc] init];
//    [(GPUImageHSBFilter*)self.filter adjustBrightness:1.5];  /** 亮度 范围 0~2 */
//    [(GPUImageHSBFilter*)self.filter adjustSaturation:0.5];  /** 饱和度 范围 0~2 */
//    
////    self.filter = [[GPUImageGammaFilter alloc] init];  //可以创建不同的滤镜
//    
////    self.filter = [[GPUImageSepiaFilter alloc]init];  //可以创建不同的滤镜
//    
//    [self.stillCamera addTarget:self.filter];
//    
//    self.filterView = [[GPUImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 100)];
//    
//    [self.view addSubview:self.filterView];
//    
//    [self.filter addTarget:self.filterView];
//    
//    [self.stillCamera startCameraCapture];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showImageViewVc:)];
    
    self.photoView.userInteractionEnabled = YES;
    
    [self.photoView addGestureRecognizer:tap];
    
    self.photoView.backgroundColor = [UIColor blackColor];
    
    [self createdGPUImageCamera:NO];
    
}

/** 点击图片自定义转场动画 */
-(void)showImageViewVc:(UIGestureRecognizer *)ges {
    
    CJBShowImageVC *showImage = [CJBShowImageVC new];
    
    showImage.transitioningDelegate = self;
    
    showImage.modalPresentationStyle = UIModalPresentationCustom;
    
    showImage.imageB = self.photoView.image;
    
    [self presentViewController:showImage animated:YES completion:nil];
    
}

//设置控制器大小
-(UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    UIPresentationController *present = [[UIPresentationController alloc]initWithPresentedViewController:presented presentingViewController:presenting];
    
    present.presentedView.frame = self.view.bounds;
    
    return present;
}

//自定义弹出动画
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    self.isPresnent = YES;
    return self;
}

//自定义消失动画
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.isPresnent = NO;
    return self;
}

//动画执行时间
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}


//获取转场的上下文,可以通过转场上下文可以获取到弹出的View和消失的View
//UITransitionContextFromViewKey : 获取消失的View
//UITransitionContextToViewKey : 获取弹出的View
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
    if(self.isPresnent)
    {
        UIView *presentView = [transitionContext viewForKey:UITransitionContextToViewKey];
        
        [transitionContext.containerView addSubview:presentView];
        
        presentView.transform = CGAffineTransformMakeScale(0.0, 0.0);
        presentView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            
            presentView.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            
            //告诉系统已经完成动画
            [transitionContext completeTransition:YES];
            
        }];
        
    }
    else {
        
        UIView *dismissView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            
            dismissView.transform = CGAffineTransformMakeScale(0.00001, 0.00001);
            
        } completion:^(BOOL finished) {
            
            [dismissView removeFromSuperview];
            
            [transitionContext completeTransition:YES];
            
        }];
        
    }
    
}


-(void)createdGPUImageCamera:(BOOL)isFanZhuan {
    
    /** 截取静态图像并添加滤镜 相机 */
    /* 步骤 : 1.先创建相机(GPUImageStillCamera 这只是其中一个 还有例如:GPUImageVideoCamera 这个只是给视频渲染滤镜，不能拍照)  和 GPUImageView(可视视图)
     2. 创建某种滤镜
     3. 把滤镜加载到相机上
     4. 再把 创建好的GPUImageView放在滤镜上
     5. 开启相机 (调用执行这句代码 startCameraCapture)
     */
    
    if (!isFanZhuan) {
        
        if(self.stillCamera != nil) {
            
            [self.filterView removeFromSuperview];
            [self.filter removeAllTargets];
            [self.stillCamera removeAllTargets];
            
        }
            
            self.stillCamera = [[GPUImageStillCamera alloc] initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionFront];
            
            self.stillCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
            self.stillCamera.horizontallyMirrorFrontFacingCamera = YES;
            
            //滤镜的一种
            self.filter = [[GPUImageHSBFilter alloc] init];
            [(GPUImageHSBFilter*)self.filter adjustBrightness:1.5];  /** 亮度 范围 0~2 */
            [(GPUImageHSBFilter*)self.filter adjustSaturation:0.5];  /** 饱和度 范围 0~2 */
            
            //    self.filter = [[GPUImageGammaFilter alloc] init];  //可以创建不同的滤镜
            
            //    self.filter = [[GPUImageSepiaFilter alloc]init];  //可以创建不同的滤镜
            
            [self.stillCamera addTarget:self.filter];
            
            self.filterView = [[GPUImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 100)];
            
            [self.view addSubview:self.filterView];
            
            [self.filter addTarget:self.filterView];
            
            [self.stillCamera startCameraCapture];

    }else {
        
        
        if(self.stillCamera != nil) {
            
            [self.filterView removeFromSuperview];
            [self.filter removeAllTargets];
            [self.stillCamera removeAllTargets];
            
            
        }
            
            self.stillCamera = [[GPUImageStillCamera alloc] initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionBack];
            
            self.stillCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
            self.stillCamera.horizontallyMirrorFrontFacingCamera = YES;
            //滤镜的一种
            self.filter = [[GPUImageHSBFilter alloc] init];
            [(GPUImageHSBFilter*)self.filter adjustBrightness:1.5];  /** 亮度 范围 0~2 */
            [(GPUImageHSBFilter*)self.filter adjustSaturation:0.5];  /** 饱和度 范围 0~2 */
            
            //    self.filter = [[GPUImageGammaFilter alloc] init];  //可以创建不同的滤镜
            
            //    self.filter = [[GPUImageSepiaFilter alloc]init];  //可以创建不同的滤镜
            
            [self.stillCamera addTarget:self.filter];
            
            self.filterView = [[GPUImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 100)];
            
            [self.view addSubview:self.filterView];
            
            [self.filter addTarget:self.filterView];
            
            [self.stillCamera startCameraCapture];
        
        
    }
    

}


/** 摄像头翻转 */
- (IBAction)cameraFanZhuan:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    [self createdGPUImageCamera:sender.selected];
    
}


/** 拍照事件 */
- (IBAction)camrePhoto:(id)sender {
    
    [self.stillCamera capturePhotoAsImageProcessedUpToFilter:self.filter withCompletionHandler:^(UIImage *processedImage, NSError *error) {
        
        NSData *dataForJPEGFile = UIImageJPEGRepresentation(processedImage, 0.8);
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        NSLog(@"%@",documentsDirectory);
        
        NSError *error2 = nil;
        
        
       [self saveImageToPhoto:processedImage];
        processedImage = nil ;
        if (![dataForJPEGFile writeToFile:[documentsDirectory stringByAppendingPathComponent:@"FilteredPhoto.jpg"] options:NSAtomicWrite error:&error2])
        {
            return ;
        }

    }];
    
}

/** 弹出滤镜view */
- (IBAction)populerCollectinView:(id)sender {
    
    [self createrfCollectionVoew];

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.collectionView removeFromSuperview];
}

/** 保存图片到相册 */
-(void)saveImageToPhoto:(UIImage*)image {
    
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    
}

- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo {
    
    NSString *msg = nil ;
    
    if(error != NULL){
        
        msg = @"保存图片失败" ;
        
    }else{
        
        msg = @"保存图片成功" ;

        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            UIImage *image1 = image;
            
            image1 = [self clipImage:image toSize:self.photoView.frame.size];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                 self.photoView.image = image;
                
                
            });
            
        });
        
        
    }
    
}



#pragma 创建collectionView
-(void)createrfCollectionVoew {
    
    self.flowlayout = [[UICollectionViewFlowLayout alloc]init];
    self.flowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.flowlayout.itemSize = CGSizeMake(85, 85);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, MainHright - 100, MainWidth, 90) collectionViewLayout:self.flowlayout];
    self.collectionView.showsHorizontalScrollIndicator = YES;
    self.collectionView.alwaysBounceHorizontal = YES;
    [self.collectionView registerNib:[UINib nibWithNibName:@"CJBKindCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.view addSubview:self.collectionView];
    
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.filterArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CJBKindCollectionViewCell *kind = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    kind.backgroundColor = [UIColor redColor];
    
    kind.label.text = self.filterArray[indexPath.item];
    
    return kind;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self selectorFilter:(GPUImageShowFilterType)indexPath.row];
}

/** 裁剪图片到合适大小 */
- (UIImage *)clipImage:(UIImage *)image toSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, YES, [UIScreen mainScreen].scale);
    
    CGSize imgSize = image.size;
    CGFloat x = MAX(size.width / imgSize.width, size.height / imgSize.height);
    CGSize resultSize = CGSizeMake(x* imgSize.width, x* imgSize.height);
    
    [image drawInRect:CGRectMake(0, 0, resultSize.width, resultSize.height)];
    
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return finalImage;
}



/** 滤镜的样式 在GPUImage框架中有很多，我就选择了其中20中  */
-(void)selectorFilter:(GPUImageShowFilterType)type {
    
    switch (type) {
        case GPUIMAGE_saturation:
        {
            [self.stillCamera removeAllTargets];
            
            [self.stillCamera resetBenchmarkAverage];
            
            self.filter = [[GPUImageSepiaFilter alloc]init];
            
            [self.stillCamera addTarget:self.filter];
            
            [self.filter addTarget:self.filterView];
        }
            break;
        case GPUIMAGE_GAUSSIAN_POSITION:
        {
            [self.stillCamera removeAllTargets];
            
            self.filter = [[GPUImageGaussianBlurPositionFilter alloc] init];
            
            [(GPUImageGaussianBlurPositionFilter*)self.filter setBlurRadius:40.0/320.0];
            
            [(GPUImageGaussianBlurPositionFilter *)self.filter setBlurRadius:0.4];
            
            [self.stillCamera addTarget:self.filter];
            
            [self.filter addTarget:self.filterView];
        }
            break;
        case GPUIMAGE_PERLINNOISE:
        {
            [self.stillCamera removeAllTargets];
            
            self.filter = [[GPUImagePerlinNoiseFilter alloc] init];
            
            [(GPUImagePerlinNoiseFilter *)self.filter setScale:0.4];
            
            [self.stillCamera addTarget:self.filter];
            
            [self.filter addTarget:self.filterView];
        }
            break;
        case GPUIMAGE_BILATERAL:
        {
            [self.stillCamera removeAllTargets];
            
            self.filter = [[GPUImageBilateralFilter alloc] init];
            
            [(GPUImageBilateralFilter *)self.filter setDistanceNormalizationFactor:0.6];
            
            [self.stillCamera addTarget:self.filter];
            
            [self.filter addTarget:self.filterView];
        }
            break;
        case GPUIMAGE_exposure:
        {
            [self.stillCamera removeAllTargets];
            
            self.filter = [[GPUImageExposureFilter alloc] init];
            
            [(GPUImageExposureFilter *)self.filter setExposure:0.6];
            
            [self.stillCamera addTarget:self.filter];
            
            [self.filter addTarget:self.filterView];
        }
            break;
        case GPUIMAGE_RGB:
        {
            [self.stillCamera removeAllTargets];
            
            self.filter = [[GPUImageRGBFilter alloc] init];
            
            [(GPUImageRGBFilter *)self.filter setGreen:0.6];
            
            [self.stillCamera addTarget:self.filter];
            
            [self.filter addTarget:self.filterView];
        }
            break;
        case GPUIMAGE_mosaic:
        {
            [self.stillCamera removeAllTargets];
            
            self.filter = [[GPUImageMosaicFilter alloc] init];
            [(GPUImageMosaicFilter *)self.filter setTileSet:@"squares.png"];
            [(GPUImageMosaicFilter *)self.filter setColorOn:NO];
            
            [(GPUImageMosaicFilter *)self.filter setDisplayTileSize:CGSizeMake(0.2, 0.1)];

            
            [self.stillCamera addTarget:self.filter];
            
            [self.filter addTarget:self.filterView];
        }
            break;
        case GPUIMAGE_whitebalance:
        {
            [self.stillCamera removeAllTargets];
            
            self.filter = [[GPUImageWhiteBalanceFilter alloc] init];
            
            [(GPUImageWhiteBalanceFilter *)self.filter setTemperature:0.6];
            
            [self.stillCamera addTarget:self.filter];
            
            [self.filter addTarget:self.filterView];
        }
            break;
        case GPUIMAGE_monochrome:
        {
            [self.stillCamera removeAllTargets];
            
            self.filter = [[GPUImageMonochromeFilter alloc] init];
            [(GPUImageMonochromeFilter *)self.filter setColor:(GPUVector4){0.0f, 0.0f, 1.0f, 1.f}];
            [(GPUImageMonochromeFilter *)self.filter setIntensity:0.2];
            
            
            [self.stillCamera addTarget:self.filter];
            
            [self.filter addTarget:self.filterView];
        }
            break;
        case GPUIMAGE_falsecolor:
        {
            [self.stillCamera removeAllTargets];
            
            self.filter = [[GPUImageFalseColorFilter alloc] init];
            
            [self.stillCamera addTarget:self.filter];
            
            [self.filter addTarget:self.filterView];
        }
            break;
        case GPUIMAGE_sharpen:
        {
            [self.stillCamera removeAllTargets];
            
            self.filter = [[GPUImageSharpenFilter alloc] init];
            
            [(GPUImageSharpenFilter *)self.filter setSharpness:0.5];
            
            [self.stillCamera addTarget:self.filter];
            
            [self.filter addTarget:self.filterView];
        }
            break;
        case GPUIMAGE_unsharpmask:
        {
            [self.stillCamera removeAllTargets];
            
            self.filter = [[GPUImageUnsharpMaskFilter alloc] init];
            
            [(GPUImageUnsharpMaskFilter *)self.filter setIntensity:0.6];
            
            [self.stillCamera addTarget:self.filter];
            
            [self.filter addTarget:self.filterView];
        }
            break;
        case GPUIMAGE_transform:
        {
            [self.stillCamera removeAllTargets];
            
            self.filter = [[GPUImageTransformFilter alloc] init];
            
            [(GPUImageTransformFilter *)self.filter setAffineTransform:CGAffineTransformMakeRotation(0.3)];
            
            [self.stillCamera addTarget:self.filter];
            
            [self.filter addTarget:self.filterView];
        }
            break;
        case GPUIMAGE_transform3D:
        {
            [self.stillCamera removeAllTargets];
            
            self.filter = [[GPUImageTransformFilter alloc] init];
            
            CATransform3D perspectiveTransform = CATransform3DIdentity;
            
            perspectiveTransform.m34 = 0.4;
            perspectiveTransform.m33 = 0.4;
            perspectiveTransform = CATransform3DScale(perspectiveTransform, 0.75, 0.75, 0.75);
            perspectiveTransform = CATransform3DRotate(perspectiveTransform, 0.3, 0.0, 1.0, 0.0);
            [(GPUImageTransformFilter *)self.filter setTransform3D:perspectiveTransform];
            
            [self.stillCamera addTarget:self.filter];
            
            [self.filter addTarget:self.filterView];
        }
            break;
        case GPUIMAGE_crop:
        {
            [self.stillCamera removeAllTargets];
            
            self.filter = [[GPUImageCropFilter alloc] initWithCropRegion:CGRectMake(0.0, 0.0, 1.0, 0.25)];
            
            [(GPUImageCropFilter *)self.filter setCropRegion:CGRectMake(0.0, 0.0, 1.0, 0.4)];
            
            [self.stillCamera addTarget:self.filter];
            
            [self.filter addTarget:self.filterView];
        }
            break;
        case GPUIMAGE_BULGE:
        {
            [self.stillCamera removeAllTargets];
            
            self.filter = [[GPUImageBulgeDistortionFilter alloc] init];
            
            [(GPUImageBulgeDistortionFilter *)self.filter setScale:0.6];
            
            [self.stillCamera addTarget:self.filter];
            
            [self.filter addTarget:self.filterView];
        }
            break;
        case GPUIMAGE_LOWPASS:
        {
            [self.stillCamera removeAllTargets];
            
            self.filter = [[GPUImageLowPassFilter alloc] init];
            
            [(GPUImageLowPassFilter *)self.filter setFilterStrength:0.6];
            
            [self.stillCamera addTarget:self.filter];
            
            [self.filter addTarget:self.filterView];
        }
            break;
        case GPUIMAGE_tonecurve:
        {
            [self.stillCamera removeAllTargets];
            
            self.filter = [[GPUImageToneCurveFilter alloc] init];
            [(GPUImageToneCurveFilter *)self.filter setBlueControlPoints:[NSArray arrayWithObjects:[NSValue valueWithCGPoint:CGPointMake(0.0, 0.0)], [NSValue valueWithCGPoint:CGPointMake(0.5, 0.5)], [NSValue valueWithCGPoint:CGPointMake(1.0, 0.75)], nil]];
            
            [(GPUImageToneCurveFilter *)self.filter setBlueControlPoints:[NSArray arrayWithObjects:[NSValue valueWithCGPoint:CGPointMake(0.0, 0.0)], [NSValue valueWithCGPoint:CGPointMake(0.5, 0.5)], [NSValue valueWithCGPoint:CGPointMake(1.0, 0.75)], nil]];
            
            [self.stillCamera addTarget:self.filter];
            
            [self.filter addTarget:self.filterView];
        }
            break;
        case GPUIMAGE_highlightshadow:
        {
            [self.stillCamera removeAllTargets];
            
            self.filter = [[GPUImageHighlightShadowFilter alloc] init];
            
            [(GPUImageHighlightShadowFilter *)self.filter setHighlights:0.6];
            
            [self.stillCamera addTarget:self.filter];
            
            [self.filter addTarget:self.filterView];
        }
            break;
            
        case GPUIMAGE_haze:
        {
            [self.stillCamera removeAllTargets];
            
            self.filter = [[GPUImageHazeFilter alloc] init];
            
            [(GPUImageHazeFilter *)self.filter setDistance:0.6];
            
            [self.stillCamera addTarget:self.filter];
            
            [self.filter addTarget:self.filterView];
        }
            break;
        default:
            break;
    }
    
}



@end
