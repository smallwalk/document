#rabbitmq#

sudo apt-get install rabbitmq-server

大部分的文件在/usr/lib/rabbitmq,数据文件存在于/var/lib/rabbitmq

##1，入门示例##

> send.php

<pre><code>
require __DIR__.'/../bootstrap/autoload.php';

use PhpAmqpLib\Connection\AMQPConnection;
use PhpAmqpLib\Message\AMQPMessage;

//rabbitmq服务器
$host = '192.168.151.214';
//rabbitmq端口
$port = 5672;
$user = 'guest';
$pass = 'guest';

//创建连接
$connection = new AMQPConnection($host, $port, $user, $pass);

//获取通道
$channel = $connection->channel();

//队列名称
$queueName = 'gc_test_1';
//当队列不存在时是否会抛出一个错误信息，仍然不会被声明
$passive = FALSE;
//是否持久化(false:服务重启队列丢失)
$durable = TRUE;
//仅服务于一个客户端
$exclusive = FALSE;
//退出后队列不丢失,If set, the queue is deleted when all consumers have finished using it
$autoDelete = FALSE;
//创建队列
$channel->queue_declare($queueName, $passive, $durable, $exclusive, $autoDelete);

$timeStart = microtime(TRUE);
for ($i = 0; $i < 1000000; $i++) {
	//消息 delivery_mode＝2，服务重启后消息不丢失
	$word = "123456789.123456789.123456789." . $i;
	$msg = new AMQPMessage($word, array('delivery_mode' => 2));
	//发送
	$routeKey = $queueName;
	$exchange = '';
	$channel->basic_publish($msg, $exchange, $routeKey);

	echo " [ Sent $word ]\n";
}
$timeEnd = microtime(TRUE);

$timeSpend = $timeEnd - $timeStart;

echo "Time Spend:" . $timeSpend . "\n";

$channel->close();
$connection->close();

</code></pre>

> queue.durable 队列是否持久化，这里只是指队列的持久化，不是指队列中的消息。如果设置为true,则服务端的rabbitmq-server重启后，队列不会自动删除，如果设置为false，则服务重启后队列自动消失。队列的持久化还存在一个问题，如果你修改一个已经存在的队列的属性，会报错。

> queue.autoDelete 消费者退出后队列是否自动删除。举例，我把queueName改为gc_test_2，然autoDelete设置为true，则消费者在把队列中的消息都处理完后，队列自动的删除。即使队列是durable的也会自动的删除。

> queue.passive 队列不存在时，是否抛错。


<pre><code>
require __DIR__.'/../bootstrap/autoload.php';

use PhpAmqpLib\Connection\AMQPConnection;
use PhpAmqpLib\Message\AMQPMessage;

//rabbitmq服务器
$host = '192.168.151.214';
//rabbitmq端口
$port = 5672;
$user = 'guest';
$pass = 'guest';

//创建连接
$connection = new AMQPConnection($host, $port, $user, $pass);
//获取通道
$channel = $connection->channel();

//队列名称
$queueName = 'gc_test_1';
//当队列不存在时是否会抛出一个错误信息，仍然不会被声明
$passive = FALSE;
//是否持久化(false:服务重启时队列消息)
$durable = TRUE;
//
$exclusive = FALSE;
//退出后队列不丢失.If set, the queue is deleted when all consumers have finished using it
$autoDelete = FALSE;
//创建队列
$channel->queue_declare($queueName, $passive, $durable, $exclusive, $autoDelete);

$callBack = function($msg) {
	echo "[x] Received ", $msg->body, "\n";
};

$consumerTag = '';
$noLocal = FALSE;
$noACK = TRUE;
$exclusive = FALSE;
$noWait = FALSE;
$channel->basic_consume($queueName, $consumerTag, $noLocal, $noACK, $exclusive, $noWait, $callBack);

while(count($channel->callbacks)) {
	$channel->wait();
}

$channel->close();
$connection->close();

</code></pre>

> 上面的是direct的经典应用。创建连接，声明通道和队列，向队列发送消息。然后消费者从队列中取数据，todo something...


##2 工作队列

> 下面我们创建一个工作队列，我们使用多个consumer来处理耗时的任务。任务队列的主要思想就是避免实时的处理一些资源密集性的任务，与之相对的是我们要封装一个任务发送到队列里，然后后台的另外的工作进程来处理。
