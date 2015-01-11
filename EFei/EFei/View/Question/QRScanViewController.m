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
#import "QuestionViewController.h"
#import "RichTextView.h"

#define ShowResultSegueId @"ShowQuestionViewController"

#define ScanRectTop 105
#define ScanRectWidth 260

typedef enum : NSUInteger {
    ScanModeSingle,
    ScanModeMultiple,
} ScanMode;

@interface QRScanViewController ()<ZXCaptureDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    ZXCapture*  _capture;
    
    UIView*     _indicatorView;
    BOOL        _scaning;
    BOOL        _parsing;
    CGRect      _scanRect;
    
    ScanMode    _scanMode;
}

@property (weak, nonatomic) IBOutlet UIView *scanRectView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;

@property (weak, nonatomic) IBOutlet UIView *multipleScanView;
@property (weak, nonatomic) IBOutlet UILabel *multipleScanLabel;
@property (weak, nonatomic) IBOutlet UIView *scanResultView;
@property (weak, nonatomic) IBOutlet RichTextView *questionView;



- (IBAction)onLight:(UIButton *)sender;

- (IBAction)onBack:(id)sender;

- (IBAction)onSegmentControlValueChanged:(id)sender;
- (IBAction)onMultipleScanOK:(id)sender;
- (IBAction)onMultipleScanCancel:(id)sender;

- (IBAction)onScanResultOK:(id)sender;
- (IBAction)onScanResultCancel:(id)sender;

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
    
    // for test
//    [self scanSuccessWithContent:@"dev.efei.org/~vON7R"];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    [self startIndicatorAnimation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    _scanRect = CGRectMake((self.view.frame.size.width-ScanRectWidth)/2, ScanRectTop, ScanRectWidth, ScanRectWidth);
    NSLog(@"%f, %f, %f, %f", _scanRect.origin.x, _scanRect.origin.y, _scanRect.size.width, _scanRect.size.height);
    
    _scanRect = self.scanRectView.frame;
    _scanRect.origin.x = (self.view.frame.size.width-self.scanRectView.frame.size.width)/2;
    
    NSLog(@"%f, %f, %f, %f", _scanRect.origin.x, _scanRect.origin.y, _scanRect.size.width, _scanRect.size.height);
    
    
    _capture.scanRect = CGRectApplyAffineTransform(_scanRect, captureSizeTransform);
    
    
    _scaning = YES;
    
    for (UIView* subView in self.view.subviews)
    {
        [self.view bringSubviewToFront:subView];
    }
}

- (void) initViews
{
    CGRect indicatorRect = _scanRect;
    indicatorRect.size.height = 2;
    indicatorRect.size.width -= 20;
    indicatorRect.origin.x = (self.view.frame.size.width - indicatorRect.size.width) / 2;
    
    _indicatorView = [[UIView alloc] initWithFrame:indicatorRect];
    _indicatorView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_indicatorView];
    
    
    self.segmentControl.tintColor = [UIColor blackColor];
    self.segmentControl.backgroundColor = [UIColor clearColor];
    [self.segmentControl setBackgroundImage:[UIImage imageNamed:@"icon_scan_switch_second_off"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.segmentControl setBackgroundImage:[UIImage imageNamed:@"icon_scan_switch_second_on"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    
    
    _scanMode = ScanModeSingle;
    
    
    self.multipleScanView.hidden = YES;
    self.scanResultView.hidden = YES;
    
    [self updateMultipleScanView];
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

#pragma mark -- Action

- (IBAction)onLight:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (![device hasTorch])
    {
        NSLog(@"no torch");
    }
    else
    {
        [device lockForConfiguration:nil];
        if (sender.selected)
        {
            [device setTorchMode: AVCaptureTorchModeOn];
        }
        else
        {
            [device setTorchMode: AVCaptureTorchModeOff];
        }
        
        [device unlockForConfiguration];
    }
}

- (IBAction)onBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)onSegmentControlValueChanged:(id)sender
{
    if (self.segmentControl.selectedSegmentIndex == 1)
    {
        [self.segmentControl setBackgroundImage:[UIImage imageNamed:@"icon_scan_switch_first_off"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [self.segmentControl setBackgroundImage:[UIImage imageNamed:@"icon_scan_switch_first_on"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
        
        _scanMode = ScanModeMultiple;
    }
    else
    {
        [self.segmentControl setBackgroundImage:[UIImage imageNamed:@"icon_scan_switch_second_off"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [self.segmentControl setBackgroundImage:[UIImage imageNamed:@"icon_scan_switch_second_on"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
        
        _scanMode = ScanModeSingle;
    }
    
    self.multipleScanView.hidden = (_scanMode == ScanModeSingle);
}

- (IBAction)onMultipleScanOK:(id)sender
{
    NSArray* questions = [GetQuestionController instance].noteList;
    CompletionBlock handler = ^(NetWorkTaskType taskType, BOOL success) {
        
        [self.navigationController popViewControllerAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    };
    [AddQuestionListToNotebookCommand executeWithQuestionList:questions completeHandler:handler];
    
}

- (IBAction)onMultipleScanCancel:(id)sender
{
    [[GetQuestionController instance] discardQuestionList];
    
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)onScanResultOK:(id)sender
{
    [[GetQuestionController instance] addQuestionToList];
    [self updateMultipleScanView];
 
    [self hideScanResultView];
}

- (IBAction)onScanResultCancel:(id)sender
{
    [[GetQuestionController instance] discardCurrentQuestion];
    
    [self hideScanResultView];
}

- (void) showScanResultView
{
    Note* note = [GetQuestionController instance].currentNote;
    [self.questionView setNoteContent:note.contents];
    
    self.scanResultView.hidden = NO;
}

- (void) hideScanResultView
{
    self.scanResultView.hidden = YES;
}


- (void) updateMultipleScanView
{
    NSInteger count = [GetQuestionController instance].noteList.count;
    self.multipleScanLabel.text = [NSString stringWithFormat:@"已扫描 %ld 道题目", (long)count];
}


- (void) setupNavigationBar
{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = @"扫一扫";
    self.navigationController.navigationBarHidden = YES;
}


- (void) doneWithSingleQuestion
{
    [self performSegueWithIdentifier:ShowResultSegueId sender:self];
}

- (void) doneWithMultipleQuestion
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onPhotoAlbum:(id)sender
{
    UIImagePickerController* picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    
    [self.navigationController presentViewController:picker animated:YES completion:nil];
}

- (void) scanSuccessWithContent:(NSString *)content
{
    if (_parsing)
    {
        return;
    }
    
    // Ignore scaned question.
    if ([[GetQuestionController instance] questionExist:content])
    {
        return;
    }
    
    
    _parsing = YES;
    
    // Vibrate
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    if (_scanMode == ScanModeSingle)
    {
        [_capture stop];
    }
    
    ControllerCompletionBlock handler = ^(BOOL success) {
        NSLog(@"get question %d", success);
        _parsing = NO;
        switch (_scanMode)
        {
            case ScanModeSingle:
            {
                [self doneWithSingleQuestion];
            }
                break;
                
            case ScanModeMultiple:
            {
                [self showScanResultView];
            }
                break;
                
            default:
                break;
        }
        
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
        QuestionViewController* questionVC = (QuestionViewController*)segue.destinationViewController;
        questionVC.note = [GetQuestionController instance].currentNote;
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
