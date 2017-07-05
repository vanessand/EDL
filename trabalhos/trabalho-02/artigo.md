# A linguagem de programação C#

 ### Origem

Em 1999, a Microsoft utilizava a linguagem Java, mas ela não se comunicava bem com as bibliotecas de código nativo do Windows. Para solucionar esse problema, a Microsoft implementou o J++, que era a linguagem Java acrescida das extensões proprietárias do código nativo. 

O J++ violava o contrato que a Microsoft tinha com a Sun (proprietária do Java na época). Isso gerou uma das batalhas judiciais mais conhecidas nesse ano, na qual a Microsoft perdeu. Sem o J++, ela teve que se inovar: criar uma nova linguagem para atender todos os seus requisitos. Eis que surge o C#, por meio de um projeto chamado COOL - C like Object Oriented Language, chefiado por Anders Hejlserg (desenvolvedor da famosa Delphi). 

 O C# foi baseado não só no Java, mas também no próprio C, C++, Smalltalk, Delphi e VB. A ideia de se basear em tantas linguagens era incorporar soluções para os problemas existentes nelas.
O projeto final foi lançado em 2002: C# 1.0 junto com o ambiente .Net 1.0. Hoje em dia, o C# está na versão 6.0 e o.Net na versão 4.6.2.
---------------------------------------------------------------------------
 ### 	Classificação

C# é uma linguagem de programação interpretada, multi-paradigma, orientada a objetos e de tipagem forte. 

O código fonte é compilado para Common Intermediate Language (CIL) que é interpretado pela máquina virtual Common Language Runtime (CLR). 

C# é uma das linguagens projetadas para funcionar na Common Language Infrastructure da plataforma .NET Framework. 

---------------------------------------------------------------------------
 ### 	Comparações

A sintaxe de C# é altamente expressiva, simples e fácil de aprender. Ela será instantaneamente reconhecível para qualquer pessoa familiarizada com C, C++ ou Java.

Mesmo sendo muito legível, particularmente, considero o Java mais legível que o C#. Por exemplo, seus comandos de get ficam mais explícitos como podemos ver na comparação abaixo:


##### Java:

```sh
public class cliente() {
    private long id;
    public long getId(){
         return id;
    }
    public void setId(long id){
        this.id=id;
    }
}
```

##### C#:

```sh
public class cliente {
       private long id (get; set;)
}
```
>


No Java se escreve mais do que no C#, ou seja, o C# tem maior writability. E o Java tem maior redability, pois fica mais legível seus comandos.

Já o C++ tem menos escrita que o C#, com isso podemos dizer que o C++ tem maior writability. Porém, o C# é mais legível que o C++, por ser mais explicativo em seus comandos. Ou seja, o C# tem maior readability que o C++.

Vejamos a comparação abaixo:


##### C++:

```sh
int main (void)
{
    for (int i=1; i<=100; i++)
        cout << i <<"\t";  
		
}
```

##### C#:
```sh
class Test
{
    static void Main() {
        for (int i = 1; i <= 5; i++){
               Console.WriteLine(i);
         }
    }
}
```

    
O C# possui um tipo de variável chamada auto-property: sua declaração pode ser especificada com get/set, ao invés de ter que criar métodos de get e set para cada variável como é feito no Java. Elas também já podem ser inicializadas na sua própria declaração, sem precisar criar um construtor para isso.

Além disso, temos o parâmetro chamado readonly, que determina que a variável só pode ser lida e nunca sobrescrita. Ele serve para não se declarar a variável sem o set. Na última versão do C# já podemos declarar com ou sem set, sem precisar criar um atributo readonly específico.


---------------------------------------------------------------------------

### •	Representatividade: 
| C# | versus | Java |
| ------ | ------ | ------ |

Como referenciado antes, no C# temos as auto-properties, além da definição de métodos em forma de expressão, que são bastante representativos. Vejamos a abaixo:

  ##### 1)	Auto-propriedades: As variáveis podem ser criadas com seus métodos de acessibilidade declarados e sua inicialização feita na mesma linha de código: a definição.  Essas variáveis são chamadas de auto-propriedades.

##### C#:
```sh
public class Aluno

{
    public string Nome { get; } = "Vanessa";
    public int Nota { get; set; } = 10;
}

```

#### Java:
```sh
public class Aluno(){
    public String nome;
    public Int idade;
    Aluno(){
         nome = "Vanessa";
         this.nota = 10;
    }
   public string getNome(){
         return nome;
    }
    public void setNota(int nota){
          this.nota = nota;
    }
    public int getNota(){
          return nota;
    }
}
```

  ##### 2)	Métodos em forma de expressão: Métodos podem ser definidos em uma só linha de código, indicando nome, tipo, corpo e o retorno em si. 

#### C#:
```sh
    public static string verNotaAluno(Aluno aluno) => aluno.Nome + " Nota: " + aluno.Nota;
```

#### Java:
```sh
public static string verNotaAluno(Aluno aluno){
    return aluno.getNome() + " Nota: " + aluno.getNota;
}
```

> Vejamos o programa completo em C#:
---------------------------------------------------------------------------

