<?php 

    include('connect.php');

    $sql = "SELECT * FROM mahasiswa";

    $result = mysqli_query($conn,$sql);

    $array = array();

    if (mysqli_num_rows($result) > 0){
        while ($row = mysqli_fetch_array($result)){
            $data = array(
                'id' => $row ['id'],
                'nim' => $row ['nim'],
                'nama' => $row ['nama'],
                'jk' => $row ['jk'],
                'alamat' => $row ['alamat'],
                'jurusan' => $row ['jurusan'],
            );
            array_push($array, $data);
        }
    }
    echo json_encode($array);

?>