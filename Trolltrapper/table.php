 <html>
<body>

<form action="form.php" method="post">
DEVICE IP <input type="text" name="addr"><br>
PORT <input type="text" name="port"><br>
Community String <input type="text" name="comm"><br>
<input type="submit">
</form>
<br>
</body>
</html> 

<table>
    <thead>
        <tr>

            <th>FQDN of device&emsp;</th>
            <th>Current State&emsp;</th>
            <th>Manager time of current status&emsp;</th>
            <th>Previous State&emsp;</th>
            <th>Manager time of previous state&emsp;</th>
        </tr>
    </thead>
    <tbody>
    <?php
        $con=mysqli_connect("localhost","root","password","robin");
        $sql=mysqli_query($con, "SELECT * from traptroll");
	$devices=[];


        while($row=mysqli_fetch_array($sql))
        {
    ?>
    <tr>

        <td><?php if($row["FQDNfail"]!="DEFAULT") echo $row['FQDNfail'];?>&emsp;</td>	
        <td><?php  if($row["currstat"]!="DEFAULT") echo $row['currstat'];?></td>
        <td><?php if($row["mantimefail"]!="DEFAULT")  echo $row['mantimefail'];?></td>
        <td><?php if($row["prevstat"]!="DEFAULT") echo $row['prevstat'];?></td>
        <td><?php if($row["mantimeprevstat"]!="DEFAULT") echo $row['mantimeprevstat'];?></td>
    </tr>
    <?php   }?>


    </tbody>

</table>


