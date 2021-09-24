# Expandindo o Projeto usando SystemVerilog

Na criação de projetos FPGA no Quartus Prime, é possível utilizar diversos métodos, incluindo a importação de blocos IP, HDL (Verilog, SystemVerilog e VHDL), entrada de máquina de estado e importação de arquivos EDIF. Vamos agora demonstrar como selecionar um desses métodos no desenvolvimento de um projeto digital. Para concluir essa etapa, apesar de não ser fundamental, é importante que você tenha concluído o tutorial sobre Verilog uma vez que não é nosso objetivo aqui explicar os comandos a medida em que eles são apresentados.

### Criando um novo arquivo

Para criar um novo arquivo, clicamos no menu **File** e então **New File...**. O Quartus Prime suporta vários formatos de arquivo diferentes para entrada de arquivos. Para entradas baseadas em código, usando HDL, ele suporta todos os padrões VHDL ou Verilog e grande parte das extensões SystemVerilog. Para entrada baseada em esquema, ele inclui um editor esquemático que pode ser usado para criar diagramas de blocos ou diagramas de circuitos. Você pode ainda criar máquinas de estado usando o editor de máquina de estado. O Quartus Prime também inclui também um editor de memória para criar arquivos hexadecimais padrão Intel, ou Memory Initialization Files (MIF) para inicializar RAMs ou ROMs em seu projeto. Você também pode importar arquivos EDIF de ferramentas de terceiros e do Quartus Prime. Ao longo deste tutorial, utilizamos apenas entradas a partir de arquivos de código Verilog e SystemVerilog.

Vamos criar um novo arquivo no formato SystemVerilog HDL. Para isso, nós devemos selecionar a opção **SystemVerilog HDL File** na caixa de diálogo de criação de novo arquivo, e em seguida clicar em **OK**. Em seguida, salve o novo arquivo clicando no menu **File** e em seguida **Save as...** Certifique-se de escolher o diretório `verilog` como destino e salve o arquivo com o nome `pipemult.sv`, se o nome já não tiver sido preenchido para você. Esse será usado para especificar nosso componente _top-level_. Falaremos sobre ele logo mais adiante neste tutorial. Nós criaremos todo o nosso circuito usando o editor de código incluído no Quartus Prime. Com esse editor você pode tirar proveito de todos os recursos das linguagens HDL.

![Novo arquivo SystemVerilog HDL (/Users/joaocarlos/Code/GCET231/tut4-fpga-flow/docs/assets/fig/create_new_file.gif)](assets/fig/create_new_file.gif)

Se preferir, a medida em que for se ambientando com a ferramenta, poderá utilizar seu editor de texto preferido. Nesse caso, usar o Quartus Prime ainda será necessário para realizar a compilação, mapeamento e programação dos dispositivos FPGA.

### Arquitetura do circuito

O diagrama abaixo ilustra a estrutura do circuito que iremos desenvolver ao longo desse tutorial. O nosso circuito possui duas entradas de dados de 8 bits `dataa` e `datab`, as quais serão operadas sobre um multiplicador simples para números sem sinal. O circuito possui ainda duas entradas de endereço de memória. A entrada `wraddr` é usada para escrita, enquanto `rdaddr` é utilizada como endereço de leitura da memória. Finalmente, nosso circuito possui ainda um sinal de habilitação da escrita na memória, nomeado como `wren`.

![Diagrama de blocos](/Users/joaocarlos/Code/GCET231/tut4-fpga-flow/docs/assets/fig/block_diagram.png)

Para implementar a funcionalidade do nosso circuito nós precisamos de um multiplicador $8\times8$ e uma memória RAM $32\times16$ (32 posições de 16 bits). A saída da memória é ligada a um registrador de 16 bits, conectado ao sinal `q`, única saída do circuito proposto.

### Introdução ao Quartus Prime MegaWizard

Você também pode introduzir blocos de IP em seus projetos. Um bloco IP é uma estrutura pré-definida que pode ser personalizada dentro do Quartus Prime. Um IP pode representar qualquer componente, desde elementos de lógica simples até blocos mais complicados, como controladores DDR, memórias ou PLL. A maior parte dos IPs disponíveis no catálogo do Quartus Prime são gratuitos. Vamos criar um multiplicador personalizado a partir do catálogo de IP do Quartus Prime. Se a janela **IP catalog** não estiver visível, selecione-a no menu **Tools**, ou no menu **View**.

