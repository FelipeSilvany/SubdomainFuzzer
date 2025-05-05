# 🌐 Subdomain Fuzzer v1.2.1

![Badge](https://img.shields.io/badge/version-1.2.1-blue)
![License](https://img.shields.io/badge/license-MIT-green)
![Status](https://img.shields.io/badge/status-ativo-success)

Automatize a descoberta de subdomínios com **FFUF** e **DNSX** de forma rápida, paralela e eficiente.  
Ideal para recon, bug bounty e pentests.

---

## 🚀 O que o script faz?

O `subdomain.sh` executa duas fases principais:

1. 🔍 **Fuzzing com FFUF**: tenta subdomínios em cada domínio alvo usando wordlist e registra os válidos.
2. 🌐 **Resolução com DNSX**: verifica quais subdomínios respondem via DNS, garantindo que estão ativos.

---

## 📦 Dependências

Certifique-se de ter instaladas as seguintes ferramentas:

- [FFUF](https://github.com/ffuf/ffuf)
- [DNSX](https://github.com/projectdiscovery/dnsx)
- `bash`, `awk`, `cut`, `sed`, `grep`

Instale com:

```bash
sudo apt update && sudo apt install ffuf -y
GO111MODULE=on go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest
```

---

## 🧾 Menu de Ajuda

Execute com `--help` para ver o menu:

```bash
./subdomain.sh --help
```

### 📚 Parâmetros

| Parâmetro | Descrição |
|----------|------------|
| `-a`     | Arquivo com lista de domínios (ex: `dominios.txt`) |
| `-w`     | Wordlist com subdomínios (ex: `subdomains.txt`) |
| `--help` | Exibe o menu de ajuda |

---

## 🛠️ Como executar

```bash
chmod +x subdomain.sh
./subdomain.sh -a dominios.txt -w subdomains.txt
```

- `dominios.txt`:  
  ```
  exemplo.com
  teste.com.br
  ```

- `subdomains.txt`:  
  ```
  www
  mail
  admin
  ```

---

## 📁 Arquivos de saída

| Arquivo | Conteúdo |
|--------|----------|
| `escopo-ffuf.txt` | Subdomínios válidos detectados via FFUF |
| `escopo-dnsx.txt` | Subdomínios ativos (resolvidos via DNSX) |

---

## ✨ Exemplo de uso real

```bash
./subdomain.sh -a dominios.txt -w commonsubs.txt
```

Resultado:

```
[*] Iniciando fuzzing com FFUF (threads: 300)...
[+] Testando com ffuf em: exemplo.com
[✓] FFUF finalizado. Resultados salvos em: escopo-ffuf.txt

[*] Gerando lista para DNSX...
[*] Iniciando varredura com DNSX (threads: 300)...
[✓] DNSX finalizado. Resultados salvos em: escopo-dnsx.txt
```

---

## ⚠️ Aviso Legal

> Este script é fornecido apenas para fins **educacionais e de testes autorizados**.  
> O uso em sistemas sem permissão constitui **atividade ilegal**.

---

## 🤝 Autor

Feito com 💚 por **Felipe Silvany**  
[GitHub: @FelipeSilvany](https://github.com/FelipeSilvany)

Apoie este projeto:  
[![Donate](https://img.shields.io/badge/Doar-PayPal-blue)](https://www.paypal.com/donate/?hosted_button_id=A6LPT7ERM8AQS)
