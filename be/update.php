<?php
include("config.php");
if ($_SERVER['REQUEST_METHOD'] != "POST") {
    echo json_encode(array("status" => "methode not allowed"));
    return;
}
$id = $_GET["id"];
$nama = $_POST['nama'];
$no_handphone = $_POST['no_handphone'];
$sql = "UPDATE `data_siswa` SET `nama` = ?, `no_handphone` =? WHERE `data_siswa`.`id` = ?;";
$simpan = $conn->prepare($sql);
$simpan->bind_param("ssi", $nama, $no_handphone, $id);
$simpan->execute();
echo json_encode(array(
    "status" => "success",
    "message" => "Data berhasil update",
));
?>