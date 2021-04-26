package com.furb.devmobile.Entity.Carro;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import java.util.Date;

@Entity
public class CarroEntity {

    @Id
    @GeneratedValue
    private Long id;

    private String nome;

    private String marca;

    private Integer anoDeFabricacao;

    public CarroEntity() {
    }

    public CarroEntity(String nome, String marca, Integer anoDeFabricacao) {
        this.nome = nome;
        this.marca = marca;
        this.anoDeFabricacao = anoDeFabricacao;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getMarca() {
        return marca;
    }

    public void setMarca(String marca) {
        this.marca = marca;
    }

    public Integer getAnoDeFabricacao() {
        return anoDeFabricacao;
    }

    public void setAnoDeFabricacao(Integer anoDeFabricacao) {
        this.anoDeFabricacao = anoDeFabricacao;
    }

    public Long getId() {
        return this.id;
    }
}
