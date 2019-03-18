//
//  DairyViewController.m
//  GraduateProj
//
//  Created by jay on 2019/1/16.
//  Copyright © 2019 mlg. All rights reserved.
//

#import "DairyViewController.h"
#import "CHKTagView.h"
#import <CoreLocation/CoreLocation.h>
#import "PPStickerInputView.h"
#import "PPUtil.h"
#import "PPStickerKeyboard.h"

@interface DairyViewController ()<UITableViewDelegate,UITableViewDataSource,CHKTagViewDelegate,UITextViewDelegate,CLLocationManagerDelegate,PPStickerInputViewDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,copy)NSArray *sportArr;
@property(nonatomic,strong)UILabel *placeLabel;
@property(nonatomic,strong)CLLocationManager *locationManager;
@property(nonatomic,strong)UILabel *locationLabel;

@property (nonatomic, copy) NSString *messages;
@property (nonatomic, strong) PPStickerInputView *inputView;
@property (nonatomic, strong) UIView *grayResponder;

@end

@implementation DairyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonClick)];
    
    [self setData];
    [self configUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide) name:UIKeyboardWillHideNotification object:nil];
}
- (void)keyboardHide{
    _grayResponder.alpha = 0;
    self.inputView.hidden = YES;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    CGFloat height = [self.inputView heightThatFits];
    CGFloat minY = CGRectGetHeight(self.view.bounds) - height - PP_SAFEAREAINSETS(self.view).bottom;
    self.inputView.frame = CGRectMake(0, minY, CGRectGetWidth(self.view.bounds), 300);
    self.inputView.hidden = YES;
}
- (void)doneButtonClick{
    if (self.dairyBlock) {
        self.dairyBlock(self.textView.text);
    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)setData{
    _sportArr = @[@"深蹲",@" 腿举",@"箭步蹲",@"俯卧腿屈伸",@"山羊挺身",@"卷腹",@"保加利亚分腿蹲",@"俯卧撑",@"小哑铃钻石握推",@"小哑铃平地飞鸟",@"四向点头",@"斜角肌拉伸",@"徒手古巴推举",@"仰卧划臂",@"俯身划船",@"平板支撑",@"波比跳"];
}
- (void)configUI{
    _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = [self tableViewHeader];
    _tableView.tableFooterView = [self tableViewFooter];
    [self.view addSubview:_tableView];
    
    _grayResponder = [[UIView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 300)];
    _grayResponder.backgroundColor = [UIColor lightGrayColor];
    _grayResponder.alpha = 0;
    [self.view addSubview:_grayResponder];
    [self.view addSubview:self.inputView];
}
- (PPStickerInputView *)inputView
{
    if (!_inputView) {
        _inputView = [[PPStickerInputView alloc] init];
        _inputView.delegate = self;
    }
    return _inputView;
}
- (UIView *)tableViewHeader{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    //bgView.backgroundColor = kColor(210, 210, 210, 1);
    
    _textView = [[UITextView alloc] init];
    _textView.delegate = self;
    _textView.font=[UIFont fontWithName:@"Arial" size:18.0];
    _textView.textColor = [UIColor blackColor];
    
    
    
    [bgView addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(5);
        make.top.equalTo(bgView).offset(15);
        make.bottom.right.equalTo(bgView).offset(-5);
    }];
    
    _placeLabel = [[UILabel alloc] init];
    //_placeLabel.backgroundColor = [UIColor greenColor];
    _placeLabel.text = @"写下今日的感想...";
    _placeLabel.textColor = [UIColor lightGrayColor];
    [bgView addSubview:_placeLabel];
    [_placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(5);
        make.top.equalTo(bgView).offset(15);
        make.size.mas_equalTo(CGSizeMake(150, 40));
    }];
    if (self.timeStr != NULL) {
        _placeLabel.hidden = YES;
        _textView.text = @"今天完成了40分钟的训练\n";
    }
    
    //位置label
    _locationLabel = [[UILabel alloc] init];
    _locationLabel.font = [UIFont systemFontOfSize:13];
    _locationLabel.textColor = [UIColor lightGrayColor];
    [bgView addSubview:_locationLabel];
    [_locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(bgView);
        make.size.mas_equalTo(CGSizeMake(350, 20));
    }];
    return bgView;
}
- (UIView *)tableViewFooter{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 300)];
    //bgView.backgroundColor = kColor(210, 210, 210, 1);
    CHKTagView *tag = [[CHKTagView alloc] initWithFrame:bgView.bounds tagNames:_sportArr tagItemStyle:[[CHKTagViewItemStyle alloc] initWithType:CHKTagViewItemStyleTypeDefault]];
    
    tag.backgroundColor = [UIColor whiteColor];
    tag.delegate = self;
    //    tag.canMultiSelect = YES;
    
    [bgView addSubview:tag];
    if (!self.timeStr) {
        tag.hidden = YES;
    }
    return bgView;
}
#pragma mark - PPStickerInputViewDelegate

