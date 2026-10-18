#ifndef CALCULADORA_H
#define CALCULADORA_H

#include <QObject>
#include <QtQml/qqmlregistration.h>
#include "pilha.h"
struct number {
    float value = 0.0f;
    int decimal_cont = 1;
};
class Calculadora : public QObject
{
    Q_OBJECT
    QML_ELEMENT

public:
    explicit Calculadora(QObject *parent = nullptr);

    Q_INVOKABLE QString calculo(const QString &entrada);

private:
    QString expressao;
    bool eh_numero(char caractere) const;
    bool eh_operador(char caractere) const;
    bool eh_chave(char caractere) const;
    bool valido();
    bool finalizado();
    void resolver_chaves(Pilha &pilha);
    float calculo(number &num1, number &num2, char operador);

};

#endif