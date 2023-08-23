//essa versão não possui ordem de precedencia com parenteses
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextStyle painel_style = TextStyle(fontSize: 40, color: Colors.white);
  String painel = '',
      operador = "",
      armazena = "",
      inverso = "",
      substring = "",
      temp = "",
      last = "";
  int aux = 0, pos = 0, pos_parentese = -1, ultimo = 0, posPE = 0, posPD = 0;
  double n1 = 0, n2 = 0, retorno = 0;
  bool porcentagem = false, esquerdo = true;

  void calcula(n1, n2, operador) {
    if (operador == "÷") {
      if (n2 != 0) {
        n1 = n1 / n2;
        if ((n1.toInt()) == n1) {
          //se o numero parcial for igual ao inteiro
          painel = (n1.toInt()).toString();
        } else
          painel = n1.toString().replaceAll(".", ",");
      } else {
        painel_style = TextStyle(fontSize: 28, color: Colors.white);
        painel = "Impossível dividir por 0";
      }
    } else if (operador == "x") {
      n1 = n1 * n2;
      if ((n1.toInt()) == n1) {
        armazena = (n1.toInt()).toString();
      }
    } else if (operador == "+") {
      n1 = n1 + n2;
      if ((n1.toInt()) == n1) {
        painel = (n1.toInt()).toString();
      } else {
        painel = n1.toString().replaceAll(".", ",");
      }
    } else if (operador == "-") {
      n1 = n1 - n2;
      if ((n1.toInt()) == n1) {
        painel = (n1.toInt()).toString();
      } else {
        painel = n1.toString().replaceAll(".", ",");
      }
    }
    retorno = n1; //serve para adicionar o resultado final a n1, pois não há como passar o valor por referência
  }

  String atualiza_painel(
      num1, num2, principal, armazena, String sinal, porcentagem) {
    //sinal == operador
    /*    
          verifica se os resultados são int/double. EX: Se o resultado for 2.0 ele será int, mas se for 2.1 será double.
          Depois de verificar, adiciona a sua forma correta a "prinicipal" substituindo o resultado da conta pelos valores usados para realizar a operação no painel.
    */
    principal = principal.replaceAll(",", ".");
    if (num1.toInt().abs() == num1.abs() && num2.toInt().abs() == num2.abs()) {
      //se num1 e num2 tiverem valores iguais nas formas int e double
      if (num1 >= 0 && num2 >= 0)
        principal = principal.replaceAll(
            "${num1.toInt()}${sinal}${num2.toInt()}", armazena);
      else if (num1 >= 0 && num2 < 0) {
        if (principal.contains("("))
          principal = principal.replaceAll(
              "${num1.toInt()}${sinal}(${num2.toInt()})", armazena);
        else
          principal = principal.replaceAll(
              "${num1.toInt()}${sinal}${num2.toInt()}", armazena);
      } else if (num1 < 0 && num2 >= 0) {
        if (principal.contains("("))
          principal = principal.replaceAll(
              "(${num1.toInt()})${sinal}${num2.toInt()}", armazena);
        else
          principal = principal.replaceAll(
              "${num1.toInt()}${sinal}${num2.toInt()}", armazena);
      } else if (num1 < 0 && num2 < 0) {
        if (principal.contains("("))
          principal = principal.replaceAll(
              "(${num1.toInt()})${sinal}(${num2.toInt()})", armazena);
        else
          principal = principal.replaceAll(
              "${num1.toInt()}${sinal}${num2.toInt()}", armazena);
      } else {
        if (principal.contains("("))
          principal = principal.replaceAll(
              "(${num1.toInt()})${sinal}(${num2.toInt()})", armazena);
        else
          principal = principal.replaceAll(
              "${num1.toInt()}${sinal}${num2.toInt()}", armazena);
      }
    } else if (num1.toInt().abs() == num1.abs() &&
        num2.toInt().abs() != num2.abs()) {
      //se num1 tiver valor igual na sua forma int e double, mas num2 não

      if (num1 >= 0 && num2 >= 0.0) {
        principal =
            principal.replaceAll("${num1.toInt()}${sinal}${num2}", armazena);
      } else if (num1 >= 0 && num2 < 0) {
        if (principal.contains("("))
          principal = principal.replaceAll(
              "${num1.toInt()}${sinal}(${num2})", armazena);
        else
          principal =
              principal.replaceAll("${num1.toInt()}${sinal}${num2}", armazena);
      } else if (num1 < 0 && num2 >= 0) {
        if (principal.contains("("))
          principal = principal.replaceAll(
              "(${num1.toInt()})${sinal}${num2}", armazena);
        else
          principal =
              principal.replaceAll("${num1.toInt()}${sinal}${num2}", armazena);
      } else if (num1 < 0 && num2 < 0) {
        if (principal.contains("("))
          principal = principal.replaceAll(
              "(${num1.toInt()})${sinal}(${num2})", armazena);
        else
          principal =
              principal.replaceAll("${num1.toInt}${sinal}${num2}", armazena);
      } else {
        if (principal.contains("("))
          principal = principal.replaceAll(
              "(${num1.toInt()})${sinal}(${num2})", armazena);
        else
          principal =
              principal.replaceAll("${num1.toInt()}${sinal}${num2}", armazena);
      }
    } else if (num1.toInt().abs() != num1.abs() &&
        num2.toInt().abs() == num2.abs()) {
      //se num2 tiver valor igual na sua forma int e double, mas num1 não
      if (num1 >= 0 && num2 >= 0)
        principal =
            principal.replaceAll("${num1}${sinal}${num2.toInt()}", armazena);
      else if (num1 >= 0 && num2 < 0) {
        if (principal.contains("("))
          principal = principal.replaceAll(
              "${num1}${sinal}(${num2.toInt()})", armazena);
        else
          principal =
              principal.replaceAll("${num1}${sinal}${num2.toInt()}", armazena);
      } else if (num1 < 0 && num2 >= 0) {
        if (principal.contains("("))
          principal = principal.replaceAll(
              "(${num1})${sinal}${num2.toInt()}", armazena);
        else
          principal =
              principal.replaceAll("${num1}${sinal}${num2.toInt()}", armazena);
      } else if (num1 < 0 && num2 < 0) {
        if (principal.contains("("))
          principal = principal.replaceAll(
              "(${num1})${sinal}(${num2.toInt()})", armazena);
        else
          principal =
              principal.replaceAll("${num1}${sinal}${num2.toInt()}", armazena);
      } else {
        if (principal.contains("("))
          principal = principal.replaceAll(
              "(${num1})${sinal}(${num2.toInt()})", armazena);
        else
          principal =
              principal.replaceAll("${num1}${sinal}${num2.toInt()}", armazena);
      }
    } else {
      //se num1 e num2 não tiver valor igual na sua forma int e double.
      if (num1 >= 0 && num2 >= 0)
        principal = principal.replaceAll("${num1}${sinal}${num2}", armazena);
      else if (num1 >= 0 && num2 < 0)
        principal = principal.replaceAll("${num1}${sinal}(${num2})", armazena);
      else if (num1 < 0 && num2 >= 0)
        principal = principal.replaceAll("(${num1})${sinal}${num2}", armazena);
      else if (num1 < 0 && num2 < 0)
        principal =
            principal.replaceAll("(${num1})${sinal}(${num2})", armazena);
      else {
        if (principal.contains("("))
          principal =
              principal.replaceAll("(${num1})${sinal}(${num2})", armazena);
        else
          principal = principal.replaceAll("${num1}${sinal}${num2}", armazena);
      }
    }
    return principal;
  }

  double retornaResultado(double qualquer) {
    //é usada para retornar o valor obtido na função calcula já que não da pra passar o valor por referencia
    return retorno;
  }

  void particiona(String principal) //essa função realiza a ordem de precedencia
  {
    int posicao = 0;
    double num1 = 0, num2 = 0;
    armazena = inverso = "";
    if (principal.contains(",")) principal = principal.replaceAll(",", ".");

    if (principal.contains("%")) {
      principal = principal.replaceAll("%", "÷100");
    }
    if (principal.contains("(")) {
      posPE = principal.indexOf("(");
      posPD = principal.indexOf(")");
      for (int i = posPE + 1; i < principal.length; i++) {
        if (principal[i] == ")")
          i = principal.length + 3;
        else if (principal[i] == "+" ||
            principal[i] == "÷" ||
            principal[i] == "%" ||
            principal[i] ==
                "x") //é pq tem conta a ser resolvida dentro dos parenteses
        {
          substring = principal.substring(posPE + 1, posPD);
          // " * " é uma chave de marcação
          temp = principal.replaceAll("(${substring})", "*");
          particiona(substring);
          principal = principal.replaceAll("*",
              painel); //ai chama a função que pega os numeros da operação, calcula eles
          i = principal.length + 3;
        } else if (principal[i] ==
            "-") //se tiver o "-" é feita uma análise para descobrir se é uma equação entre parenteses ou apenas um número
        {
          if (i - 1 ==
              posPE) // se a posição anterior de "-" for "(" é porque é um numero negativo
          {
            if (principal.indexOf("-", i + 1) ==
                -1) // se a nova busca pelo operador"-" for -1 é pq ele não existe
              i = principal.length + 3;
            else // se não, é chamado a função recursivamente e a substring recebe oque esta na equação dos "()"
            {
              substring = principal.substring(posPE + 1, posPD);
              // " * " é uma chave de marcação
              temp = principal.replaceAll("(${substring})", "*");
              particiona(substring);
              principal = principal.replaceAll("*", painel);
            }
          } else {
            substring = principal.substring(posPE + 1, posPD);
            // " * " é uma chave de marcação
            temp = principal.replaceAll("(${substring})", "*");
            particiona(substring);
            principal = principal.replaceAll("*", painel);
          }
          i = principal.length + 3;
        }
      }
    }
    // ------------------- Vamos dividir oque tiver pela frente ------------------- //
    while (
        principal.contains("÷") != false) // enquanto houver operador de divisão
    {
      posicao = principal.indexOf("÷");

      for (int i = posicao - 1; i >= 0; i--) {
        if (principal[i] == ")") {
          i--;
        }
        if (principal[i] == "-" && i - 1 >= 0) {
          if (principal[i - 1] == "(") {
            inverso += principal[i];
          }
          i = -1;
        } else if (principal[i] != "+" &&
            principal[i] != "÷" &&
            principal[i] != "%" &&
            principal[i] != "x") {
          inverso += principal[i];
        } else {
          i = -1;
        }
      }
      if (inverso.contains(",")) {
        inverso = inverso.replaceAll(",", ".");
      }
      for (int i = inverso.length - 1;
          i >= 0;
          i--) //pega o valor invertido e coloca em sua respectiva ordem
      {
        armazena += inverso[i];
      }
      num1 = double.parse(armazena);

      armazena = "";

      for (int i = posicao + 1; i < principal.length; i++) {
        if (principal[i] == "(") {
          i++;
        }
        if (principal[i] == ")") {
          i = principal.length + 5;
        } else if (principal[i] != "+" &&
            principal[i] != "÷" &&
            principal[i] != "%" &&
            principal[i] != "x") {
          armazena += principal[i];
        } else if (principal[i] == "-" && i - 1 >= 0) {
          if (principal[i - 1] == "(") {
            armazena += principal[i];
          }
        } else {
          i = principal.length + 5;
        }
      }

      if (armazena.contains(",")) {
        armazena = armazena.replaceAll(",", ".");
      }
      num2 = double.parse(armazena);

      calcula(num1, num2, "÷");
      armazena = painel;
      principal =
          atualiza_painel(num1, num2, principal, armazena, "÷", porcentagem);

      posicao = 0;
      num1 = num2 = 0;
      armazena = inverso = "";
    }
    while (principal.contains("x") !=
        false) // enquanto houver operador de multiplicação
    {
      posicao = principal.indexOf("x");
      //é criado um laço para pegar o valor de trás para frente, que está antes do sinal de multiplicação
      for (int i = posicao - 1; i >= 0; i--) {
        if (principal[i] == ")") {
          i--;
        }
        if (principal[i] == "-" && i - 1 >= 0) {
          if (principal[i - 1] == "(") {
            inverso += principal[i];
          }
          i = -1;
        } else if (principal[i] != "+" &&
            principal[i] != "÷" &&
            principal[i] != "%" &&
            principal[i] != "x") {
          inverso += principal[i];
        } else {
          i = -1;
        }
      }
      if (inverso.contains(",")) {
        inverso = inverso.replaceAll(",", ".");
      }
      for (int i = inverso.length - 1;
          i >= 0;
          i--) //pega o valor invertido e coloca em sua respectiva ordem
      {
        armazena += inverso[i];
      }
      num1 = double.parse(armazena);
      armazena = "";
      //outro laço é criado para pegar o valor na ordem normal que fica depois do sinal de multiplicação
      for (int i = posicao + 1; i < principal.length; i++) {
        if (principal[i] == "(") {
          i++;
        }
        if (principal[i] == ")") {
          i = principal.length + 5;
        } else if (principal[i] != "+" &&
            principal[i] != "÷" &&
            principal[i] != "%" &&
            principal[i] != "x") {
          if (principal[i] == "-") {
            if (principal[i - 1] != "(") {
              i = principal.length + 5;
            }
          }
          if (i < principal.length) armazena += principal[i];
        } else if (principal[i] == "-" && i - 1 >= 0) {
          if (principal[i - 1] == "(") {
            armazena += principal[i];
          }
        } else {
          i = principal.length + 5;
        }
      }

      if (armazena.contains(",")) {
        armazena = armazena.replaceAll(",", ".");
      }
      num2 = double.parse(armazena);

      calcula(num1, num2, "x"); //"armazena" já vai receber o resultado
      if (porcentagem == false) {
        principal =
            atualiza_painel(num1, num2, principal, armazena, "x", porcentagem);
      } //chama a função para atualizar o painel de forma correta
      else {
        painel = principal = armazena;
        porcentagem = false;
      }
      posicao = 0;
      num1 = num2 = 0;
      armazena = inverso = "";
    }
    // ------------------- Agora vamos somar oque tiver pela frente ------------------- //

    while (principal.contains("+") != false) {
      posicao = principal.indexOf("+");

      for (int i = posicao - 1; i >= 0; i--) {
        if (principal[i] == ")") {
          i--;
        }
        if (principal[i] == "-" && i - 1 >= 0) {
          if (principal[i - 1] == "(") {
            inverso += principal[i];
          }
          i = -1;
        } else if (principal[i] != "+" &&
            principal[i] != "÷" &&
            principal[i] != "%" &&
            principal[i] != "x" &&
            principal[i] != "(") {
          inverso += principal[i];
        } else {
          i = -1;
        }
      }
      if (inverso.contains(",")) {
        inverso = inverso.replaceAll(",", ".");
      }
      for (int i = inverso.length - 1; i >= 0; i--) {
        armazena += inverso[i];
      }
      num1 = double.parse(armazena);

      armazena = "";

      for (int i = posicao + 1; i < principal.length; i++) {
        if (principal[i] == "(") {
          i++;
        }
        if (principal[i] == ")") {
          i = principal.length + 5;
        } else if (principal[i] != "+" &&
            principal[i] != "÷" &&
            principal[i] != "%" &&
            principal[i] != "x") {
          armazena += principal[i];
        } else if (principal[i] == "-" && i - 1 >= 0) {
          if (principal[i - 1] == "(") {
            armazena += principal[i];
          }
        } else {
          i = principal.length + 5;
        }
      }

      if (armazena.contains(",")) {
        armazena = armazena.replaceAll(",", ".");
      }
      num2 = double.parse(armazena);
      calcula(num1, num2, "+");
      armazena = painel;

      principal =
          atualiza_painel(num1, num2, principal, armazena, "+", porcentagem);
      posicao = 0;
      num1 = num2 = 0;
      armazena = inverso = "";
    }

    // ------------------- Agora vamos subtrair oque tiver pela frente ------------------- //
    posicao = 1;
    while ((posicao != 0 && posicao != -1) && principal.contains("-")) {
      posicao = principal.indexOf("-");
      if (posicao == 0 || (posicao == 1 && principal[posicao - 1] == "(")) {
        posicao = principal.indexOf("-", posicao + 1);
      }
      if ((posicao >= 0 && posicao - 1 >= 0) &&
          principal[posicao - 1] !=
              "(") // garante que não pegou o sinal do numero ao invés do operador
      {
        for (int i = posicao - 1; i >= 0; i--) {
          if (principal[i] == ")") {
            i--;
          }
          if (principal[i] == "-" && i - 1 >= 0) {
            if (principal[i - 1] == "(") {
              inverso += principal[i];
            }
            i = -1;
          } else if (principal[i] != "+" &&
              principal[i] != "÷" &&
              principal[i] != "%" &&
              principal[i] != "x") {
            inverso += principal[i];
          } else {
            i = -1;
          }
        }
        if (inverso.contains(",")) {
          inverso = inverso.replaceAll(",", ".");
        }
        for (int i = inverso.length - 1; i >= 0; i--) {
          armazena += inverso[i];
        }
        num1 = double.parse(armazena);

        armazena = "";

        for (int i = posicao + 1; i < principal.length; i++) {
          if (principal[i] == "(") {
            i++;
          }
          if (principal[i] == ")") {
            i = principal.length + 5;
          } else if (principal[i] != "+" &&
              principal[i] != "÷" &&
              principal[i] != "%" &&
              principal[i] != "x") {
            armazena += principal[i];
          } else if (principal[i] == "-" && i - 1 >= 0) {
            if (principal[i - 1] == "(") {
              armazena += principal[i];
            }
          } else {
            i = principal.length + 5;
          }
        }

        if (armazena.contains(",")) {
          armazena = armazena.replaceAll(",", ".");
        }
        num2 = double.parse(armazena);
        calcula(num1, num2, "-");
        armazena = painel;
        principal =
            atualiza_painel(num1, num2, principal, armazena, "-", porcentagem);
        posicao = 0;
        num1 = num2 = 0;
        armazena = inverso = "";
      }
    }

    painel = principal;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          //Stack é usado para criar objetos um dentro do outro
          children: [
            //Positioned posiciona os numeros e operadores na tela
            Positioned(
              //Resultado
              top: 85,
              right: 48,
              left: 48,
              child: Container(
                child: Text(
                  "${painel}",
                  textDirection: TextDirection.ltr,
                  style: painel_style,
                ),
                alignment: Alignment.bottomRight,
                width: 345,
                height: 55,
              ),
            ),
            Positioned(
              //Limpar
              top: 180,
              left: 25,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    painel = "";
                    esquerdo = true;
                    n1 = 0;
                    n2 = 0;
                    painel_style = TextStyle(fontSize: 40, color: Colors.white);
                  });
                },
                child: Container(
                  child: Text(
                    "C",
                    style: TextStyle(fontSize: 38, color: Colors.black),
                  ),
                  alignment: Alignment.center,
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 170, 159, 159),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ),

            Positioned(
              //Parenteses
              top: 180,
              left: 110,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    String aux = painel;
                    if (esquerdo == true) //se for a vez de adc o esquerdo, isso é feito
                    {
                      painel += "(";
                      esquerdo = false;
                    } else {
                      painel += ")";
                      esquerdo = true;
                    }
                  });
                },
                child: Container(
                  child: Text(
                    "( )",
                    style: TextStyle(fontSize: 38, color: Colors.black),
                  ),
                  alignment: Alignment.center,
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 170, 159, 159),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 180,
              left: 195,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    porcentagem = true;
                    temp = painel.substring(0, painel.length - 1);
                    last = painel.substring(painel.length - 1);
                    pos = (painel.length) +
                        1; // pega a posição inicial do n2 a partir do n1 + o operador
                    //se já existir algum operador na ultima posição do painel ele é alterador pelo ultimo operador selecionado
                    if (last == "+" ||
                        last == "-" ||
                        last == "x" ||
                        last == "÷" ||
                        last == "%") {
                      painel = temp + "%";
                    } else
                      painel += "%";
                    temp = "";
                  });
                },
                child: Container(
                  child: Text(
                    "%",
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                  alignment: Alignment.center,
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 48, 44, 44),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ),
            Positioned(
              //divisao
              top: 180,
              right: 30,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    operador = "÷";
                    temp = painel.substring(0, painel.length - 1);
                    last = painel.substring(painel.length - 1);
                    pos = (painel.length) +
                        1; // pega a posição inicial do n2 a partir do n1 + o operador
                    //se já existir algum operador na ultima posição do painel ele é alterador pelo ultimo operador selecionado
                    if (last == "+" ||
                        last == "-" ||
                        last == "x" ||
                        last == "÷" ||
                        last == "%") {
                      painel = temp + operador;
                    } else
                      painel += "÷";
                    temp = "";
                  });
                },
                child: Container(
                  child: Text(
                    "÷",
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                  alignment: Alignment.center,
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(214, 255, 143, 51),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ),
            Positioned(
              //multiplcação
              top: 260,
              right: 30,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    operador = "x";
                    temp = painel.substring(0, painel.length - 1);
                    last = painel.substring(painel.length - 1);
                    pos = (painel.length) +
                        1; // pega a posição inicial do n2 a partir do n1 + o operador
                    //se já existir algum operador na ultima posição do painel ele é alterador pelo ultimo operador selecionado
                    if (last == "+" ||
                        last == "-" ||
                        last == "x" ||
                        last == "÷" ||
                        last == "%") {
                      painel = temp + operador;
                    } else
                      painel += "x";
                    temp = "";
                  });
                },
                child: Container(
                  child: Text(
                    "x",
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                  alignment: Alignment.center,
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(214, 255, 143, 51),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ),
            Positioned(
              //Subtração
              top: 340,
              right: 30,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    ultimo = painel.length - 1;
                    operador = "-";
                    temp = painel.substring(0, painel.length - 1);
                    last = painel.substring(painel.length - 1);
                    pos = (painel.length) +
                        1; // pega a posição inicial do n2 a partir do n1 + o operador
                    //se já existir algum operador na ultima posição do painel ele é alterador pelo ultimo operador selecionado
                    if (last == "+" ||
                        last == "-" ||
                        last == "x" ||
                        last == "÷" ||
                        last == "%") {
                      painel = temp + operador;
                    } else
                      painel += "-";
                    temp = "";
                  });
                },
                child: Container(
                  child: Text(
                    "-",
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                  alignment: Alignment.center,
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(214, 255, 143, 51),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ),
            Positioned(
              //Adição
              top: 420,
              right: 30,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    operador = "+";
                    temp = painel.substring(0, painel.length - 1);
                    last = painel.substring(painel.length - 1);
                    pos = (painel.length) +
                        1; // pega a posição inicial do n2 a partir do n1 + o operador
                    //se já existir algum operador na ultima posição do painel ele é alterador pelo ultimo operador selecionado
                    if (last == "+" ||
                        last == "-" ||
                        last == "x" ||
                        last == "÷" ||
                        last == "%") {
                      painel = temp + operador;
                    } else
                      painel += "+";
                    temp = "";
                  });
                },
                child: Container(
                  child: Text(
                    "+",
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                  alignment: Alignment.center,
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(214, 255, 143, 51),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ),
            Positioned(
              // Igual/resultado

              top: 500,
              right: 30,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (painel != "") {
                      n1 = retornaResultado(n1);
                      String z = "";
                      for (int i = painel.length - 1; i > 0; i--) {
                        z = painel[i];
                        if (z != "+" && z != "x" && z != "÷") {
                          if (z == "-" && painel[i - 1] == "(" && i > 1) {
                            if (painel[painel.length - 1] != ")") painel += ")";
                          } else {
                            z = "+";
                          }
                        }
                      }
                      particiona(painel);
                      painel.replaceAll("(", "");
                      painel.replaceAll(")", "");
                      n2 = 0;
                      operador = "";
                      ultimo = 0;
                      pos_parentese = -1;
                      esquerdo = true;
                      porcentagem = false;
                    }
                  });
                },
                child: Container(
                  child: Text(
                    "=",
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                  alignment: Alignment.center,
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(214, 255, 143, 51),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ),
            //FIM DOS OPERADORES E INICIO DOS NUMEROS
            Positioned(
              top: 260,
              left: 25,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    painel += "7";
                  });
                },
                child: Container(
                  child: Text(
                    "7",
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                  alignment: Alignment.center,
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 48, 44, 44),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ),

            Positioned(
              top: 260,
              left: 110,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    painel += "8";
                  });
                },
                child: Container(
                  child: Text(
                    "8",
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                  alignment: Alignment.center,
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 48, 44, 44),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ),

            Positioned(
              top: 260,
              left: 195,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    painel += "9";
                  });
                },
                child: Container(
                  child: Text(
                    "9",
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                  alignment: Alignment.center,
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 48, 44, 44),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 340,
              left: 25,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    painel += "4";
                  });
                },
                child: Container(
                  child: Text(
                    "4",
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                  alignment: Alignment.center,
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 48, 44, 44),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ),

            Positioned(
              top: 340,
              left: 110,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    painel += "5";
                  });
                },
                child: Container(
                  child: Text(
                    "5",
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                  alignment: Alignment.center,
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 48, 44, 44),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ),

            Positioned(
              top: 340,
              left: 195,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    painel += "6";
                  });
                },
                child: Container(
                  child: Text(
                    "6",
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                  alignment: Alignment.center,
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 48, 44, 44),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 420,
              left: 25,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    painel += "1";
                  });
                },
                child: Container(
                  child: Text(
                    "1",
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                  alignment: Alignment.center,
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 48, 44, 44),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ),

            Positioned(
              top: 420,
              left: 110,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    painel += "2";
                  });
                },
                child: Container(
                  child: Text(
                    "2",
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                  alignment: Alignment.center,
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 48, 44, 44),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ),

            Positioned(
              top: 420,
              left: 195,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    painel += "3";
                  });
                },
                child: Container(
                  child: Text(
                    "3",
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                  alignment: Alignment.center,
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 48, 44, 44),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ),

            Positioned(
              top: 500,
              left: 195,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    painel += ",";
                  });
                },
                child: Container(
                  child: Text(
                    ",",
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                  alignment: Alignment.center,
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 48, 44, 44),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 500,
              left: 110,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    painel += "0";
                  });
                },
                child: Container(
                  child: Text(
                    "0",
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                  alignment: Alignment.center,
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 48, 44, 44),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ),
            Positioned(
              //Negativo ou Positivo
              top: 500,
              left: 25,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    String aux = painel;
                    if (painel == "") {
                      painel = "(-";
                    } else
                      painel += "(-";
                    esquerdo = false;
                  });
                },
                child: Container(
                  child: Text(
                    "+/-",
                    style: TextStyle(fontSize: 38, color: Colors.black),
                  ),
                  alignment: Alignment.center,
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 170, 159, 159),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.black,
      ),
    );
  }
}
