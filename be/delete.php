<?php
include("config.php");
if ($_SERVER['REQUEST_METHOD'] != "DELETE") {
    echo json_encode(array("status" => "methode not allowed"));
    return;
}
$id = $_GET["id"];
$sql = "DELETE FROM data_siswa WHERE `data_siswa`.`id` = ?";
$simpan = $conn->prepare($sql);
$simpan->bind_param("i", $id);
$simpan->execute();
echo json_encode(array(
    "status" => "success",
    "message" => "Data berhasil didelete",
));
?>