![Visualizar catálogo de IPs (/Users/joaocarlos/Code/GCET231/tut4-fpga-flow/docs/assets/fig/open_ip_catalog.gif)](assets/fig/open_ip_catalog.gif)

Na janela **IP Catalog**, localizada à direita da janala principal do Quartus Prime, na opção **Library**, procure por **Basic Functions** `→` **Arithmetic** e selecione o IP **LPM_MULT** clicando duas vezes no nome. Na caixa de diálogo **Save IP Variation**, exibida em seguida, especifique o nome do arquivo de variação IP como `mult`, adicionando `mult` ao final do caminho do arquivo, o qual deve corresponder ao diretório do projeto. Selecione a opção Verilog em **IP variarion file type** e pressione **OK**.

![Criando novo IP LPM_MULT (/Users/joaocarlos/Code/GCET231/tut4-fpga-flow/docs/assets/fig/create_lpm_mult.gif).](assets/fig/create_lpm_mult.gif)

A caixa de diálogo de parâmetros MegaWizard para o multiplicador LPM deve abrir. Na primeira parte, defina a largura dos barramentos `dataa` e `datab` da memória para oito bits e mantenha os padrões para todas as outras configurações. Em seguida, clique em **Next**.

![Parameter Settings LPM MULT (/Users/joaocarlos/Code/GCET231/tut4-fpga-flow/docs/assets/fig/lpm_parameter.png).](assets/fig/lpm_parameter.png)

Na próxima página, note que há algumas opções de configuração importantes. A primeira delas permite que definamos um valor padrão para a entrada `datab`. Em seguida, é possível escolher entre multiplicações com números sem sinal (_unsigned_) ou com sinal (_signed_). Por último, encontramos a opção para usar elementos lógicos ou multiplicadores dedicados para implementar o nosso circuito. Vamos usar as configurações padrão do Quartus Prime. Deixe as caixas de seleção com os valores definidos e clique em **Next**.

![Parameter Settings LPM MULT (/Users/joaocarlos/Code/GCET231/tut4-fpga-flow/docs/assets/fig/lpm_parameter_2.gif).](assets/fig/lpm_parameter_2.gif)

Na próxima página, selecione a opção **Yes, I want output latency** e especifique 2 (dois) na caixa de texto **clock cycles**. Clique em **Next** para continuar. Essa configuração fará com que o Quartus Prime explore o paralelismo para acelerar a execução da operação de multiplicação. Especificamente, estamos usando os dois registradores presentes nos circuitos multiplicadores presentes dentro do dispositivo FPGA.

![Parameter Settings LPM MULT (/Users/joaocarlos/Code/GCET231/tut4-fpga-flow/docs/assets/fig/lpm_parameter_3.gif).](assets/fig/lpm_parameter_3.gif)

Novamente, nas configurações de EDA, clique em **Next** para continuar. Na página de resumo -- última página do MegaWizard -- certifique-se de marcar a caixa de seleção correspondente ao item `mult_inst.v`. Isso fará com que o assistente produza, entre suas saídas, um arquivo de modelo de instanciação Verilog que será útil logo mais. Clique em **Finish** para criar o seu multiplicador. Se o assistente perguntar se você deseja adicionar o arquivo IP ao projeto, clique em **Yes**.

![Parameter Settings LPM MULT (/Users/joaocarlos/Code/GCET231/tut4-fpga-flow/docs/assets/fig/lpm_parameter_4.gif).](assets/fig/lpm_parameter_4.gif)

Agora, se você olhar para a guia arquivos no navegador do projeto, você deve ver um novo arquivo chamado `mult.qip` na lista de arquivos do **Project Navitator**. Clique no símbolo `+` ao lado do nome do arquivo e veja o que surge.

![Exibindo novo arquivo mult.qip (/Users/joaocarlos/Code/GCET231/tut4-fpga-flow/docs/assets/fig/show_mult_quip.gif).](assets/fig/show_mult_quip.gif)

Abra o arquivo `mult.v`e note como sua estrutura é definida. Um bloco de IP é uma estrutura pré-definida presentes nas bibliotecas de síntese do dispositivo FPGA. Em geral, essas estruturas são especificadas na forma de componentes do dispositivo FPGA. Isso quer dizer que você não pode visualizar sua descrição comportamental.

