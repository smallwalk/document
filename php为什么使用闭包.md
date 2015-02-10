#php为什么使用闭包#


##1，闭包函数的一个应用示例##

> 下面是摘抄的php.net中的一段闭包函数的示例代码，另加上不使用闭包函数的替换写法:

<pre><code>
class Cart {
    const PRICE_BUTTER = 1.00;
    const PRICE_MILK = 3.00;

    protected $products = array();

    public function add($product, $quantity) {
        $this->products[$product] = $quantity;
    }

    public function getQuantity($product) {
        return isset($this->products[$product]) ? $this->products[$product] : FALSE;
    }

    public function getTotal($tax) {
        $total = 0.00;

        //method 1
        /*
        $callback = function($quantity, $product) use ($tax, &$total) {
            $pricePerItem = constant(__CLASS__ . "::PRICE_" . strtoupper($product));
            $total += ($pricePerItem * $quantity) * ($tax + 1.0);
        };

        array_walk($this->products, $callback);
         */

        //method 2
        foreach ($this->products as $product => $quantity) {
            $total += $this->getPerItemPrice($quantity, $product, $tax);
        }
        return round($total, 2);
    }
</code></pre>


> php.net对闭包函数的解释是：匿名函数，也叫闭包函数，允许临时创建一个没有指定名称的函数。最经常用作回调函数（callback）的值。当然，也有其它应用的情况。 闭包函数也可以作为变量的值来使用。PHP会自动把这种表达式转换为内置类Closure的对象实例。把一个closure对象赋值给一个变量的方式与普通变量赋值的语法是一样的。

从上面代码业看，闭包函数除了写出来好看那么一点点似乎也没有什么大的好处。


##2，看看闭包函数里面是什么？##

<pre><code>
$greet = function($names, $age = NULL) {
    printf("Hello %s\r\n", $names);
};

$greet('World');

var_dump($greet);

输出是：

Hello World
object(Closure)#1 (1) {
  ["parameter"]=>
  array(2) {
    ["$names"]=>
    string(10) "<required>"
    ["$age"]=>
    string(10) "<optional>"
  }
}
</code></pre>


> parameter里面是函数的参数列表，如果没有参数，那greet就是object(Closure)#1 (0) { }

##3, 应用场景

> 借鉴这篇文章的介绍：http://docs.phalconphp.com/en/latest/reference/di.html ：依赖注入(DI)或控制反转(loC) 。依赖注入和控制反转是同一个东西，是一种设计模式，这种模式用来减少程序间的耦合。下面从PHP的角度来描述一下这个概念。

<pre><code>
class SomeComponent
{

    /**
     * 连接的实例是硬编码在组件内，因此很难从外面更换或改变其行为
     */
    public function someDbTask()
    {
        $connection = new Connection(array(
            "host" => "localhost",
            "username" => "root",
            "password" => "secret",
            "dbname" => "invo"
        ));

        // ...
    }

}

$some = new SomeComponent();
$some->someDbTask();
</code></pre>

*假设我们要开发一个名为SomeComponent的一个组件，组件的执行任务不重要了，总之我们组件要依赖一个数据库的连接。在第一个例子里，因为数据库的连接参数和类型不能改变，所以这种方式有点不切实际，如果我们有Component2,Component3...这种方式的代码的问题在于，如果我们哪一天改变了某些组件的数据库，要修改的太多了，即使把这些参数放到全局变量也不能解决部分改变的问题。还有一个问题就是代码重复太严重。*

>为了解决这个问题，我们在使用组件之前在外部创建一个实例来实现外部依赖注入。现在看来这是一个不错的解决方案：

<pre><code>
class SomeComponent
{

    protected $_connection;

    /**
     * 从外部注入连接
     */
    public function setConnection($connection)
    {
        $this->_connection = $connection;
    }

    public function someDbTask()
    {
        $connection = $this->_connection;

        // ...
    }

}

$some = new SomeComponent();

//创建连接
$connection = new Connection(array(
    "host" => "localhost",
    "username" => "root",
    "password" => "secret",
    "dbname" => "invo"
));

