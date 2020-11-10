<?php
  $con = mysqli_connect('{lab.db.fqdn}', '{lab.db.user}', '{lab.db.password}');
  mysqli_select_db($con, 'acmedb');
  $hn = gethostname();

  $query = "INSERT INTO posts (id, title, body, hostname) VALUES (NULL, '".$_POST['title']."', '".  $_POST['body'] . "','".$hn."');";

  $result = mysqli_query($con, $query);

  echo "Thank you!";

  header("location:posts.php");
?>
