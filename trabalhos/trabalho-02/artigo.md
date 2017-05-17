# A linguagem de programação C#

- #### Origem:


>    Em 1999, a Microsoft utilizava a linguagem Java, mas ela não se comunicava bem com as bibliotecas de código nativo do Windows. Para solucionar esse problema, a Microsoft implementou o J++, que era a linguagem Java acrescida das extensões proprietárias do código nativo. 

>    O J++ violava o contrato que a Microsoft tinha com a Sun (proprietária do Java na época). Isso gerou uma das batalhas judiciais mais conhecidas nesse ano, na qual a Microsoft perdeu. Sem o J++, ela teve que se inovar: criar uma nova linguagem para atender todos os seus requisitos. Eis que surge o C#, por meio de um projeto chamado COOL - C like Object Oriented Language, chefiado por Anders Hejlserg (desenvolvedor da famosa Delphi). 

>    O C# foi baseado não só no Java, mas também no próprio C, C++, Smalltalk, Delphi e VB. A ideia de se basear em tantas linguagens era incorporar soluções para os problemas existentes nelas.
O projeto final foi lançado em 2002: C# 1.0 junto com o ambiente .Net 1.0. Hoje em dia, o C# está na versão 6.0 e o.Net na versão 4.6.2.
---------------------------------------------------------------------------
- #### 	Classificação:

>    C# é uma linguagem de programação interpretada, multi-paradigma, orientada a objetos e de tipagem forte. 

>    O código fonte é compilado para Common Intermediate Language (CIL) que é interpretado pela máquina virtual Common Language Runtime (CLR). 

>    C# é uma das linguagens projetadas para funcionar na Common Language Infrastructure da plataforma .NET Framework. 


- #### 	Comparações:

>    A sintaxe de C# é altamente expressiva, simples e fácil de aprender. Ela será instantaneamente reconhecível para qualquer pessoa familiarizada com C, C++ ou Java.

>    Mesmo sendo muito legível, particularmente, considero o Java mais legível que o C#. Por exemplo, seus comandos de get ficam mais explícitos como podemos ver na comparação abaixo:


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


>    No Java se escreve mais do que no C#, ou seja, o C# tem maior writability. E o Java tem maior redability, pois fica mais legível seus comandos.

>   Já o C++ tem menos escrita que o C#, com isso podemos dizer que o C++ tem maior writability. Porém, o C# é mais legível que o C++, por ser mais explicativo em seus comandos. Ou seja, o C# tem maior readability que o C++.

>    Vejamos a comparação abaixo:


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

    
>    O C# possui um tipo de variável chamada auto-property: sua declaração pode ser especificada com get/set, ao invés de ter que criar métodos de get e set para cada variável como é feito no Java. Elas também já podem ser inicializadas na sua própria declaração, sem precisar criar um construtor para isso.

>    Além disso, temos o parâmetro chamado readonly, que determina que a variável só pode ser lida e nunca sobrescrita. Ele serve para não se declarar a variável sem o set. Na última versão do C# já podemos declarar com ou sem set, sem precisar criar um atributo readonly específico.

---------------------------------------------------------------------------

### •	Representatividade: 
| C# | versus | Java |
| ------ | ------ | ------ |

> Como referenciado antes, no C# temos as auto-properties, além da definição de métodos em forma de expressão, que são bastante representativos. Vejamos a abaixo:

*  ###### 1)	Auto-propriedades: As variáveis podem ser criadas com seus métodos de acessibilidade declarados e sua inicialização feita na mesma linha de código: a definição.  Essas variáveis são chamadas de auto-propriedades.

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

2)	Métodos em forma de expressão: Métodos podem ser definidos em uma só linha de código, indicando nome, tipo, corpo e o retorno em si. 

C#:

public static string verNotaAluno(Aluno aluno) => aluno.Nome + " Nota: " + aluno.Nota;


Java:

public static string verNotaAluno(Aluno aluno){

   return aluno.getNome() + " Nota: " + aluno.getNota;
   
}


Eis o programa completo em C#:

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



Output:


O aluno foi criado! Matrícula: 20162

Nome: Vanessa

Nota: 7 

A aluna Vanessa está aprovada! 



•	Referências Bibliográficas:


Apostila C#: <https://www.caelum.com.br/apostila-csharp-orientacao-objetos/>

Blog Caelum: <http://blog.caelum.com.br/novidades-do-c-6-0/>

Comparação Java e C#: <http://www.linhadecodigo.com.br/artigo/1620/java-e-csharpnet-um-breve-e-introdutorio-estudo-comparativo-de-suas-sintaxes-e-convencoes.aspx>

Site da linguagem: <https://docs.microsoft.com/pt-br/dotnet/articles/csharp/csharp>

Wikipedia: <https://pt.wikipedia.org/wiki/C_Sharp>