```sh
using System;
namespace projeto1
{
    class Aluno
    {
        public string nome { get; set; } 
        public string matricula { get; } = "20162"; //Inicializando uma variável em sua declaração
        public int nota { get; set; }
        public string verNotaAluno() => "Nome: " + nome + "\n" + "Nota: " + nota;
        public void notaFinal(){
            if (nota >= 7){
                Console.WriteLine("A aluna {0} está aprovada!", nome);
            }
            else{
                Console.WriteLine("A aluna {0} está reprovada.", nome);
            }
        } 
    static void Main(string[] args)
    {
            Aluno vanessa = new Aluno();
            vanessa.nome="Vanessa";
            vanessa.nota=7;
            Console.WriteLine("O aluno foi criado! Matrícula: " +    vanessa.matricula);
            Console.WriteLine(vanessa.verNotaAluno());
            vanessa.notaFinal();
        }
    }
}
```


#### Output:
```sh
O aluno foi criado! Matrícula: 20162
Nome: Vanessa
Nota: 7 
A aluna Vanessa está aprovada! 
```
---------------------------------------------------------------------------
 ### Expressividade
 
 Sendo C# uma linguagem Orientada a Objetos, a compreensão do seu código fica mais simples; pois ele tem toda uma estrutura com seus namespaces, classes e funções que trabalham em conjunto para ser uma ótima opção para quem quer começar.
 
 Além disso, a linguagem possui diferenciais. Vejamos um diferencial descrito abaixo:
##### Delegates

Os delegates são tipos da linguagem c# que permitem que façamos uma referência para métodos. O principal uso de delegates é o de definir funções em tempo de execução.

Em outra palavras, uma variável inteira aceita inteiros, um delegate aceita métodos. Isso quer dizer que podemos guardar em nossos delegates métodos. E com isso podemos executá-los no momento que desejarmos, em tempo de execução.

A sintaxe da declaração de um delegate é a seguinte:

><Modificador de acesso> <Tipo de Retorno> delegate <Nome do Delegate>([Parametros]);

A declaração de um delegate, assemelha-se muito a uma assinatura de um método, com exceção da palavra-chave “delegate”. Os parâmetros são opcionais, mas caso necessário, podem ser adicionados à assinatura do seu delegate. Ao declarar um delegate, temos um novo tipo de “dados” que possibilita guardar referências de métodos com a mesma assinatura.

Um exemplo:

```sh
public delegate void HTTPRequestsHandler(string url);

class Exemplo {
     public HTTPRequestsHandler handler = (string url) => WriteLine(url); // só um exemplo
}

var x = new Exemplo();
x.handler("http://dominio.br/pagina.html"); //escreve isto pulando uma linha

x.handler = (string url) => Write(url); //muda o corpo do delegate em execução
x.handler("http://dominio.br/pagina.html"); //escreve isto sem pular a linha
```


Quando criamos um delegado estamos dizendo ao código que vamos ter ali algo que precisa ser executado, mas ainda não sabemos exatamente o que. Só sabemos como deverá ser feita a chamada. Como a forma apresentada é somente a declaração do delegado, consta apenas da assinatura do método esperado. Isto é importante para o compilador saber como tratar aquele delegado específico. 

Com isto, toda vez que uma variável for criada usando este tipo, ele saberá como invocar o método de forma adequada de acordo com a assinatura fornecida. A variável irá armazenar uma referência para um método concreto criado em algum momento no desenvolvimento da aplicação. Quando atribuímos um código à variável que será a delegada estamos definindo seu valor. Ou seja estamos apontando um comportamento específico que valerá até que outro código mude o apontamento.

No momento que fazemos uma chamada de método através desta variável delegada, estamos executando o código que está apontado por ela.

Uma interface se assemelha muito com um delegado, só que a interface concretiza o método de forma fixa e definida em tempo de compilação. O delegado pode ser definido em tempo de execução (mesmo que o código em si a ser executado também seja definido em tempo de compilação).

Atualmente, em C#, a função Lambda é mais utilizada - que é uma função anônima com uma sintaxe mais simples e que, em geral, dispensa a declaração do delegado -. Isto não quer dizer que ele não exista, apenas que não é preciso escrevê-lo. O compilador infere a assinatura daquele método e cria o delegado para o desenvolvedor.


---------------------------------------------------------------------------
 ### Conclusão

O C# é uma linguagem altamente expressiva. Conforme vimos nos exemplos dados nesse artigo, seu código é facilmente legível até para uma pessoa não muito conhecedora de linguagens de programação. Escrevê-lo também não é complicado e caso tenhamos algum problema no desenvolvimento, os mecanismos de pesquisa estão cheios de respostas e sugestões para ajudar e aprender C#.

Se C# fosse ser definido em uma palavra seria: praticidade. Ele foi criado com o intuito de ser mais prático que outras linguagens, mais eficiente, mais rápido e mais integrado. Há 15 anos seu objetivo vem sendo atingido. Aprender C# é um ótimo investimento.

---------------------------------------------------------------------------
 ### Referências Bibliográficas

* [Apostila C#](https://www.caelum.com.br/apostila-csharp-orientacao-objetos/)
* [Blog Caelum](http://blog.caelum.com.br/novidades-do-c-6-0/)
* [Comparação Java e C#](http://www.linhadecodigo.com.br/artigo/1620/java-e-csharpnet-um-breve-e-introdutorio-estudo-comparativo-de-suas-sintaxes-e-convencoes.aspx)
* [Site do C#](https://docs.microsoft.com/pt-br/dotnet/articles/csharp/csharp)
* [Wikipedia](https://pt.wikipedia.org/wiki/C_Sharp)
* [O que são Delegates?](http://www.frameworksystem.com/o-que-sao-delegates-c-net1/)
* [Como Usar Delegates](https://pt.stackoverflow.com/questions/101238/quando-e-onde-usar-um-delegate-no-c)