//向组件内注入连接
$some->setConnection($connection);

$some->someDbTask();
</code></pre>

>现在想象一下如果我们要在一个应用的不同地方使用这个组件，那么我们就需要多次的创建连接。我们可以使用一个叫做注册类的方法来保持住这个连接实例而不用多次的创建连接。

<pre><code>
class Registry
{

    /**
     * Returns the connection
     */
    public static function getConnection()
    {
       return new Connection(array(
            "host" => "localhost",
            "username" => "root",
            "password" => "secret",
            "dbname" => "invo"
        ));
    }

}

class SomeComponent
{

    protected $_connection;

    /**
     * Sets the connection externally
     */
    public function setConnection($connection)
    {
        $this->_connection = $connection;
    }

    public function someDbTask()
    {
        $connection = $this->_connection;

        // ...
    }

}

$some = new SomeComponent();

//Pass the connection defined in the registry
$some->setConnection(Registry::getConnection());

$some->someDbTask();
</code></pre>

*上面方式还是不太完美，如果一个组件内有两次连接数据库的需求，那需要连接两次数据库服务器*

<pre><code>
class Registry
{

    protected static $_connection;

    /**
     * Creates a connection
     */
    protected static function _createConnection()
    {
        return new Connection(array(
            "host" => "localhost",
            "username" => "root",
            "password" => "secret",
            "dbname" => "invo"
        ));
    }

    /**
     * Creates a connection only once and returns it
     */
    public static function getSharedConnection()
    {
        if (self::$_connection===null){
            $connection = self::_createConnection();
            self::$_connection = $connection;
        }
        return self::$_connection;
    }

    /**
     * Always returns a new connection
     */
    public static function getNewConnection()
    {
        return self::_createConnection();
    }

}

class SomeComponent
{

    protected $_connection;

    /**
     * Sets the connection externally
     */
    public function setConnection($connection)
    {
        $this->_connection = $connection;
    }

    /**
     * This method always needs the shared connection
     */
    public function someDbTask()
    {
        $connection = $this->_connection;

        // ...
    }

    /**
     * This method always needs a new connection
     */
    public function someOtherDbTask($connection)
    {

    }

}

$some = new SomeComponent();

//This injects the shared connection
$some->setConnection(Registry::getSharedConnection());

$some->someDbTask();

//Here, we always pass a new connection as parameter
$some->someOtherDbTask(Registry::getNewConnection());
</code></pre>

*从上面我们看到依赖注入怎么解决了这种问题，将依赖作为参数传递代替在组件内部创建的这种方式可以使我们的应用变的更加容易维护和解耦。但从长远看，这种依赖注入还是有些缺点*

*举个例子，如果一个组件内有多个依赖，我们需要创建多个参数依赖传入组件内，使我们的代码变的不容易维护和解耦合*

<pre><code>
//Create the dependencies or retrieve them from the registry
$connection = new Connection();
$session = new Session();
$fileSystem = new FileSystem();
$filter = new Filter();
$selector = new Selector();

//Pass them as constructor parameters
$some = new SomeComponent($connection, $session, $fileSystem, $filter, $selector);

// ... or using setters

$some->setConnection($connection);
$some->setSession($session);
$some->setFileSystem($fileSystem);
$some->setFilter($filter);
$some->setSelector($selector);
</code></pre>

*想到我们必须要在应用程序的许多地方创建对象。在未来，如果我人不再需要这些依赖，那么就要遍历整个代码来删除这些参数。为了解决这个问题，我们再去弄一个工厂方法：*

<pre><code>
class SomeComponent
{

    // ...

    /**
     * Define a factory method to create SomeComponent instances injecting its dependencies
     */
    public static function factory()
    {

        $connection = new Connection();
        $session = new Session();
        $fileSystem = new FileSystem();
        $filter = new Filter();
        $selector = new Selector();

        return new self($connection, $session, $fileSystem, $filter, $selector);
    }

}
</code></pre>
