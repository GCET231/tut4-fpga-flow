# Introdução

Nesse tutorial, você irá aprender a criar um projeto no **Intel Quartus Prime**, passando por todas as etapas do fluxo de projeto FPGA. O tutorial irá apresentar as ferramentas de projeto, mapeamento, síntese e prototipagem. Este tutorial leva em consideração que você já possui o Intel Quartus Prime instalado em seu ambiente de desenvolvimento e já completou os tutoriais referentes ao Git e Verilog.

O diagrama a seguir ilustra as etapas do fluxo de projeto do Intel Quartus Prime, e que será utilizada durante o semestre. Note que nem todas as etapas serão sempre e que algumas delas podem demandar de outras ferramentas de software.

<p align="center" width="100%">
  <img width="33%" src="../assets/fig/blockdiagram-quartus-flow.png">
</p>

1. O circuito começa com a etapa de entrada (_Design Entry_). Veremos que é possível usar o assistente _New Project Wizard_ do Quartus Prime para criar um novo projeto, e quais são os principais elementos de customização para um projeto FPGA. Você pode expressar um projeto usando vários métodos de entrada. Entretanto, nos nossos projetos usaremos uma linguagem de descrição de hardware - HDL (Verilog, SystemVerilog ou VHDL), juntamente com o uso de núcleos de Propriedade Intelectual (IP-_cores_) desenvolvidos especialmente para o uso em FPGAs Intel. Com isso, desenvolveremos um circuito digital simples usando Verilog.

2. O processo continua com a simulação, etapa que tem como objetivo verificar se a lógica foi implementada como esperado. O Quartus Prime possui suporte para ambas as simulações, RTL e pós-síntese (_gate level simulation_). Nos nossos projetos utilizamos o ModelSim Intel Starter Edition (SE) para realizar nossas simulações. Esse processo pode ser realizado por intermédio do Quartus Prime, usando a ferramenta **NativeLink**, ou de forma independente, usando projetos do ModelSim Intel FPGA SE. O ModelSim é uma ferramenta de simulação que permite criar diagramas de tempo precisos para todos os sinais do projeto, bem como sinais de estímulo para teste e testbenchs automatizados em SystemVerilog.
3. A etapa de síntese (**Synthesis**) é realizada a partir da ferramenta de análise de síntese do Quartus Prime. Essa etapa é também chamada de mapeamento, e corresponde ao processo de síntese/mapeamento da lógica do circuito para elementos da arquitetura do dispositivo FPGA. Durante o mapeamento a ferramenta verifica por erros nos arquivos fonte e constrói uma base de dados que organiza todos os componentes do circuito em uma estrutura hierárquica. Essa estrutura é então sintetizada com o objetivo de otimizar a lógica dos circuitos. Por fim, a lógica do circuito é mapeada para recursos do dispositivo FPGA.
4. A etapa de **Fitter** é o principal desafio do projeto FPGA uma vez que ela tenta posicionar os elementos do circuito da maneira mais otimizada possível em termos de recursos lógicos. O Quartus Prime permite controlar o processo de _fitting_ escolhendo estratégias de posicionamento e roteamento com base em compromissos de projeto: balanceado, alto desempenho (velocidade), baixa potência, e menor área.
5. Após a etapa de _fitting_, o circuito pode ser analisando, tendo em vista verificar se o circuito corresponde ao esperado. O Quartus Prime possui várias maneiras de visualizar a representação dos diferentes aspectos do projeto através de figuras. Representações pictóricas do seu projeto podem ser obtidas por meio do **RTL Viewer**, ou do **Technology Map Viewer**, os quais podem servir para atestar se o seu projeto corresponde aos objetivos e às técnicas adotadas. Além disso, ajuda a desenvolver um senso intuitivo sobre o projeto, particularmente se você é um projetista mais experiente. O **Chip Planner**, apresenta uma imagem do _chip_ FPGA, mostrando a utilização de recursos do dispositivo. Essa visualização pode ser útil para localizar áreas problemáticas durante a depuração.
6. Outra maneira de analisar um circuito é a partir do processo de análise temporal (**Timing Analysis**). Sincronização é fundamental para manutenção da confiabilidade de projetos FPGA. Neste sentido, a Análise Temporal Estática (_Static Timing Analysis_) pode determinar se há alguma violação entre os requisitos temporais relativos ao clock. A ferramenta **TimeQuest** utiliza um conjunto de equações para calcular os atrasos, bem como para determinar a frequência máxima de operação de um circuito.

Antes de começarmos, certifique-se de obter todos os arquivos deste repositório. Recomendo que você crie um diretório dentro da pasta da disciplina na qual você irá armazenar os arquivos deste e dos próximos tutoriais. Em uma janela do terminal terminal digite o comando a seguir para clonar o diretório do tutorial.

`git clone https://github.com/GCET231/tut4-fpga-flow.git`

![Clonando o repositório.](https://i.loli.net/2021/04/23/ABKdiQ8GFkjoNCl.gif)

Se preferir, você pode fazer o download dos arquivos clicando em **Code** e em seguida **Download ZIP**. Salve o arquivo e descompacte-o dentro da pasta criada para realização destes tutoriais.

![Baixando o ZIP do repositório](https://i.loli.net/2021/04/24/qaBs7xjXLlVmJUF.gif)

| [Início](../index.md) | [Assistente de Criação de Projetos](../pages/megawizard.md) |
| :-------------------- | ----------------------------------------------------------: |
