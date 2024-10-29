<?php
// Captura os dados enviados pelos alunos
$nickname = isset($_POST['nickname']) ? $_POST['nickname'] : '';
$progress = isset($_POST['progress']) ? $_POST['progress'] : '';

// Verifica se os dados estão preenchidos
if (!empty($nickname) && !empty($progress)) {
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
    if (file_put_contents($file, json_encode($data))) {
        echo "Progresso atualizado com sucesso!";
    } else {
        echo "Erro ao salvar os dados.";
    }
} else {
    echo "Dados inválidos.";
}
?>