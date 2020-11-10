<html>
<head>
<style>body{font-family: "Segoe UI";}</style>
</head>
	<body>
		<h1>My dFW Demo Site</h1>

		<?php
		$hn=gethostname();
		echo "<p><i>Proudly served from node: ".$hn."</i></p>";
		?>

		<a href='new.php'>Create new Post</><br>
		<a href='posts.php?delete=true'>Delete all Posts</a>

		<?php
		function deleteposts(){
		        $con = mysqli_connect('vm-web-db-n01.acme.adm', 'webuser', 'tefvdc1$');
		        mysqli_select_db($con, 'acmedb');

		        $result = mysqli_query($con, "DELETE FROM `posts`");
		}

		if (isset($_GET['delete'])){
		        deleteposts();
		}

		$con = mysqli_connect('vm-web-db-n01.acme.adm', 'webuser', 'tefvdc1$');
		mysqli_select_db($con, 'acmedb');

		$result = mysqli_query($con, "SELECT * FROM `posts`");

		while ($post = mysqli_fetch_assoc($result)){
		        $link = "<a href='post.php?id=".$post['id']. "'>";
		        echo $link;
		        echo "<h3>".$post['title']."</h3>";
		        echo "</a>";
		        echo "<p>Hostname: ".$post['hostname']."</p>";
		        echo "<p>".$post['body']."</p>";
		        echo "<hr />";
		}
		?>
	</body>
</html>
