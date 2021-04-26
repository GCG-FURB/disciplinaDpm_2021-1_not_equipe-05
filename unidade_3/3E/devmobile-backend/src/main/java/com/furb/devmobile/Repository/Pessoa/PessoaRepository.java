package com.furb.devmobile.Repository.Pessoa;

import com.furb.devmobile.Entity.Pessoa.PessoaEntity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PessoaRepository extends CrudRepository<PessoaEntity, Long> {
}
