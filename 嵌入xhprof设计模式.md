#嵌入xhprof设计模式#

##1，要实现在功能

- 将xhprof生成的分析数据落地，方便找出程序的性能瓶颈和设计不合理的地方。
- 分析数据(xhprof生成的数据)可以灵活的落地，比如文本，DB，Redis...
- 统计数据(每次请求的统计信息，接囗名，时间等)可以灵活的落地，比如Redis，DB...

##2，代码


<pre><code>

	文件：XhprofManager.class.php

	<?php
	namespace Phplib\Xhprof;

	class XhprofManager {

		static $singleton = NULL;

		//分析数据落地
		const TYPE_STORAGE_TEXT = 1;
		const TYPE_STORAGE_DB = 2;
		const TYPE_STORAGE_REDIS = 3;

		//统计数据
		const TYPE_ANY_DB = 1;
		const TYPE_ANY_REDIS = 2;

		//请求来源
		const SOURCE_SNAKE = 1;
		const SOURCE_VIRUS = 2;

		private $classMap = array(
			self::SOURCE_VIRUS => 'VirusXhprof',
			self::SOURCE_SNAKE => 'SnakeXhprof',
		);

		public static function getRequest($type) {
			return new $this->classMap[$type];
		}
	}	


	文件：Dispatcher.class.php

	\Phplib\Xhprof\XhprofManager::getRequest(\Phplib\Xhprof\XhprofManager::SOURCE_VIRUS)->init($module, $action);

	$controller = new $class($this->request);
	$controller->control();
	$controller->echoView();

    \Phplib\Xhprof\XhprofManager::getRequest(\Phplib\Xhprof\XhprofManager::SOURCE_VIRUS)->finish();
</code></pre>

> Dispatcher文件中xhprof代码有一定的耦合度，改成下面这样能会好一点：

<pre><code>
	$anyFactory = new \Phplib\Xhprof\AnyFactory(\Phplib\Xhprof\XhprofManager::SOURCE_VIRUS, $this->request);
	\Phplib\Xhprof\Manager::getRequest($anyFactory)->init();

	$controller = new $class($this->request);
	$controller->control();
	$controller->echoView();

	\Phplib\Xhprof\Manager::getRequest($anyFactory)->finish();
</code></pre>
