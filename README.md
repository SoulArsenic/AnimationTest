# AnimationTest
  自己写的动画例子，慢慢整理和优化 
  -----------------------
	
	1、卡牌效果
	
	2、移动
  
	3、加入一个组合动画
	
	4、模仿 qq 消息拖拽移除 调整为任意方向的拖拽效果（我恨数学。。。）
	
	5、画圆
	
	6、仿秘密的手势操作
	
	7 仿 iDaily 的手势操作
	
	8 新建了一个LAdaptiveImageView 用来处理图片位置的自定义
	
	9 加入一个自定义的tabbar的动画效果<LTabbarView>
		https://dribbble.com/shots/2071319-GIF-of-the-Tapbar-Interactions
		
		//子类tabbarcontroller 中
		-(void)viewDidLayoutSubviews{
		   [super viewDidLayoutSubviews];
		   LTabbarView * a =  [[LTabbarView alloc] initWithTabbar:self];
		   [self.view addSubview:a];
		}
		

	10 加入一个滑动控件， 
---------
