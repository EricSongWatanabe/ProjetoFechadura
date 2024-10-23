# ProjetoFechadura
### Eric Song Watanabe - RA: 24.123.028-3
### Victor Pimentel Lario - RA: 24.123.027-5

## Descrição do Projeto
  Este projeto consiste no desenvolvimento de uma fechadura digital em Assembly. O usuário escolherá uma senha numérica de 4 dígitos, que será armazenada na memória do programa.
Um LED acenderá para confirmar o cadastro da senha. Em seguida, a "fechadura" solicitará a senha escolhida. Caso a senha esteja correta, um LED específico acenderá; caso
contrário, outro LED será acionado para indicar erro. Além disso, mensagens serão exibidas no display LCD para acompanhar as ações realizadas.


## Objetivos
- Simular o funcionamento de uma fechadura digital.
- Armazenar uma senha numérica de 4 dígitos na memória.
- Verificar se a senha inserida está correta.

## Funcionamento
1. Cadastro da senha:
  - O usuário digita uma senha de 4 dígitos usando o teclado númerico do Edsim51
  - Um LED acende para confirmar o cadastro da senha.
2. Verificação da Senha:
  - O sistema solicita que o usuário insira a senha.
  - Se a senha estiver correta, um LED verde acende indicando sucesso.
  - Se a senha estiver incorreta, um LED vermelho acende para indicar erro.