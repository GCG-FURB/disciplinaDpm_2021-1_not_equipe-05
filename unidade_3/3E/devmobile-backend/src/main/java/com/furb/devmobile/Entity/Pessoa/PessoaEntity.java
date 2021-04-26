package com.furb.devmobile.Entity.Pessoa;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
public class PessoaEntity {

    @Id
    @GeneratedValue
    private Long id;

    private String nome;

    private Integer idade;

    private String cpf;

    public PessoaEntity() {
    }

    public PessoaEntity(String nome, Integer idade, String cpf) {
        this.nome = nome;
        this.idade = idade;
        this.cpf = cpf;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public Integer getIdade() {
        return idade;
    }

    public void setIdade(Integer idade) {
        this.idade = idade;
    }

    public String getCpf() {
        return cpf;
    }

    public void setCpf(String cpf) {
        this.cpf = cpf;
    }

    public Long getId() {
        return this.id;
    }
}
