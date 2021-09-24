# Assistente de Criação de Projetos

Nosso objetivo neste tutorial é cumprir com todas as etapas necessárias para completar o projeto de um circuito em um dispositivo FPGA. Abra o Quartus Prime, se já não estiver aberto. A criação de um projeto é a primeira etapa para iniciar nossos projetos dentro do Quartus Prime, e o assistente **New Project Wizard** torna esse processo mais fácil pra você. Você pode acessar o **New Project Wizard** a partir da página principal do Quartus Prime, que surge assim que ele é aberto, ou selecionando o menu **File** e então **New Project Wizard**.

A primeira página desse assistente descreve as etapas de criação de um projeto. Leia com atenção os itens que estão destacados e clique em **Next**. Em seguida, nós entramos com a informação do diretório onde o projeto será criado. Nós criaremos nosso projeto dentro do diretório **fpga** que se encontra na estrutura de arquivos do repositório. Chamaremos nosso projeto de `pipemult`, o qual também será o nome da nossa módulo _top-level_ dentro da hierarquia do projeto _(falaremos mais sobre isso depois)_. Notem que o último campo será preenchido automaticamente para você.

![Diretório, Nome do Projeto e módulo Top-level (Gif)](https://i.loli.net/2021/04/23/OS9QAJget1iM8ln.gif)

Na tela seguinte, você deve escolher se deseja iniciar um projeto vazio, ou se prefere iniciar a partir de um modelo de projeto, para o caso em que você tenha baixado um projeto de exemplo ou estiver trabalhando com uma placa de desenvolvimento. Nesse último caso, um modelo de projeto pode ajudar uma vez que já traz todas as configurações relacionadas à pinagem de entrada e saída e demais especificações da placa de desenvolvimento (apesar de nem sempre estarem disponíveis). Para o propósito desse tutorial, vamos criar um projeto vazio.

Agora você poderá adicionar arquivos ao seu projeto. No diretório `verilog`, vocês vão encontrar o nosso arquivo de exemplo. Adicione apenas o arquivo `ram.sv` clicando nos três pontos para navegar até a paster `verilog`, diretório onde serão armazenados todos os nossos arquivos SystemVerilog.

![Adicionar arquivos (Gif).](https://i.loli.net/2021/04/24/LbuoYA4z1ITCB5t.gif)

Na próxima página, você deve selecionar o dispositivo FPGA que irá programar. Você pode selecionar a família do dispositivo e sua categoria. Além disso é possível ainda filtrar por tipo de encapsulamento (_Package_), quantidade de pinos (_Pin count_), ou _Core speed grade_. Você também pode buscar por um dispositivo informando o nome do impresso no encapsulamento do dispositivo FPGA. Além disso, você pode escolher o dispositivo FPGA de acordo com uma determinada placa de desenvolvimento, clicando na aba **Board**. Vamos selecionar o _chip_ que compõe a plataforma de desenvolvimento [Terasic DE2-115](http://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&CategoryNo=139&No=502), usada nos laboratórios de GCET231. Para isso, na janela **Family, Device & Board Settings**, escolha a família `Cyclone IV E` e o dispositivo `EP4CE115F29C7`. Em seguida, clique em **Next**.

![Configurações de Família, Dispositivo e Placa (Gif).](https://i.loli.net/2021/04/24/xfmVHFIG9rRckKQ.gif)

Na próxima página, você pode escolher as ferramentas e configuração para a simulação, síntese a análise do projeto. Essas ferramentas podem ser adicionadas ou modificadas depois que seu projeto estiver criado. Por enquanto vamos manter as configurações padrão da ferramenta e seguir adiante, clicando em **Next**. A página final do assistente apresenta um resumo de todas as configurações definidas por você. Tire um tempo para analisar as suas configurações e então clique em **Finish** para criar seu projeto.

| [Introdução](../pages/megawizard.md) | [Explorando o Projeto Recém Criado](project.md) |
| :----------------------------------- | ----------------------------------------------: |

