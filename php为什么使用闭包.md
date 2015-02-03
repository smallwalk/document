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





