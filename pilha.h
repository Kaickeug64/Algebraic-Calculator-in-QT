#ifndef PILHA_H
#define PILHA_H

class Pilha
{
private:
    int tam;
    int capacidade;
    char* conteudo;

    void redimensionar();

public:
    Pilha(int capacidadeInicial = 50);
    ~Pilha();
    bool cheio() const;
    bool vazio() const;
    void pull(char item);
    char pop();
    int size() const;

};
#endif