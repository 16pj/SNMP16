<html>
<body>
<?php
$myFile = 'troll.conf';
if (!file_exists($myFile)) {
  print 'File not found';
}
else if(!$fh = fopen($myFile, 'w')) {
  print "Can\'t open file\n";
}
else {
  print "Success open file\n";

if(!empty($_POST["addr"]) AND !empty($_POST["port"]) AND !empty($_POST["comm"])){
echo "contains values\n";

 $ip = sprintf("%s\n",$_POST["addr"]);
 echo $ip;
 fwrite($fh,$ip); 

 $port = sprintf("%s\n",$_POST["port"]);
 fwrite($fh,$port); 
 echo $port;
 $comm = sprintf("%s\n",$_POST["comm"]);
 fwrite($fh,$comm); 
 echo $comm;
}
else
{
echo "Not valid arguments!";
}
fclose($fh);
}
?>
</body>
</html>