- (void)stickerInputViewDidClickSendButton:(PPStickerInputView *)inputView
{
    _grayResponder.alpha = 0;
    [self.inputView.textView resignFirstResponder];
    NSString *plainText = inputView.plainText;
    if (!plainText.length) {
        return;
    }
    self.messages = plainText;
    [inputView clearText];
    
    _placeLabel.hidden = YES;
    NSMutableAttributedString *attributedMessage = [[NSMutableAttributedString alloc] initWithString:plainText attributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:16.0], NSForegroundColorAttributeName: [UIColor blackColor] }];
    [PPStickerDataManager.sharedInstance replaceEmojiForAttributedString:attributedMessage font:[UIFont systemFontOfSize:16.0]];

    self.textView.attributedText = attributedMessage;
}
#pragma mark textviewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    //NSLog(@"oo");
    _grayResponder.alpha = 3;
    [self.inputView.textView becomeFirstResponder];
    self.inputView.hidden = NO;
    return NO;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (![textView.text isEqualToString:@""]) {
        _placeLabel.hidden = YES;
    }
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1){
        _placeLabel.hidden = NO;
    }
    return YES;
}
#pragma mark  tagView
- (void)chk_tagView:(CHKTagView *)tagView didSelectItemAtIndex:(NSInteger)index {

    self.textView.textColor = [UIColor blackColor];
    self.messages = [NSString stringWithFormat:@"%@  ⚡︎%@",self.messages,[_sportArr objectAtIndex:index]];
    //NSString *whatStr = [NSString stringWithFormat:@"%@  ⚡︎%@",self.textView.text,[_sportArr objectAtIndex:index]];

    NSMutableAttributedString *attributedMessage = [[NSMutableAttributedString alloc] initWithString:self.messages attributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:16.0], NSForegroundColorAttributeName: [UIColor blackColor] }];
    [PPStickerDataManager.sharedInstance replaceEmojiForAttributedString:attributedMessage font:[UIFont systemFontOfSize:16.0]];
    self.textView.attributedText = attributedMessage;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIden  = @"cellDairy";
    UITableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIden];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (!self.timeStr) {
        cell.textLabel.text = @"开启位置信息";
        cell.imageView.image = [UIImage imageNamed:@"iconfontcolor"];
    }else{
        cell.textLabel.text = @"选择今天做的动作:";
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!self.timeStr) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        //设置定位精度
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        [self.locationManager requestAlwaysAuthorization];
        self.locationManager.distanceFilter = 10.0f;
        [self.locationManager startUpdatingLocation];
    }
}
#pragma mark CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations{
    CLLocation *newLocation = locations[0];
    //CLLocationCoordinate2D oCoordinate = newLocation.coordinate;
    [self.locationManager stopUpdatingLocation];
    
    //创建地理位置解码编辑器对象
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        for (CLPlacemark *place in placemarks) {
            //NSDictionary *location = [place addressDictionary];
            _locationLabel.text = [NSString stringWithFormat:@"---%@,%@,%@",place.locality,place.subLocality,place.thoroughfare];
        }
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
