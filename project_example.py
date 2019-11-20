'''
Considere um programa cujo objetivo é o armazenamento temporário de valores inteiros em uma lista
cujo tamanho é solicitado ao usuário. O programa
deve fornecer suporte às seguintes funcionalidades:
     1- adicionar elementos
     2- recuperar um elemento em uma dada posição
     3- imprimir os elementos da lista
     4- deletar o elemento de uma posição fornecida pelo usuário
     5- encerrar a aplicação

A aplicação deve ser encerrada apenas no cenário em que o usuário fornecer a opção adequada de saída.

Caso o usuário forneça um valor distinto das opções supracitadas o programa deve informar ao usuário e solicitar nova opção.
'''
def main():
    lista = []
    tamMax = int(input("Informe o tamanho máximo de elementos: "))
    while True:
        print("1 - Adicionar elemento")
        print("2 - Recuperar elemento")
        print("3 - Imprimir lista")
        print("4 - Deletar elemento")
        print("5 - Sair")
        opcao = int(input("opcao > "))
        if opcao == 1:
            if tamMax == len(lista):
                print("Lista cheia! Ignorando ação!")
            else:
                valor = int(input("valor > "))
                lista.append(valor)
        elif opcao == 2:
            indice = int(input("posicao > "))
            if indice < 0 or indice >= len(lista):
                print("Indice invalido!")
            else:
                print("Valor recuperado: " + str(lista[indice]))
        elif opcao == 3:
            if len(lista) == 0:
                print("Lista vazia!")
            else:
                for i in lista:
                    print(i)
        elif opcao == 4:
            indice = int(input("posicao > "))
            if indice < 0 or indice >= len(lista):
                print("Indice invalido!")
            else:
                del lista[indice]
                print("Elemento removido!")
        elif opcao == 5:
            break
        else:
            print("Opcao Invalida! Tente novamente!")

    print("Encerrando aplicação!")
main()
