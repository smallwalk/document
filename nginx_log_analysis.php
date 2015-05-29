<?php

$sdoota = array(
	"cart/add_result",	
	"cart/list_info",
	"cart/number",
	"cart/statistic",
	"cart/update ",
	"cart/update_prop",
	"cart/offshelf_list",
	"cart/remove",
	"cart/get_coupon_remind",
);

$any = array();

function analysis($str) {
	global $sdoota;
	global $any;
	$arr = explode("] [", $str);
	foreach ($sdoota as $value) {
		if (strpos($arr[3],  $value) !== FALSE) {
			$key = str_replace("/", "_", $value);	
			$time = $arr[9];

			//echo "key:" . $key . " time:" . $arr[9] . "\n";

			if (empty($any[$key])) {
				$any[$key]['amount'] = 1;
				$any[$key]['time'] = array($time);
			}
			else {
				$any[$key]['amount'] ++;
				$any[$key]['time'][] = $time;
			}
			break;
		}
	}
}

$handle = fopen("dootapc.access.2015052611.log", "r");
if (!$handle) {
	echo "fopen error\n";	
	exit;
}
while(($buffer = fgets($handle)) !== FALSE) {
	analysis($buffer);	
}

fclose($handle);

$result = array();

foreach ($any as $name => $info) {
	$totalTime = 0;
	$totalAmount = $info['amount'];	
	echo "name:" . $name . " total_amount:" . $totalAmount;
	$levelOne = $levelTwo = $levelThree = $levelFour = array('amount' => 0, 'total_time' => 0);
	foreach ($info['time'] as $time) {
		$totalTime += $time;	
		$level = 0;
		if ($time > 0 && $time <= 0.1) {
			$levelOne['amount']++;	
			$levelOne['total_time'] += $time;
		}
		elseif ($time > 0.1 && $time <= 0.5) {
			$levelTwo['amount']++;	
			$levelTwo['total_time'] += $time;
		}
		elseif ($time > 0.5 && $time <= 1) {
			$levelThree['amount']++;	
			$levelThree['total_time'] += $time;
		}
		else {
			$levelFour['amount']++;	
			$levelFour['total_time'] += $time;
		}
	}
	echo " TotalAvgTime:" . round($totalTime / $totalAmount, 3) . "\n";

	if (!empty($levelOne['amount'])) {
		echo " 0~100ms: \t amount:" . $levelOne['amount'] . "\t avgTime:" . round($levelOne['total_time'] / $levelOne['amount'], 3) . "\n";
	}
	if (!empty($levelTwo['amount'])) {
		echo " 100~500ms: \t amount:" . $levelTwo['amount'] . "\t avgTime:" . round($levelTwo['total_time'] / $levelTwo['amount'], 3) . "\n";
	}
	if (!empty($levelThree['amount'])) {
		echo " 500~1000ms: \t amount:" . $levelThree['amount'] . "\t avgTime:" . round($levelThree['total_time'] / $levelThree['amount'], 3) . "\n";
	}
	if (!empty($levelFour['amount'])) {
		echo " >1000ms: \t amount:" . $levelFour['amount'] . "\t avgTime:" . round($levelFour['total_time'] / $levelFour['amount'], 3) . "\n";
	}
	echo "\n-------------------------------------------------------------------------\n";
}
