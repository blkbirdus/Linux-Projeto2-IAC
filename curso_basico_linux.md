# Curso Básico de Linux - Anotações

## 1. Comandos Básicos

- Sempre use o parâmetro `--help` quando não souber o comando.

### Procurar arquivos/diretórios no sistema

```bash
find -name arquivo
```

### Ver grupos e usuários

```bash
cat /etc/group   # Ver grupos de usuários
cat /etc/sudoers # Ver usuários com permissão de sudo
```

### Acessar e gerenciar permissões de superusuário

```bash
sudo su         # Entrar como superusuário
sudo passwd root # Definir senha para root
su (nome_usuário) # Sair do superusuário
```

## 2. Gerenciamento de SSH

### Habilitar acesso remoto para root

```bash
nano /etc/ssh/sshd_config
# Alterar a linha: #PermitRootLogin prohibit-password para PermitRootLogin yes
```

### Reiniciar o serviço SSH

```bash
systemctl restart ssh
```

### Verificar status do SSH

```bash
systemctl status ssh
```

## 3. Histórico de Comandos

### Comandos relacionados ao histórico

```bash
history              # Exibir histórico de comandos
!comando            # Reutilizar um comando anterior
!!                  # Executar o último comando novamente
export HISTTIMEFORMAT="%c "  # Alterar formato de data/hora do histórico
set +o history      # Desativar o histórico\
set -o history      # Ativar o histórico
history -w         # Armazenar o histórico em um arquivo
```

### Configurar limite de comandos armazenados

```bash
nano .bashrc
# Editar a linha: HISTSIZE=(tamanho desejado)
```

## 4. Gerenciamento de Usuários

### Criar usuário

```bash
useradd user
# Criar diretório home e definir nome do usuário
useradd -m -c "nome" user
# Definir interpretador
useradd -s /bin/bash user
# Adicionar ao grupo
usermod -G grupo user
# Definir data de expiração
usermod -e data_para_expiração user
```

### Alterar configurações do usuário

```bash
usermod user
passwd user  # Definir senha para o usuário
```

### Remover usuário

```bash
userdel user    # Remover usuário
userdel -f user # Forçar remoção se ainda estiver logado
userdel -r user # Remover diretório do usuário
```

### Ver usuários do servidor

```bash
cat /etc/passwd
```

### Criar senha encriptada ao adicionar usuário

```bash
useradd user -p $(openssl passwd -6 senha)
```

## 5. Scripts no Linux

- Todo script deve ter extensão `.sh` e iniciar com:

```bash
#!/bin/bash
```

- Para torná-lo executável:

```bash
chmod +x script.sh
```

## 6. Gerenciamento de grupos

### Criar e remover grupos

```bash
groupadd grupo  # Criar grupo
groupdel grupo  # Remover grupo
```

### Gerenciar usuários em grupos

```bash
usermod -G grupo user   # Adicionar usuário a um grupo
gpasswd -d user grupo  # Remover usuário de um grupo
```

## 7. Permissões de Arquivos e Diretórios

### Conceitos

- **r**: leitura (4)
- **w**: escrita (2)
- **x**: execução (1)
- **Sem permissão**: (-)
- Para indicar mais que uma permissão se usa a soma dos números
- Exemplo de estrutura de permissões: `drwxr-xr--`

### Modificar permissões

```bash
chmod 754 arquivo  # Exemplo de configuração de permissão
```

- **dono**: `7 = leitura + gravação + execução`
- **grupo**: `5 = leitura + execução`
- **Outros**: `4 = leitura`

### Alterar dono e grupo

```bash
chown dono:grupo arquivo
```

## 8. Gerenciamento de Pacotes

- Para scripts, prefira `apt-get` em vez de `apt`.

### Comandos principais

```bash
apt list --installed  # Listar pacotes instalados
apt update && apt upgrade  # Atualizar pacotes
wget 'link' # Baixar arquivos
apt edit-sources  # Adicionar repositórios
```

## 9. Gerenciamento de Discos

### Comandos para verificar e formatar discos

```bash
lsblk  # Listar discos
fdisk -l  # Verificar partições
fdisk /dev/id_do_disco  # Criar partições (depois pressionar 'n')
mkfs.formato_desejado  # Formatar disco (para Linux se usa etx3, etx4 e nfs)
```

### Montar e configurar montagem automática

```bash
mount /dev/id_do_disco /mnt/destino  # Montar disco
nano /etc/fstab /dev/id_do_disco /destino/ # Configurar montagem automática ao iniciar (destino normalmente em /mnt/pasta)
```

## 10. Manipulando Arquivos

### Copiando arquivos

- `cp` `parâmetros` `origem` `destino`

```bash
cp /home/user/arquivo.txt /home/user/documents/ # Irá substituir arquivos com o mesmo nome, usar com cuidado
```

- Parâmetro -i para modo interativo
- Parâmetro -r para modo recursivo
- Parâmetro -v para modo verbose

```bash
cp -i -r -v /home/user/arquivo.txt /home/user/documents/
```

### Movendo arquivos

- Mover arquivos segue a mesma base mas com o comando `mv`
  - não estará disponível o modo recursivo

```bash
mv -i -v /home/user/arquivo.txt /home/user/documents
```

- É possível renomear arquivos usando o comando `mv`

```bash
mv ./planilhadevendas.xls planilha_de_ventas.xls
```

## 11. Servidores de arquivos

### Para que um servidor Linux reconheça arquivos do sistema operacional windows é necessário usar o aplicativo [samba](https://wiki.samba.org/index.php/Main_Page)

- O arquivo de configuração do samba fica em /etc/samba/smb.conf
- Para criar uma pasta publica usas-se

```bash
    [nome pasta]
    path = /mnt/disk/pasta # Caminho do diretório
    writable = yes # Indica se a pasta é manipulável
    gest ok = yes # É permitido os convidados usarem o servidor de arquivos
    guest only = yes # Permite convidados
```

- Após isso reiniciar o serviço do samba: `systemctl restart smbd`
- Para habilitar automaticamente sempre que iniciar a maquina: `systemctl enable smbd`
- Feito isso, abrir o explorador de arquivos e na barra superior digitar

    ```bash
    \\192.168.0.103\publica # Ip configurado + nome da pasta compartilhada
    ```

  - Então é indicada as credenciais do usuário e pronto, pasta acessada com sucesso

---
