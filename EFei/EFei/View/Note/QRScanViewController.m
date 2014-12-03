//
//  QRScanViewController.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/28/14.
//
//

#import "QRScanViewController.h"
#import <ZXingObjC.h>
#import "NotebookCommand.h"
#import "GetQuestionController.h"

#define ShowResultSegueId @"ShowQuestionViewController"

@interface QRScanViewController ()<ZXCaptureDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    ZXCapture*  _capture;
    
    UIView*     _indicatorView;
    BOOL        _scaning;
    CGRect      _scanRect;
}

- (void) setupNavigationBar;
- (void) initCapture;
- (void) scanSuccessWithContent:(NSString*)content;
- (void) scanFailed;

- (void)onPhotoAlbum:(id)sender;


@end

@implementation QRScanViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavigationBar];
    [self initCapture];
    [self initViews];
    
    [self startIndicatorAnimation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) setupNavigationBar
{
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = @"扫一扫";
}

- (void) initCapture
{
    _capture = [[ZXCapture alloc] init];
    _capture.camera = _capture.back;
    _capture.focusMode = AVCaptureFocusModeContinuousAutoFocus;
    _capture.rotation = 90.0f;
    
    _capture.layer.frame = self.view.bounds;
    [self.view.layer addSublayer:_capture.layer];
    
    _capture.delegate = self;
    _capture.layer.frame = self.view.bounds;
    
    CGAffineTransform captureSizeTransform = CGAffineTransformMakeScale(320 / self.view.frame.size.width, 480 / self.view.frame.size.height);
    
    float size = 260;
    
    _scanRect = CGRectMake((self.view.frame.size.width-size)/2, 180, size, size);
    _capture.scanRect = CGRectApplyAffineTransform(_scanRect, captureSizeTransform);
    
    _scaning = YES;
    
    for (UIView* subView in self.view.subviews)
    {
        [self.view bringSubviewToFront:subView];
    }
}

- (void) initViews
{
    UIView* scanRectView = [[UIView alloc] initWithFrame:_scanRect];
    scanRectView.backgroundColor = [UIColor clearColor];
    scanRectView.layer.borderColor = [UIColor whiteColor].CGColor;
    scanRectView.layer.borderWidth = 1;
    [self.view addSubview:scanRectView];
    
    CGRect indicatorRect = _scanRect;
    indicatorRect.size.height = 2;
    _indicatorView = [[UIView alloc] initWithFrame:indicatorRect];
    _indicatorView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_indicatorView];
}

- (void) startIndicatorAnimation
{
    if (!_scaning)
    {
        return;
    }
    
    
    CGRect frame = _indicatorView.frame;
    frame.origin.y = _scanRect.origin.y;
    _indicatorView.frame = frame;
    
    [UIView animateWithDuration:2.5 animations:^{
        
        CGRect frame = _indicatorView.frame;
        frame.origin.y += (_scanRect.size.height-1);
        _indicatorView.frame = frame;
        
    } completion:^(BOOL finished) {
        
        [self startIndicatorAnimation];
        
    }];
}

- (IBAction)onPhotoAlbum:(id)sender
{
    UIImagePickerController* picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    
    [self.navigationController presentViewController:picker animated:YES completion:nil];
}

- (void) scanSuccessWithContent:(NSString *)content
{
    if (!_scaning)
    {
        return;
    }
    
    // Ignore scaned question.
    if ([[GetQuestionController instance] questionExist:content])
    {
        return;
    }
    
    // Vibrate
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    [_capture stop];
    _scaning = NO;
    
    
    ControllerCompletionBlock handler = ^(BOOL success) {
        NSLog(@"get question %d", success);
        
        [self performSegueWithIdentifier:ShowResultSegueId sender:self];
        
    };
    [GetQuestionContentCommand executeWithShortUrl:content completeHandler:handler];
}

- (void) scanFailed
{
    
}

- (NSString*) decodeImage:(UIImage*)image
{
    ZXLuminanceSource *source = [[ZXCGImageLuminanceSource alloc] initWithCGImage:image.CGImage];
    ZXBinaryBitmap *bitmap = [ZXBinaryBitmap binaryBitmapWithBinarizer:[ZXHybridBinarizer binarizerWithSource:source]];
    
    NSError *error = nil;
    
    ZXDecodeHints *hints = [ZXDecodeHints hints];
    ZXMultiFormatReader *reader = [ZXMultiFormatReader reader];
    ZXResult *result = [reader decode:bitmap
                                hints:hints
                                error:&error];
    
    return result.text;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:ShowResultSegueId])
    {
        
    }
}


#pragma mark UIImagePickerDelegate

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSString* content = [self decodeImage:image];
    if (content.length > 0)
    {
        [self scanSuccessWithContent:content];
    }
    else
    {
        [self scanFailed];
    }
}

#pragma mark - ZXCaptureDelegate Methods

- (void)captureResult:(ZXCapture *)capture result:(ZXResult *)result
{
    if (result.text.length > 0)
    {
        [self scanSuccessWithContent:result.text];
    }
    else
    {
        [self scanFailed];
    }
}

#pragma mark - Private Methods

- (NSString *)barcodeFormatToString:(ZXBarcodeFormat)format
{
    switch (format) {
        case kBarcodeFormatAztec:
            return @"Aztec";
            
        case kBarcodeFormatCodabar:
            return @"CODABAR";
            
        case kBarcodeFormatCode39:
            return @"Code 39";
            
        case kBarcodeFormatCode93:
            return @"Code 93";
            
        case kBarcodeFormatCode128:
            return @"Code 128";
            
        case kBarcodeFormatDataMatrix:
            return @"Data Matrix";
            
        case kBarcodeFormatEan8:
            return @"EAN-8";
            
        case kBarcodeFormatEan13:
            return @"EAN-13";
            
        case kBarcodeFormatITF:
            return @"ITF";
            
        case kBarcodeFormatPDF417:
            return @"PDF417";
            
        case kBarcodeFormatQRCode:
            return @"QR Code";
            
        case kBarcodeFormatRSS14:
            return @"RSS 14";
            
        case kBarcodeFormatRSSExpanded:
            return @"RSS Expanded";
            
        case kBarcodeFormatUPCA:
            return @"UPCA";
            
        case kBarcodeFormatUPCE:
            return @"UPCE";
            
        case kBarcodeFormatUPCEANExtension:
            return @"UPC/EAN extension";
            
        default:
            return @"Unknown";
    }
}

@end