```verilog
module mult (
	clock,
	dataa,
	datab,
	result);

	input	  clock;
	input	[7:0]  dataa;
	input	[7:0]  datab;
	output	[15:0]  result;

	wire [15:0] sub_wire0;
	wire [15:0] result = sub_wire0[15:0];

	lpm_mult	lpm_mult_component (
				.clock (clock),
				.dataa (dataa),
				.datab (datab),
				.result (sub_wire0),
				.aclr (1'b0),
				.clken (1'b1),
				.sclr (1'b0),
				.sum (1'b0));
	defparam
		lpm_mult_component.lpm_hint = "MAXIMIZE_SPEED=5",
		lpm_mult_component.lpm_pipeline = 2,
		lpm_mult_component.lpm_representation = "UNSIGNED",
		lpm_mult_component.lpm_type = "LPM_MULT",
		lpm_mult_component.lpm_widtha = 8,
		lpm_mult_component.lpm_widthb = 8,
		lpm_mult_component.lpm_widthp = 16;


endmodule
```

> **_Faça você mesmo:_** Analise o código acima e identifique as opções de configuração que você definiu usando o assistente MegaWizard. Essas configurações estão presentes no comando `defparam`. O que acha que acontecerá se você alterar os valores de configuração diretamente no arquivo `mult.v`?

### Criando módulo Top-Level

Agora que já temos os módulos necessários para a criação do nosso projeto vamos retornar ao nosso arquivo `pipemult.sv`. Caso o arquivo não esteja aberto, clique duas vezes em `pipemult` na janela do **Project Navigator**. Começaremos escrevendo o código que representa a interface de entrada e saída do nosso módulo `pipemult`. Copie o trecho a seguir para o arquivo `pipemult.sv` e pressione as teclas `ctrl+s` para salvar as modificações.

```verilog
module pipemult (
  input [7:0] dataa,
  input [7:0] datab,
  input clk1,
  input [4:0] wraddr,
  input [4:0] rdaddr,
  input wren,
  output [15:0] q
);

  // -------------------------------------------------------------
  // Corpo do módulo.
  // -------------------------------------------------------------
  // Insira a seguir as delarações de sinais wire e reg
  // -------------------------------------------------------------


  // -------------------------------------------------------------
  // Insira a seguir as instâncias de descrições comportamentais.
  // -------------------------------------------------------------

endmodule
```

Agora, em seu editor preferido, abra o arquivo `mult_inst.v`, copie o conteúdo e cole-o na posição indicada do arquivo `pipemult.sv`. Substitua as entradas de clock e dados de modo que elas correspondam aos sinais especificados nas entradas do módulo `pipemult`. Por enquanto, vamos deixar o sinal `result` conectado a um sinal desconhecido. Trataremos dele logo em seguida. Se necessário utilize o trecho de código à seguir.

```verilog
mult mult_inst (
   .clock ( clk1 ),
   .dataa ( dataa ),
   .datab ( datab ),
   .result ( result_sig )
);
```

Vamos fazer o mesmo para o bloco `ram.sv`. Nesse caso, como não temos um modelo de instanciação para este componente, vamos extraí-lo a partir da declaração das suas portas de entrada e saída. Antes disso, precisamos criar o sinal que fará a ligação entre o módulo `mult` e o módulo `ram`. Podemos fazer isso declarando um sinal do tipo `wire`. Usaremos o nome já definido no modelo de instanciação do módulo `mult`. Copie a declaração a seguir e cole no arquivo `pipemult.sv` na posição indicada nos comentários.

```verilog
wire [15:0] result_sig;
```

A instanciação do módulo `ram` deve se parecer com o código a seguir. Notem que usamos as entradas do módulo `pipemult` como nossas entradas de endereço de escrita (`wraddr`) e leitura (`rdaddr`), clock da memória (`clk1`), além do sinal de habilitação de escrita na memória (`wren`). Perceba ainda, que ligamos a saída do módulo multiplicador (`result`) à entrada de dados da memória (`data`) através do sinal `result_sig`. Nossa memória será configurada como uma RAM síncrona de porta única com 32 posições com 16 bits. Utilize o modelo de a seguir e posicione-o após a instanciação do módulo `mult`.

