#include "calculadora.h"
#include "pilha.h"
#include <QString>

Calculadora::Calculadora(QObject *parent)
    : QObject(parent)
{
}

float Calculadora::calculo(number &num1, number &num2, char operador) {
    if (operador == '+') return num1.value + num2.value;
    if (operador == '-') return num1.value - num2.value;
    if (operador == '*') return num1.value * num2.value;
    if (operador == '/') return (num2.value != 0.0f) ? (num1.value / num2.value) : 0.0f;
    return 0.0f;
}

static int precedencia(char op) {
    if (op == '+' || op == '-') return 1;
    if (op == '*' || op == '/') return 2;
    return 0;
}

QString Calculadora::calculo(const QString &entrada) {
    expressao = entrada;
    expressao.replace(" ", "");

    if (!valido()) {
        return "erro";
    }

    Pilha pilha;
    resolver_chaves(pilha);

    return expressao;
}

void Calculadora::resolver_chaves(Pilha &pilha) {
    float valores[100];
    int topo_val = 0;

    char operadores[100];
    int topo_op = 0;

    int i = 0;
    int tam = expressao.size();

    while (i < tam) {
        char c = expressao[i].toLatin1();

        bool eh_negativo = (c == '-' && (i == 0 || expressao[i - 1] == '(' || eh_operador(expressao[i - 1].toLatin1())));

        if (eh_numero(c) || eh_negativo) {
            float val = 0.0f;
            float sinal = 1.0f;

            if (eh_negativo) {
                sinal = -1.0f;
                i++;
            }

            while (i < tam && expressao[i].toLatin1() >= '0' && expressao[i].toLatin1() <= '9') {
                val = val * 10.0f + (expressao[i].toLatin1() - '0');
                i++;
            }

            if (i < tam && expressao[i].toLatin1() == '.') {
                i++;
                float divisor = 10.0f;
                while (i < tam && expressao[i].toLatin1() >= '0' && expressao[i].toLatin1() <= '9') {
                    val += (expressao[i].toLatin1() - '0') / divisor;
                    divisor *= 10.0f;
                    i++;
                }
            }

            valores[topo_val++] = val * sinal;
            continue;
        }
        else if (c == '(') {
            operadores[topo_op++] = c;
        }
        else if (c == ')') {
            while (topo_op > 0 && operadores[topo_op - 1] != '(') {
                if (topo_val < 2) {
                    expressao = "erro";
                    return;
                }
                number n2 = {valores[--topo_val], 1};
                number n1 = {valores[--topo_val], 1};
                char op = operadores[--topo_op];

                valores[topo_val++] = calculo(n1, n2, op);
            }
            if (topo_op > 0) topo_op--;
        }
        else if (eh_operador(c)) {
            while (topo_op > 0 && precedencia(operadores[topo_op - 1]) >= precedencia(c)) {
                if (topo_val < 2) {
                    expressao = "erro";
                    return;
                }
                number n2 = {valores[--topo_val], 1};
                number n1 = {valores[--topo_val], 1};
                char op = operadores[--topo_op];

                valores[topo_val++] = calculo(n1, n2, op);
            }
            operadores[topo_op++] = c;
        }
        i++;
    }

    while (topo_op > 0) {
        if (topo_val < 2) {
            expressao = "erro";
            return;
        }
        number n2 = {valores[--topo_val], 1};
        number n1 = {valores[--topo_val], 1};
        char op = operadores[--topo_op];

        valores[topo_val++] = calculo(n1, n2, op);
    }

    if (topo_val == 1) {
        expressao = QString::number(valores[0]);
    } else {
        expressao = "erro";
    }
}

bool Calculadora::finalizado() {
    if (expressao.isEmpty()) return false;
    int inicio = (expressao[0] == '-') ? 1 : 0;
    for (int i = inicio; i < expressao.size(); i++) {
        if (!eh_numero(expressao[i].toLatin1())) {
            return false;
        }
    }
    return true;
}

bool Calculadora::valido() {
    if (expressao.isEmpty()) return false;

    int parenteses = 0;
    for (int i = 0; i < expressao.size(); i++) {
        char c = expressao[i].toLatin1();

        if (!eh_numero(c) && !eh_operador(c) && !eh_chave(c) && c != ' ')
            return false;

        if (c == '(') parenteses++;
        if (c == ')') parenteses--;
        if (parenteses < 0) return false;
    }

    return parenteses == 0;
}

bool Calculadora::eh_operador(char caractere) const {
    return (caractere == '*' || caractere == '/' || caractere == '+' || caractere == '-');
}

bool Calculadora::eh_chave(char caractere) const {
    return (caractere == '(' || caractere == ')');
}

bool Calculadora::eh_numero(char caractere) const {
    return (caractere >= '0' && caractere <= '9') || caractere == '.';
}