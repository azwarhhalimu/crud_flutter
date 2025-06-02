<?php
include("config.php");
$sql = "SELECT * FROM data_siswa";
$kon = $conn->query($sql);
$data = [];
while ($item = $kon->fetch_assoc()) {
    $data[] = $item;
}
echo json_encode(array(
    "status" => "success",
    "data" => $data,
));
?>