```verilog
ram #(
  .DATA_WIDTH(16),
  .ADDR_WIDTH(5)
) ram_inst (
  .data(result_sig),
  .wraddr(wraddr),
  .rdaddr(rdaddr),
  .we(wren),
  .clk(clk1),
  .q(q_sig)
);
```

Para finalizar a especificação do nosso circuito, precisamos implementar um registrador de saída da memória, assim como apresentado no diagrama da arquitetura do circuito. Para isso, crie um novo arquivo, clicando no menu **File** `→` **New** e, em seguida, escolha **SystemVerilog HDL File**. Salve-o com o nome `d_ff.sv`. Em seguira, copie o trecho de código a seguir e pressione `ctrl+s` para salvar o arquivo.

```verilog
module d_ff (
  input clk,
  input [15:0] d,
  output reg [15:0] q
);

  always@(posedge clk) begin
    q <= d;
  end
endmodule
```

![Criando arquivo dff.v (/Users/joaocarlos/Code/GCET231/tut4-fpga-flow/docs/assets/fig/create_dff.gif)](assets/fig/create_dff.gif)

Vamos concluir a especificação HDL do nosso circuito instanciando o registrador e conectando-o à saída da memória RAM. Para isso, primeiro precisamos declarar o sinal que representa a ligação entre as instâncias dos módulos `ram` e `d_ff`. Para este propósito criaremos o sinal `q_sig`.

```verilog
wire [15:0] q_sig;
```

Agora podemos adicionar uma instância do nosso módulo `d_ff`, de acordo com o trecho de código a seguir.

```verilog
d_ff d_ff_inst (
  .clk( clk1 ),
  .d( q_sig ),
  .q( q )
);
```

Se você chegou até aqui, cumprindo todas as etapas descritas nesse tutorial, o código do módulo `pipemult` deve se parecer com o que é apresentado a seguir.

```verilog
module pipemult (
  input [7:0] dataa,
  input [7:0] datab,
  input clk1,
  input [4:0] wraddr,
  input [4:0] rdaddr,
  input wren,
  output [15:0] q
);

  // -------------------------------------------------------------
  // Corpo do módulo.
  // -------------------------------------------------------------
  wire [15:0] result_sig;
  wire [15:0] q_sig;

  mult mult_inst (
  	.clock ( clk1 ),
		.dataa ( dataa ),
		.datab ( datab ),
		.result ( result_sig )
	);

  ram #(
  	.DATA_WIDTH(16),
  	.ADDR_WIDTH(5)
  ) ram_inst (
    .data(result_sig),
    .wraddr(wraddr),
    .rdaddr(rdaddr),
    .we(wren),
    .clk(clk1),
    .q(q_sig)
  );

  d_ff d_ff_inst (
  	.clk( clk1 ),
  	.d( q_sig ),
  	.q( q )
  );

endmodule
```

Para garantir que não há erros de sintaxe ou semântica no seu código, o Quartus Prime possui uma ferramenta de análise específicamente elaborada com esse propósito. Para isso, clique no menu **Processing** e, em seguida, **Analyze Current File**. Faça isso para todos os arquivos que você criou, especialmente para o `pipemult.sv`.

![Analise de sintaxe e semântica do código (/Users/joaocarlos/Code/GCET231/tut4-fpga-flow/docs/assets/fig/analyze_code.gif).](assets/fig/analyze_code.gif)

Se tudo correr como esperado, você deve visualizar um conjunto de mensagens semelhante às que são apresentadas a seguir.

```
[...]
Info: Quartus Prime Analyze Current File was successful. 0 errors, 1 warning
	Info: Peak virtual memory: 659 megabytes
	Info: Processing ended: Mon Apr 26 11:32:26 2021
	Info: Elapsed time: 00:00:07
	Info: Total CPU time (on all processors): 00:00:25
```

Se algo der errado, você verá uma mensagem de erro destacada na cor vermelha. Se esse não foi o seu caso, parabéns, você concluiu a etapa de entrada de projeto do nosso experimento e poderá seguir adiante. Caso contrário, verifique qual foi o erro encontrado e tente solucioná-lo. Se necessário retorne algumas etapas do tutorial.

| [Explorando o Projeto Recém Criado](../pages/project.md) | [Expandindo o Projeto usando SystemVerilog](systemverilog.md) |
| :------------------------------------------------------- | -----------------------------------------------------------: |