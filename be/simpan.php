<?php
include("config.php");
if ($_SERVER['REQUEST_METHOD'] != "POST") {
    echo json_encode(array("status" => "methode not allowed"));
    return;
}
$nama = $_POST['nama'];
$no_handphone = $_POST['no_handphone'];
$sql = "INSERT INTO `data_siswa` (`id`, `nama`, `no_handphone`) VALUES (NULL, ?, ?);";
$simpan = $conn->prepare($sql);
$simpan->bind_param("ss", $nama, $no_handphone);
$simpan->execute();
echo json_encode(array(
    "status" => "success",
    "message" => "Data berhasil disimpan",
));
?>