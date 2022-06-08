<?php 

    include('connect.php');
    
    $json = file_get_contents('php://input');

    $data = json_decode($json,true);

    $nim = '$_POST [nim]';

    $nama = '$_POST [nama]';

    $jk = '$_POST [jk]';

    $alamat = '$_POST [alamat]';

    $jurusan = '$_POST [jurusan]';

    if(!mysqli_query($conn, "INSERT INTO mahasiswa (id,nim,nama,jk,alamat,jurusan) VALUES ('$nim', '$nama', '$jk','$alamat','$jurusan')")){
        $status = array (
            'status' => "Eror: %s\n" , $conn->error
        );
    }else{
        $status = array (
            'Status'=> 'success'
        );
    }




?>