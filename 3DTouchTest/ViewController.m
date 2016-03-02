#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UIViewControllerPreviewingDelegate>

@property(nonatomic,strong)UITableView *tbVew;
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation ViewController

//检测3D Touch是否可用
-(BOOL)is3DTouchAvailiable
{
    if(self.traitCollection.forceTouchCapability==UIForceTouchCapabilityAvailable)
        return YES;
    return NO;
}
//视图加载完成
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
    [self createTableView];
}
//初始化
-(void)setup
{
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.navigationController.navigationBar.barStyle=UIBarStyleBlack;
    self.title=@"3D Touch";
    _dataArray=[NSMutableArray arrayWithArray:@[@"峰哥哥",@"CGPointZero",@"原点"]];
    
    //注册3D Touch
    if([self is3DTouchAvailiable])
    {
        [self registerForPreviewingWithDelegate:self sourceView:self.view];
    }
}
//表视图
-(void)createTableView
{
    _tbVew=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    _tbVew.delegate=self;
    _tbVew.dataSource=self;
    [self.view addSubview:_tbVew];
    _tbVew.tableFooterView=[UIView new];
}

#pragma mark - UITableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const cid =@"cid";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cid];
    if(!cell)
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
    cell.textLabel.text=_dataArray[indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
//选中cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detail=[[DetailViewController alloc]init];
    detail.title=_dataArray[indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
}

//UIAlertController的快捷创建方法
-(void)showAlert:(NSString *)title body:(NSString *)body
{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:title message:body preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}
#pragma mark - UIViewControllerPreviewingDelegate
-(UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    NSIndexPath *indexPath=[_tbVew indexPathForRowAtPoint:CGPointMake(location.x, location.y-64)];
    if(indexPath)
    {
        DetailViewController *detail=[[DetailViewController alloc]init];
        detail.title=_dataArray[indexPath.row];
        //detail.preferredContentSize=CGSizeMake(300, 300);
        __weak typeof(self) wkSelf=self;
        //------------上拉时的菜单-------------------
        //置顶及 其点击逻辑 
        UIPreviewAction *topAction=[UIPreviewAction actionWithTitle:@"置顶" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction *action, UIViewController *previewViewController) {
            id obj=[wkSelf.dataArray objectAtIndex:indexPath.row];
            [wkSelf.dataArray removeObject:obj];
            [wkSelf.dataArray insertObject:obj atIndex:0];
            [wkSelf.tbVew reloadData];
            [wkSelf showAlert:@"提示" body:@"已置顶"];
        }];
        //删除及其点击逻辑
        UIPreviewAction *deleteAction=[UIPreviewAction actionWithTitle:@"删除" style:UIPreviewActionStyleDestructive handler:^(UIPreviewAction *action, UIViewController *previewViewController) {
            [wkSelf.dataArray removeObjectAtIndex:indexPath.row];
            [wkSelf.tbVew reloadData];
            [wkSelf showAlert:@"警告" body:@"已删除"];
        }];
        //传递上拉菜单项给detail
        detail.actions=@[topAction,deleteAction];
        
        return detail;
    }
    return nil;
}
-(void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    [self showViewController:viewControllerToCommit sender:self];
}


@end
