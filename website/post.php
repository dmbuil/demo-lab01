<html>
<head></head>
<body>
<?php

$con = mysqli_connect('{lab.db.fqdn}', '{lab.db.user}', '{lab.db.password}', 'acmedb');

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
