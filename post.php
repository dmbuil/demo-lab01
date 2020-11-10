<html>
<head></head>
<body>
<?php

$con = mysqli_connect('vm-web-db-n01.acme.adm', 'webuser', 'tefvdc1$', 'acmedb');

$id= $_GET['id'];
$query = "SELECT * FROM `posts` WHERE id=". $id;

$result = mysqli_query($con, $query);

$post = mysqli_fetch_assoc($result);

echo "<h1>".$post['title']."</h1>";
echo "<p>Hostname: ".$post['hostname']."</p>";
echo "<p>".$post['body']."</p>";
echo "<hr />";

?>

<a href='posts.php'>Back</a>
</body>
</html>
