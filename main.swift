//
//  main.swift
//  qualificacao
//
//  Created by user on 21/05/23.
//

import Foundation

class Funcionario {
    let name: String
    let cargo: String
    let salario: Double
    let id: Int
    
    init(name: String, cargo: String, salario: Double, id: Int) {
        self.name = name
        self.cargo = cargo
        self.id = id
        self.salario = salario
    }
}

class Empresa {
    var funcionarios: [Funcionario] = []
    
    func addFuncionario() {
        print("\n-- Cadastro de funcionário --")
        
        var name: String = ""
        var cargo: String = ""
        var salario: Double = 0.0
        
        var tentativas: Int = 0
        while tentativas < 3 {
            print("Digite o nome do funcionário: ")
            if let input = readLine(), !input.isEmpty {
                if funcionarios.contains(where: {$0.name == input}) {
                    print("Já existe funcionário com este nome")
                    tentativas += 1
                } else {
                    name = input
                    break
                }
            } else {
                tentativas += 1
                print("Nome necessita ser preenchido, tente novamente!")
            }
        }
        
        if(tentativas == 3) {
            print("Excesso de tentativas. Encerrando o programa!")
            return
        }
        
        tentativas = 0
        while tentativas < 3 {
            print("Digite o cargo do funcionário")
            if let input = readLine(), !input.isEmpty {
                cargo = input
                break
            } else {
                tentativas += 1
                print("Cargo necessita ser preenchido, tente novamente!")
            }
        }
        
        if(tentativas == 3) {
            print("Excesso de tentativas. Encerrando o programa!")
            return
        }
        
        tentativas = 0
        while tentativas < 3 {
            print("Digite o salario do funionário")
            if let input = readLine(), let inputDouble = Double(input), inputDouble > 0 {
                salario = inputDouble
                break
            } else {
                tentativas += 1
                print("Salário necessita ser preenchido, tente novamente!")
            }
        }
        
        var id = generateRandomId()
        while funcionarios.contains(where: {$0.id == id}) {
            id = generateRandomId()
        }
        let funcionario = Funcionario(name: name, cargo: cargo, salario: salario, id: id)
        funcionarios.append(funcionario)
        print("\n-- Funionário adicionado com sucesso! --\n")
    }
    
    func generateRandomId() -> Int{
        let min = 1000
        let max = 9999
        return Int.random(in: min...max)
    }
    
    func listarFuncionarios() {
        print("\n-- Lista de funcionários --\n")
        
        if funcionarios.isEmpty {
            print("Sem funcionarios")
        } else {
            for funcionario in funcionarios {
                print("Id: \(funcionario.id) Nome: \(funcionario.name) Cargo: \(funcionario.cargo) Salario: \(funcionario.salario)")
            }
        }
    }
    
    func excluirFuncionario() {
        print("\n-- Exclusão de funcionários --\n")
        listarFuncionarios()
        print("\n-- Digite o Id do funcionário que deseja excluir --\n")
        if let input = readLine(), let id = Int(input) {
            if let index = funcionarios.firstIndex(where: {$0.id == id}) {
                funcionarios.remove(at: index)
                print("\nFuncionario exlcuido com sucesso!\n")
                listarFuncionarios()
            } else {
                print("\nFuncionário não encontrado!\n")
            }
        } else {
            print("Id inválido, tente novamente!")
        }
    }
        
    func showMenu() {
        var fim: Bool = false
        
        repeat {
            print("\n1. Cadastrar funcionários\n")
            print("\n2. Listar funcionários\n")
            print("\n3. Excluir funcionários\n")
            print("\n4. Fim\n")
            print("\nDigite o numero da opção desejada\n")
            
            if let escolha: String = readLine(), let opcao: Int = Int(escolha){
                switch(opcao) {
                case 1:
                    addFuncionario()
                case 2:
                    listarFuncionarios()
                case 3:
                    excluirFuncionario()
                case 4:
                    fim = true
                default:
                    print("\nOpção inválida.\n")
                }
            } else {
                print("\nOpção inválida.\n")
            }
        } while !fim
    }
}

func main() {
    let empresa = Empresa()
    empresa.showMenu()
}

main()
