//
//  NormalTableViewController.m
//  AnimationTest
//
//  Created by lengbinbin on 15/3/26.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "NormalTableViewController.h"
#import "ImageScrollTableViewCell.h"


@interface NormalTableViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray * array;
@end

@implementation NormalTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.array = [NSMutableArray array];
    NSMutableString * str = [NSMutableString stringWithString:@" - 5ea9ca01jw1eqbzy9vpvij20hs0hsgms --     - 75328713jw1eqbxdy7wk4j20ez0cajrz     75328713jw1eqbxdyg0qwj20i60h7jsg   - 75328713jw1eqbxdymk0zj20l00lpgn9 --     - 6e72a149jw1eqc1rb3ozrj20xc18g13f --     - 89945535jw1eqc23adyebj20bu0hsgnm --     - d2434155jw1eqbzr9vdduj20k00zkdji --     - 71f88918gw1eqc4ypnv2kj20ff08cjt2 71f88918gw1eqc4yqhzmrj20u215oqan --     - 82dbfffbjw1eqc1xrm39aj21w02iokjm 82dbfffbjw1eqc1xdtwsfj22io1w0b2a --     - 80599c37jw1eqc0ex6h01j21w02io4qq --     - bfeaf223jw1eqc1kayhulj20hs0b2jsb --     - 72a96f33jw1eqc55dhkgcj20ci0go42x --     - 9e176f79jw1eqc2y4rqxkj20hs0j6q4n --     - ab19aa44jw1eqbxs3m6rrj20yi0jeqfh  --     - bd5f54c2jw1eqbz3qf2y0j20hs0hjdik --     - a657c759jw1eqc0biuon1j20qo0zkq6b --     - a657c759jw1eqc0bjy7hpj20x718g4b1 --     - a657c759jw1eqc0bkeackj20x718g14j     - a657c759jw1eqc0bleigbj20x718ggws --     - 5176d7dfjw1eqc4bdzn5cj218g0xcwpu 5176d7dfjw1eqc4bg9navj218g0xcn9f --    - b8f4b2ffjw1eqav48f9p7j20hs0hswgs --     - 005OOuwOjw1eqc4qpomx6j30hs0qo0uq 005OOuwOjw1eqc4qxmnhtj30hs0qogo0 005OOuwOjw1eqc4qllxd7j30hs0qojt1 --     - 5c4e591ejw1eqbxsdl8d6j20x718gh0p --     - 744768e1jw1eqc46tu9w9j20hs0oqtct --     - 47c7636cjw1eqc0cmocbxj20hs0nqjsn 47c7636cjw1eqc0cmhmphj20hs0nq0ud 47c7636cjw1eqc0cmxcgyj20hs0nqtah 47c7636cjw1eqc0cn3s9tj20hs0nqt9s 47c7636cjw1eqc0cncmebj20hs0nqab5 47c7636cjw1eqc0co7qezj20xc18gaj7 --     - ae6dfc57jw1eqc3g54di8j20u00u0add --     - 8fa8a781jw1eqc189w094j20qo0h8tay 8fa8a781jw1eqc18bp0o9j20f10qoabs --     - 8bb889fdjw1eqc3rfpkkbj20zk0qon26 8bb889fdjw1eqc3rgb2d4j20qo0zk784 --     - 515543c7jw1eqc527qkrxj21e011ihdu 515543c7jw1eqc51zalp6j211i1e0u0y --     - 005TezjYjw1eqbxl5adlxj30no0vkwku --     - 6f7cbf4bjw1eqc40irapbj20xc18gk5k --     - 005yDqTTjw1eqby59ddn1j30ku1127b1 --    - 8a5a77f5jw1eqc49b2u7zj20cm0hs75v --     - 7958dc61jw1eqc58i7kubj23pc230u0x 7958dc61jw1eqc588wvroj23pc230kjl --    - 69fbdc5bjw1eqc2h6jaz0j20u00gvacv 69fbdc5bjw1eqc2h6q2p2j20u00gvmzv --     - e282a239jw1eqbxf3j1uyj218g0xc7e7 --     - b0871899jw1eqc1uqbhkdj20hs0hswfz --     - 83bf07e4jw1eqc25c0srcj20hs0np0ty     83bf07e4jw1eqc25fihdqj20hs0npjsz     83bf07e4jw1eqc25kqvqpj20np0hsq5j 83bf07e4jw1eqc25qozqcj20np0hsdka 83bf07e4jw1eqc25u5jhcj20hs0np40c 83bf07e4jw1eqc2603f21j20np0hsdhy 83bf07e4jw1eqc266ojvcj20np0hswh6 83bf07e4jw1eqc26aqhk9j20np0hswg7 83bf07e4jw1eqc26esh2qj20mo0h00ua --    - 5173d602jw1eqc3ezl6ldj20pb190drw --     - a60a99efjw1eqbze9bdnnj20oo0gpwig a60a99efjw1eqbze9u49zj20qo0o2afx a60a99efjw1eqbzeal24aj218g0xc7gn a60a99efjw1eqbzebae7wj218g0xc7dn a60a99efjw1eqbzec2qy3j218g0xck31 a60a99efjw1eqbzectc2uj218g0xcamo --     - eb4cc8d0jw1eqbxr9m7tuj208c0b4dg6 eb4cc8d0jw1eqbxr94v9zj208w0bvmxh eb4cc8d0jw1eqbxrazg58j20no0vktbv eb4cc8d0jw1eqbxrbs5q2j20dc0hst9s eb4cc8d0jw1eqbxrk5hv0j20hs0vk0ws eb4cc8d0jw1eqbxrlbmrtj20dc0hst9k --     - ae5c98ebjw1eqc1imf5acj20nq0hsabl --     - 005tJ9Xijw1eqc0uitchuj30qo0zk7wh 005tJ9Xijw1eqc0ujd18zj30dc0hs46z --    - 87c6293ajw1eqc4lr3ce2j20hs0qogre --    - 626a8762jw1eqc2y0qwmej211i1e0hdu --     - d9f9a260jw1eqc4xbh8ljj20ez0qojtl d9f9a260jw1eqc4xg4kipj20dc0hsach d9f9a260jw1eqc4xj9ajhj20dc0hsmz6 d9f9a260jw1eqc4xn4hb6j20hs0dcq58 d9f9a260jw1eqc4xqc6jvj20dc0hsjtd d9f9a260jw1eqc4x6id2pj20dc0hsq3u d9f9a260jw1eqc4xreum5j20dc0hsdha d9f9a260jw1eqc4xs9m2jj20dc0hstaq d9f9a260jw1eqc4xtbzfpj20dc0hstap --     - 7fe3197ejw1eqc3oup8mdj20m80er0th 7fe3197ejw1eqc3ov36dkj20m80eqt9h 7fe3197ejw1eqc3ov1sq7j20m80eoq3q 7fe3197ejw1eqc3ov7sfqj20m80co0t3 --     - 88072e82jw1eqc13udqvpj20ez0qoq4f --     - 6f7b6be3jw1eqc08h6wupj218g0p045e --   - be097a80jw1eqbwr7byknj20hs0huwne --     - 878d3afbjw1eqc0noxfz5j20c10go76h --    - 71a0d659jw1eqbzfjq1zvj20u00u0wi0 71a0d659jw1eqbzfi2jzoj20u00u0tbl --     - 5eaef664jw1eqc4nk5ok9j20m80xcq9v --     - 4073ea49jw1eqbvkrszmyj20w218gtkj --     - 6f980b1bjw1eqbwmajdkoj20hs0dcwgp 6f980b1bjw1eqbwma3u2cj20dc0hsq5h 6f980b1bjw1eqbwmaqgcbj20hs0dcwge --     - 8825f8f4jw1eqbx9mwhgpj20h00h076k --     - 005J1CxDjw1eqc1lpoztuj30nq0hswgl 005J1CxDjw1eqc1lpxg27j30g00qomyo --     - 0064r33pjw1eqc2irqsegj30tf18gq7s --     - d1c63b58jw1eqc4hz02hsj20xc18gwhg --     - e7152957jw1eqbxpivqqoj20hs0hs3zd e7152957jw1eqbxpj83lnj20hs0hs0tq e7152957jw1eqbxpjm05hj20hs0hsq3l e7152957jw1eqbxpkejznj20hs0hsjsm e7152957jw1eqbxpl4i4kj20hs0hs0ti e7152957jw1eqbxplhbihj20hs0hsgmn e7152957jw1eqbxplrjk0j20hs0hs402 e7152957jw1eqbxpio4i9j20hs0hsgmc --     - cab08e4ajw1eqc40606b7j20no0vkjvk cab08e4ajw1eqc405grucj20no0vk0xm cab08e4ajw1eqc406ek2ej20no0vk0vo cab08e4ajw1eqc406ove0j20no0vk0wc cab08e4ajw1eqc406rbswj20no0vkaec cab08e4ajw1eqc407moijj20no0vk786 cab08e4ajw1eqc4084ilrj20no0vk79i cab08e4ajw1eqc408z0sdj20no0vk7a5 cab08e4ajw1eqc4053jooj212f18gtfo --     - 755a4a11jw1eqc26uwnuwj20dc0dcaai --    - 71bc7babjw1eqc2h0ahv8j20zk0zk4qp 71bc7babjw1eqc2h7nyqij20zk0zk1kx 71bc7babjw1eqc2huhnpvj20zk0zkqp2     71bc7babjw1eqc2hxptsgj211y0lcwio --     - 005SCIwbjw1eqc2f1k1e7j30ko12o0tc --     - 75ea63b5jw1eqbxv5stqjj20hs0hsjtm --"];
    NSArray *tempArray = [str componentsSeparatedByString:@" - "];
    
    
    for (NSString * temp in tempArray) {
        if (temp.length >= 32) {
            NSString * item = [temp substringWithRange:NSMakeRange(0, 32)];
            
            [self.array addObject:item];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellID = @"imageScrollCell";
    UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    
    return cell1;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if ([cell isKindOfClass:[ImageScrollTableViewCell class]]) {
        ImageScrollTableViewCell* cello = (ImageScrollTableViewCell*) cell;
        cello.show.image = nil;
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
