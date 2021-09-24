# Explorando o Projeto Recém Criado

O único arquivo que você deve visualizar em seu projeto é aquele que adicionamos anteriormente (`ram.sv`). Entretanto, o Quartus Prime criou para você, dentro da pasta do projeto (`fpga`), um arquivo `.qpf` (**Quartus Project File**), usado para abrir o projeto. Além disso, o Quartus Prime criou também um arquivo `.qsf` (**Quartus Settings File**), o qual armazena todas as configurações de projeto e atribuições a pinos de entrada e saída.

![Projeto Criado (Gif)](https://i.loli.net/2021/04/24/Y2AibaCyGEqVvJn.gif)

Os arquivos com a extensão `.qsf` utilizam comandos na linguagem **Tcl** (pronuncia-se _tickle_) para configurar os projetos do Quartus Prime. Nesse arquivo você encontrará todas as configurações implementadas a partir da interface gráfica, em especial, aquelas que relacionam os pinos do FPGA com as portas de entrada e saída do seu circuito.

> **_Faça você mesmo:_** analise o código abaixo e tente identificar os elementos de configuração que você definiu usando o **New Project Wizard**. Observe cada linha de código para entender a sintaxe Tcl utilizada pelo Quartus Prime.

```tcl
set_global_assignment -name FAMILY "Cyclone IV E"
set_global_assignment -name DEVICE EP4CE115F29C7
set_global_assignment -name TOP_LEVEL_ENTITY pipemult
set_global_assignment -name ORIGINAL_QUARTUS_VERSION 20.1.0
set_global_assignment -name PROJECT_CREATION_TIME_DATE "14:48:46  APRIL 23, 2021"
set_global_assignment -name LAST_QUARTUS_VERSION "20.1.0 Lite Edition"
set_global_assignment -name SYSTEMVERILOG_FILE ../verilog/ram.sv
set_global_assignment -name PROJECT_OUTPUT_DIRECTORY output_files
```

O nome do projeto, definido na primeira etapa da criação do projeto, é exibido na barra de título superior do Quartus Prime. O módulo _top-level_ do projeto, por sua vez, aparece na guia **Hierarchy**, da janela **Project Navigator**.

![Aba Project Navigator (Gif)](https://i.loli.net/2021/04/24/8DPETpLHytlIkS7.gif)

Clique duas vezes no arquivo `ram.sv` para abri-lo no editor de texto do Quartus Prime. Caso não esteja visualizando o arquivo, na janela **Project Navigator**, escolha **File** na caixa de seleção. Por enquanto, você não precisa se preocupar com o funcionamento desse código aberto no editor de arquivos de texto. O editor de texto do Quartus Prime é um bom editor para códigos HDL. Ele possui numeração de linha, reconhecimento de sintaxe, além da possibilitar a inserção de modelos de função HDL, TCL ou mega-funções nos arquivos através de modelos.

![Abrindo o arquivo ram.sv (Gif)](https://i.loli.net/2021/04/24/j2lrTukVJx7DEeH.gif)

Use o botão **Insert template** para inserir modelos de funções e comandos nos arquivos de projeto. Explore as opções de modelo pois elas poderão ser úteis no futuro. Alguns exemplos interessantes de serem analisados são apresentadas a seguir.

- Verilog HDL `→` Full Designs `→` RAMs and ROMs
- Verilog HDL `→` Full Designs `→` State Machines
- Verilog HDL `→` Constructs `→` Sequential Statements

![Insert template (Gif)](https://i.loli.net/2021/04/24/9Qb6WM8mOKBgrjf.gif)

> _**Faça você mesmo:**_ explore a janela **Insert Template** e procure por modelos de implementação de funções básicas como declaração de sinais, DFF, Mutliplexadores, Memórias, etc. Faça isso tanto para os modelos nas linguagens Verilog HDL, SystemVerilog HDL e VHDL.



| [Assistente de Criação de Projetos](../pages/megawizard.md) | [Expandindo o Projeto usando SystemVerilog](systemverilog.md) |
| :---------------------------------------------------------- | -----------------------------------------------------------: |