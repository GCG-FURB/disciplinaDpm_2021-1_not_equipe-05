package com.furb.devmobile.Service.Pessoa;

import com.furb.devmobile.DTO.Pessoa.PessoaDTO;
import com.furb.devmobile.Entity.Pessoa.PessoaEntity;
import com.furb.devmobile.Mapper.Pessoa.PessoaMapper;
import com.furb.devmobile.Repository.Pessoa.PessoaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class PessoaService {

    @Autowired
    public PessoaMapper pessoaMapper;

    @Autowired
    public PessoaRepository pessoaRepository;

    public PessoaEntity newPerson(PessoaDTO newPerson) {
        PessoaEntity pessoaEntity = pessoaMapper.toEntity(newPerson);
        return pessoaRepository.save(pessoaEntity);
    }

    public List<PessoaDTO> all() {
        List<PessoaEntity> all = (List<PessoaEntity>) pessoaRepository.findAll();
        List<PessoaDTO> pessoaDTOS = new ArrayList<>();
        all.forEach(pessoaEntity -> {
            pessoaDTOS.add(pessoaMapper.toDTO(pessoaEntity));
        });
        return pessoaDTOS;
    }
}
