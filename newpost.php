<?php
  $con = mysqli_connect('vm-web-db-n01.acme.adm', 'webuser', 'tefvdc1$');
  mysqli_select_db($con, 'acmedb');
  $hn = gethostname();

  $query = "INSERT INTO posts (id, title, body, hostname) VALUES (NULL, '".$_POST['title']."', '".  $_POST['body'] . "','".$hn."');";

  $result = mysqli_query($con, $query);

  echo "Thank you!";

  header("location:posts.php");
?>
