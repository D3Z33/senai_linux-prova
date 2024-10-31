<?php
// Captura os dados enviados pelos alunos
$nickname = $_POST['nickname'];
$progress = $_POST['progress'];

// Caminho do arquivo onde serão armazenados os dados
$file = '/var/www/html/dashboard/progress.json';

// Lê os dados atuais do arquivo JSON
if (file_exists($file)) {
    $data = json_decode(file_get_contents($file), true);
} else {
    $data = [];
}

// Atualiza o progresso do aluno
$data[$nickname] = $progress;

// Escreve os dados atualizados no arquivo
file_put_contents($file, json_encode($data));
?>