//
//  Tab5ViewController.m
//  GraduateProj
//
//  Created by 焦英博 on 2018/11/19.
//  Copyright © 2018年 mlg. All rights reserved.
//

#import "Tab5ViewController.h"
#import "LoginViewController.h"
#import "MyHealthView.h"
#import <CoreMotion/CoreMotion.h>
#import <MBProgressHUD.h>
#import "SingleObj.h"

@interface Tab5ViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,strong)UITableView *myTableView;
@property (nonatomic,copy)NSArray *someArr;
@property (nonatomic,copy)NSArray *aimArr;



@end

@implementation Tab5ViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setData];
    [self setUI];
}
- (void)setData{
    _aimArr = @[@"我的健康档案",@"我参加过的活动",@"我的收藏"];
    _someArr = @[@"意见反馈",@"关于我们",@"清理缓存",@"退出登陆"];
}
- (void)setUI{
    _myTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.tableHeaderView = [self setTableViewHeader];
    [self.view addSubview:_myTableView];
    
    
}
- (UIView *)setTableViewHeader{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 220)];
    //bgView.backgroundColor = [UIColor colorWithRed:0 green:191/255.f blue:242/255.f alpha:1];
     bgView.backgroundColor = kColor(0, 191, 242, 1);
    
    UIButton *albumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    albumBtn.backgroundColor = [UIColor greenColor];
    albumBtn.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-150)/2, 20, 150, 150);
    albumBtn.layer.cornerRadius = 75;
    albumBtn.layer.masksToBounds = true;
    [albumBtn addTarget:self action:@selector(buttonClickAlbum) forControlEvents:UIControlEventTouchUpInside];
    [albumBtn setImage:[UIImage imageNamed:@"headerImage"] forState:UIControlStateNormal];

    [bgView addSubview:albumBtn];
    
    
    NSArray *titleLabelArr = @[[NSString stringWithFormat:@"今日步数：%.0f   |",[SingleObj share].stepsNumber],[NSString stringWithFormat:@"总公里数：%.2fkm   |",[SingleObj share].distance/1000],@"本周日均步数：2000"];
    float labelWid = [UIScreen mainScreen].bounds.size.width/3;
    for (int i = 0; i<3; i++) {
        UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelWid*i, 175, labelWid, 30)];
        infoLabel.font = [UIFont systemFontOfSize:12];
        infoLabel.textColor = [UIColor whiteColor];
        infoLabel.text = [titleLabelArr objectAtIndex:i];
        infoLabel.textAlignment = NSTextAlignmentCenter;
       // infoLabel.backgroundColor = [UIColor colorWithRed:80*i/255.f green:180/255.f blue:230/255.f alpha:1];
        [bgView addSubview:infoLabel];
    }
    
    return bgView;
}
- (void)buttonClickAlbum{
    
    NSLog(@"album");
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:YES completion:nil];
        }
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    NSLog(@"finish");
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return _aimArr.count;
    }else{
        return _someArr.count;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *strCell = @"myCell";
    UITableViewCell *cell = [_myTableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = [_aimArr objectAtIndex:indexPath.row];
    }else{
        cell.textLabel.text = [_someArr objectAtIndex:indexPath.row];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //健康档案
    if (indexPath.section == 0 && indexPath.row<3) {
        MyHealthView *vc = [[MyHealthView alloc] init];
        vc.myTag = indexPath.row;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 1 && indexPath.row == 0){
        NSLog(@"yi");
    }else if (indexPath.section == 1 && indexPath.row == 1){
        NSLog(@"us");
    }else if (indexPath.section == 1 && indexPath.row == 2){
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            // Do something...
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"当前缓存%.2fM,是否清理",[self readCacheSize]] preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"ok");
            }];
            UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"点击了取消");
            }];
            
            [alert addAction:action1];
            [alert addAction:action2];
            [self presentViewController:alert animated:YES completion:nil];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            });
        });
        
        
    }else if (indexPath.section == 1 && indexPath.row == 3) {
        //跟上面的流程差不多，记得要把preferredStyle换成UIAlertControllerStyleAlert
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否退出登录" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            LoginViewController *mainVC = [[LoginViewController alloc] init];
            window.rootViewController =mainVC;
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击了取消");
        }];
        
        [alert addAction:action1];
        [alert addAction:action2];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}
#pragma mark - clear cache
//沙盒目录下有三个文件夹Documents、Library（下面有Caches和Preferences目录）、tmp
- (float)readCacheSize{
    //获取library路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    return [self folderSizeAtPath:cachePath];
}
- (float)folderSizeAtPath:(NSString *)folderPath{
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) {
        return 0;
    }
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString *fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil) {
        NSString *fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}
- (long long)fileSizeAtPath:(NSString *)filePath{
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]) {
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
- (void)clearFile{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    for (NSString *p in files) {
        NSError *error = nil;
        NSString *fileAbsolutePath = [cachePath stringByAppendingPathComponent:p];
        if ([[NSFileManager defaultManager] fileExistsAtPath:fileAbsolutePath]) {
            [[NSFileManager defaultManager] removeItemAtPath:fileAbsolutePath error:&error];
        }
    }
    float cacheSize = [self readCacheSize]*1024;
    NSLog(@"qing li -- %f",cacheSize);
}
@end
