#include "pilha.h"

Pilha::Pilha(int capacidadeInicial){
    capacidade = capacidadeInicial;
    tam = 0;
    conteudo = new char(capacidadeInicial);
}
Pilha::~Pilha(){
    delete conteudo;
}
bool Pilha::cheio() const{
    return (capacidade == tam-1);
}
bool Pilha::vazio() const{
    return (tam ==0);
}
int Pilha::size() const{
    return tam;
}
char Pilha::pop(){
    char temporario =' ';
    if(!vazio()){
        tam--;
        temporario = conteudo[tam];
        conteudo[tam] = ' ';
    }else{

    }
    return temporario;
}
void Pilha::pull(char item){
    if(!cheio()){
        conteudo[tam] = item;
        tam++;
    }else{
        redimensionar();
        pull(item);
    }
}

void Pilha::redimensionar(){
    //implementar
}
