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
**1. Cadastro da senha:**
  - O usuário digita uma senha de 4 dígitos usando o teclado númerico do Edsim51
  - Um LED acende para confirmar o cadastro da senha.
  - Uma mensagem para confirmar o cadastro da senha é exibida no LCD.

**2. Verificação da Senha:**
  - O sistema solicita que o usuário insira a senha.
  - Se a senha estiver correta, um LED verde acende e uma mensagem de sucesso é exibida no LCD.
  - Se a senha estiver incorreta, um LED vermelho acende e uma mensagem de erro é exibida no LCD.

## Estrutura do Código
Para a realização do projeto, foi decidido dividir o código em 4 partes: 

**1.** Sendo a primeira, destinada a armazenamento dos dados em células contínuas da memória, para um melhor desempenho e entendimento do código.

**2.** A segunda parte foi destinada ao funcionamento do teclado numérico (keypad) fornecido pelo edsim51, para uma melhor performance e facilitar o uso do sistema. Atente-se de alterar a forma de leitura do keypad para "pulse", originalmente se encontra em "standart".

**3.** A terceira parte foi destinada ao funcionamento do display LCD, sem conflito com as outras partes do código. Fazendo funcionar de maneira independente e mostrando o status atual do programa por um curto período de tempo.

**4.** Por último, a quarta parte foi destinada a exibição de leds que juntamente com o LCD, ajudam o usúario a entender melhor qual das partes o programa está executando.

## Fluxograma

![c5dd0a68-2a2f-49cf-8852-6555717ab047](https://github.com/user-attachments/assets/ca58e863-620a-481f-a85f-b502567c7f4a)


## Fotos do Funcionamento

# Mensagem no LCD confirmando o cadastro
![mensagem_cadastrado](https://github.com/user-attachments/assets/6b54c163-8af0-4c2c-8903-c2c4befa56ae)

# LED amarelo confirmando o cadastro
![led_cadastrado](https://github.com/user-attachments/assets/3e3c0d51-b3a0-47c7-a22b-a69f1a730881)

# Mensagem no LCD confirmando o acerto da senha
![mensagem_correto](https://github.com/user-attachments/assets/da9aadad-4a68-4812-8184-52afd69826c4)

# LED verde confirmando o cadastro
![led_correto](https://github.com/user-attachments/assets/615535f2-fccc-4ddd-8182-94370bf8c593)

# Mensagem no LCD confirmando o erro da senha
![mensagem_incorreto](https://github.com/user-attachments/assets/09bf4c51-51fc-40d4-ac14-cb467004584c)

# LED vermelho confirmando o erro da senha
![led_vermelho](https://github.com/user-attachments/assets/c7fc90f4-2ba3-4110-9210-ba4160d6b48a)





## Conclusão
  No geral, a experiência de realizar o projeto e arquitetar este circuito, foi muito enriquecedora e de muito aprendizado, as dificuldades encontradas ao longo do caminho fizeram o desenvolvimento ser trabalhoso, mas, ao mesmo tempo, foram a partir desses erros que foi possível garantir um programa sem a existência de erros. Sendo essas dificuldades, a aplicação do LDC, que nos fez ter que alterar diversas lógicas que haviam sido implementadas anteriormente por causa de conflitos na execução, um outro empecilho enfrentado foi no armazenamento na memória dos dados lidos através do keypad, uma vez que os números lidos pelo programa, nem sempre eram fidedignos ao número digitado. Portanto, mesmo havendo diversos entraves e dificuldades para a construção do programa, foi possível encontrar a solução e adquirir o aprendizado necessário com apoio dos materiais disponibilizados pelo professor.
