#!/bin/sh

cd $(dirname "$0")

echo '<!DOCTYPE HTML>
<html>
<head>
  <title>Assassins.TECH - Game '$1' Scoreboard</title>
  <meta charset="UTF-8">
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
</head>
<body>
<style>
body {
  margin: 40px auto;
  max-width: 650px;
  line-height: 1.6;
  font-size: 18px;
  color: #444;
  padding: 0 10px;
}

h1, h2, h3 {
  text-align: center;
  line-height: 1.2;
}

table {
  width: 100%;
  border: none;
  border-spacing: 0;
}

thead {
  text-align: left;
}

th {
  background: -moz-linear-gradient(top, #F0F0F0 0, #DBDBDB 100%);
  background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #F0F0F0), color-stop(100%, #DBDBDB));
  filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#F0F0F0', endColorstr='#DBDBDB', GradientType=0);
  border: 1px solid #B0B0B0;
  color: #444;
  font-size: 16px;
  font-weight: bold;
  text-align: left;
  padding: 3px 10px;
}

td {
  background-color: initial;
  border: initial;
  padding: 3px 10px;
}

table tr:nth-child(even) {
  background: #F2F2F2;
}
</style>

<h1><a href="/">Assassins.TECH</a></h1>
<table>
  <thead>
    <th>Place</th>
    <th>Score</th>
  </thead>
  <tbody>' > www/$1.html

place=1
IFS='
'
for player in $(sort -rk 2 -n score/$1.txt); do
	num=$(echo $player | cut -d " " -f 1)
	score=$(echo $player | cut -d " " -f 2)

	echo '    <tr>
      <td>#'$place'</td>
      <td>'$score'</td>
    </tr>' >> www/$1.html

	echo "Thanks for playing! The game is now over. You placed #$place with $score points. For details, check out: http://Assassins.TECH/$1.html" > xmpp.krourke.org/$num/in

	place=$(($place + 1))
done

echo '  </tbody>
</table>
</body>
</html>' >> www/$1.html

rm games/$1.txt score/$1.txt
