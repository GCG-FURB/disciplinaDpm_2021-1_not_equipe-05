package com.furb.devmobile.Mapper.Pessoa;

import com.furb.devmobile.DTO.Pessoa.PessoaDTO;
import com.furb.devmobile.Entity.Pessoa.PessoaEntity;
import org.springframework.stereotype.Component;

@Component
public class PessoaMapper {

    public PessoaEntity toEntity(PessoaDTO pessoaDTO) {
        PessoaEntity pessoaEntity = new PessoaEntity();
        pessoaEntity.setNome(pessoaDTO.nome);
        pessoaEntity.setIdade(pessoaDTO.idade);
        pessoaEntity.setCpf(pessoaDTO.cpf);
        return pessoaEntity;
    }

    public PessoaDTO toDTO(PessoaEntity pessoaEntity) {
        PessoaDTO pessoaDTO = new PessoaDTO();
        pessoaDTO.id = pessoaEntity.getId();
        pessoaDTO.nome = pessoaEntity.getNome();
        pessoaDTO.idade = pessoaEntity.getIdade();
        pessoaDTO.cpf = pessoaEntity.getCpf();
        return pessoaDTO;
    }
}
