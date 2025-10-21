<?php

require("conecta.php");


  date_default_timezone_set('America/Belem');
  $data = date("Y-m-d");
  $hora = date("H:i:s");
  $idcond = 140;
  $count = 0;


              $buscar_vei_mor = mysqli_query($mysqli, "SELECT 
             
              veiculos_morador.id, 
              veiculos_morador.placa, 
              veiculos_morador.idusu,
              veiculos_api.ipadress,
              veiculos_api.port,
              veiculos_api.usuario,
              veiculos_api.senha

              FROM veiculos_morador 
              
              INNER JOIN usuarios ON veiculos_morador.idusu = usuarios.ID
              INNER JOIN condominios ON usuarios.IDCOND = condominios.ID
              INNER JOIN veiculos_api ON condominios.ID = veiculos_api.idcond
              
              WHERE condominios.ID = '$idcond' AND veiculos_morador.arq = 0 ");

              while( $res = mysqli_fetch_array($buscar_vei_mor)){

               $ipAdress = $res[3];
               $port = $res[4];
               $username = $res[5];
               $password = $res[6];
               $idvei = $res[0];
               $stardate = $data."T".$hora;
               $placa = $res[1];
               
              /*echo "placa: ".$placa."<br>"; DESARMEI AQUI A URL
                $url = "http://" . $ipAdress . ":" . $port . "/ISAPI/Traffic/channels/1/licensePlateAuditData/record?format=json";*/

               if (IncluirVeiculo($url, $idvei, $username, $password, $stardate, $placa, $data) == 1) {
                    
                  echo "IDVEI: ".$idvei." PLACA: ".$placa."<br>";
                  $count++;
                
                } 

              }

              echo "CONTAGEM: ".$count;

                 



  function IncluirVeiculo($url, $idvei, $username, $password, $stardate, $placa, $data)
  {
  
     $curl = curl_init();
     curl_setopt_array($curl, array(
        CURLOPT_URL => $url,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_ENCODING => '',
        CURLOPT_MAXREDIRS => 10,
        CURLOPT_TIMEOUT => 0,
        CURLOPT_FOLLOWLOCATION => true,
        CURLOPT_USERPWD        => $username . ":" . $password,
        CURLOPT_HTTPAUTH       => CURLAUTH_DIGEST,
        CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
        CURLOPT_CUSTOMREQUEST => 'PUT',
        CURLOPT_POSTFIELDS =>'{
          "LicensePlateInfoList": [
            {
              "LicensePlate":  "' . $placa . '",
              "listType": "whiteList",
              "createTime":  "' . $stardate . '",
              "effectiveStartDate": "' . $data . '",
              "effectiveTime": "2031-10-01",
              "id": "' . $idvei. '",
              "cardID": ""
            }
          ]
        }',
          CURLOPT_HTTPHEADER => array(
            'Content-Type: application/json'
          ),
        ));
  
  
     $response = curl_exec($curl);
     $json = json_decode($response);
     $result =  $json->statusCode;
     curl_close($curl);
     return $result;
  }
