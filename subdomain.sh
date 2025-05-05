#!/bin/bash

echo -e "\033[1;32m====================================="
echo -e "        Subdomain Fuzzer"
echo -e " Powered by Silvanystro - v1.2.1"
echo -e "=====================================\033[0m"






# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# Ajuda
show_help() {
  echo -e "${GREEN}Uso:${NC} ./script.sh -a dominios.txt -w subdomains.txt"
  echo -e "${GREEN}Opções:${NC}"
  echo "  -a     Arquivo contendo lista de domínios (um por linha)"
  echo "  -w     Arquivo contendo wordlist de subdomínios"
  echo "  --help Exibe este menu de ajuda"
  exit 0
}

# Parâmetros
while [[ "$#" -gt 0 ]]; do
  case $1 in
    -a) DOMAINS_FILE="$2"; shift ;;
    -w) WORDLIST="$2"; shift ;;
    --help) show_help ;;
    *) echo -e "${RED}[ERRO]${NC} Parâmetro inválido: $1" ; show_help ;;
  esac
  shift
done

# Verificações
if [[ -z "$DOMAINS_FILE" || -z "$WORDLIST" ]]; then
  echo -e "${RED}[ERRO]${NC} Você deve fornecer os parâmetros -a e -w."
  show_help
fi

if [[ ! -f "$DOMAINS_FILE" || ! -f "$WORDLIST" ]]; then
  echo -e "${RED}[ERRO]${NC} Arquivo de domínios ou wordlist não encontrado."
  exit 1
fi

# Saídas
FFUF_OUTPUT="escopo-ffuf.txt"
DNSX_OUTPUT="escopo-dnsx.txt"
> "$FFUF_OUTPUT"
> "$DNSX_OUTPUT"





echo -e "${GREEN}[*] Iniciando fuzzing com FFUF (threads: 300)...${NC}"

while read domain; do
  echo "[+] Testando com ffuf em: $domain"

  ffuf -w "$WORDLIST" -u "http://FUZZ.$domain" -t 300 -mc 200,301,302,403 \
       -of csv -o tmp_ffuf_$domain.csv > /dev/null

  # Pega URL completa da coluna 2 e extrai o host corretamente
  tail -n +2 tmp_ffuf_$domain.csv | cut -d ',' -f2 | sed 's|http[s]*://||' | awk -F/ '{print $1}' >> "$FFUF_OUTPUT"

  rm -f tmp_ffuf_$domain.csv

done < "$DOMAINS_FILE"

echo -e "${GREEN}[✓] FFUF finalizado. Resultados salvos em:${NC} $FFUF_OUTPUT"

echo -e "${GREEN}[*] Gerando lista para DNSX...${NC}"

> dnsx_input.txt
while read domain; do
  while read sub; do
    echo "$sub.$domain"
  done < "$WORDLIST"
done < "$DOMAINS_FILE" > dnsx_input.txt

echo -e "${GREEN}[*] Iniciando varredura com DNSX (threads: 300)...${NC}"
dnsx -l dnsx_input.txt -t 300 -silent -o "$DNSX_OUTPUT"
rm -f dnsx_input.txt

echo -e "${GREEN}[✓] DNSX finalizado. Resultados salvos em:${NC} $DNSX_OUTPUT"

